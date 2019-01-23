;;; Package --- Summary
;;; Common settings and useful functions

(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1)

  (setq-default line-spacing 2)
  (set-face-attribute 'default nil
    :family "Meslo LG S"
    :height 140
    :weight 'normal
    :width 'normal))


(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving


(setq inhibit-startup-screen t)


;;; deal with whitespaces
(setq-default indent-tabs-mode nil)
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


(defun dt-map-keys (@keymap-name @key-cmd-alist)
  "Define keys in a declarative way."
  (interactive)
  (mapc
    (lambda ($pair)
      (define-key @keymap-name (kbd (car $pair)) (cdr $pair)))
    @key-cmd-alist))


(defvar dt-project-root '(".git" "package.json")
  "The list of files located in the project's root folder.
Used to determine whether its a root folder or not.")

(defun dt-dirname (dirname)
  (file-name-directory
    (directory-file-name
      (expand-file-name dirname))))

(defun dt-project-root-p (dirname)
  (cl-loop for pj-dir in dt-project-root
    thereis (file-exists-p
              (concat dirname "/" pj-dir))))

(defun dt-project-dir (dirname)
  (let ((dir dirname)
         (found nil)
         (i 0))
    (while (and (< i 5) (null found)) ; Check max depth, add check for the root folder "/" @todo
      (progn
        (if (dt-project-root-p dir)
          (setq found t)
          (setq dir (dt-dirname dir)))
        (setq i (1+ i))))
    (if found dir dirname)))
