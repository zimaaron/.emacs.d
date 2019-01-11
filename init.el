;; setup package stuffs
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;;

;; set location of elisp code I want to use (minor modes)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes
   (quote
    ("3629b62a41f2e5f84006ff14a2247e679745896b5eaa1d5bcfbc904a3441b0cd" "6ee6f99dc6219b65f67e04149c79ea316ca4bcd769a9e904030d38908fd7ccf9" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "c567c85efdb584afa78a1e45a6ca475f5b55f642dfcd6277050043a568d1ac6f" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569" "1a53efc62256480d5632c057d9e726b2e64714d871e23e43816735e1b85c144c" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "345f8f92edc3508574c61850b98a2e0a7a3f5ba3bb9ed03a50f6e41546fe2de0" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#49483E" . 100))))
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(magit-diff-use-overlays nil)
 '(org-agenda-files (quote ("~/Documents/Org/ihme.org")))
 '(package-selected-packages
   (quote
    (isend-mode ess auto-complete auto-complete-auctex autopair color-theme color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow color-theme-solarized darkokai-theme electric-operator fic-mode gh git-commit ht logito magit magit-gh-pulls magit-popup monochrome-theme monokai-theme pcache popup rfringe s with-editor async auctex)))
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(recentf-max-menu-items 50)
 '(save-place-mode t nil (saveplace))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "outline" :slant normal :weight normal :height 113 :width normal))))
 '(comint-highlight-input ((t (:weight thin))))
 '(scroll-bar ((t (:foreground "dark slate gray"))))
 '(show-paren-match ((t (:background "cyan" :inverse-video nil)))))

;; turn on auto complete. woo!!
(require 'auto-complete)
(global-auto-complete-mode t)

;; turn on matching pairs mode
(electric-pair-mode 1)

;; turn on good spacing around operators
(require 'electric-operator)
(add-hook 'ess-mode-hook #'electric-operator-mode)
(setq electric-operator-R-named-argument-style '(unspaced))

;; add in custom spacing rules
(electric-operator-add-rules-for-mode 'ess-mode
  (cons ":=" " := "))

;; change ess indenting to depth of 2
(defun myindent-ess-hook ()
  (setq ess-indent-level 2))
(add-hook 'ess-mode-hook 'myindent-ess-hook)

;; to avoid continued indenting (esp. with ggplot)
(add-hook 'ess-mode-hook
          (lambda ()
            (setq ess-first-continued-statement-offset 2)
            (setq ess-continued-statement-offset 0)))

;; fix indenting with only 1 # (it defaults to space 40!)
(setq ess-fancy-comments nil)

;; turn off underscore to <-
;; turn on ; to <-
(require 'ess-site)
(global-set-key (kbd "C-;")  (lambda () (interactive) (insert " <- ")))
;; ;; leave my underscore key alone! need it twice ...
(ess-toggle-underscore nil)
(ess-toggle-underscore nil)

;; Set default R version, (i.e. the one launched by typing M-x R <RET>)
(setq inferior-R-program-name "/usr/local/bin/R")


;; fast switch between windows
(global-set-key [C-tab] 'other-window)

;; fast commenting/uncommenting
;; (global-set-key (kbd "M-\-") 'comment-dwim)

;; ;; Control and up/down arrow keys to search history with matching what you've already typed
;; (define-key comint-mode-map [C-up] 'comint-previous-matching-input-from-input)
;; (define-key comint-mode-map [C-down] 'comint-next-matching-input-from-input)

;; turn on recent files with C-x C-r
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; THIS COMMENTED PART WORKED ON WINDOWS 10
;; turn off underscore to <-
;; turn on ; to <-
;; (require 'ess-site)
;; (setq ess-smart-S-assign-key (kbd ";"))
;; (ess-toggle-S-assign-key t) ; enable above key definition
;; ;; leave my underscore key alone! need it twice ...
;; (ess-toggle-underscore nil)
;; (ess-toggle-underscore nil)

;; turn on TODO/FIXME highlighting
;; I want this ALWAYS turned on so I turn it into a global minor mode
(define-globalized-minor-mode my-global-fic-mode fic-mode
  (lambda () (fic-mode 1)))
;; turn on global-fic-mode
(my-global-fic-mode 1)

;; turn on fixme to highlight TODOs, FIXMEs, ...
;; this one has fringe highlighting!
;; AOZ customized this and the modified minor-mode should sit in ~/.emacs.d/elisp/
;;(require 'myfixme)
;;(defun turn-on-myfixme-mode ()
;;   (myfixme-mode 1))
;;(add-hook 'ess-mode-hook 'turn-on-myfixme-mode)

;; AOZ: this next one is no longer used and I use myfixme instead
;; turn on fixme highlighting
;;(require 'fic-mode)
;;(add-hook 'ess-mode-hook 'turn-on-fic-mode)

;; set directory
(cd "~/Documents/GitRepos/")

;; set replace-string keyboard binding
(global-set-key (kbd "M-r") 'replace-string)

;; set PATH for mac auctex to work
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))  
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))

;; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; tell emacs where to find ispell (for use in flyspell)
(setq ispell-program-name "/usr/local/bin/ispell")

;; Set transparency of selected and unselected frames
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
 ;;(set-frame-parameter (selected-frame) 'alpha <both>)
 (set-frame-parameter (selected-frame) 'alpha '(93 . 90))
 (add-to-list 'default-frame-alist '(alpha . (93 . 90)))


;; set up base GIT use in emacs
;; TODO: make this work on mac
;;(add-to-list 'exec-path "C:/Users/azimmer/AppData/Local/GitHub/PortableGit_d76a6a98c9315931ec4927243517bc09e9b731a0/cmd/")
;;(add-to-list 'load-path "C:/Users/azimmer/Documents/HOME/git_emacs")
;;  (require 'git)
;;  (require 'git-blame)

;; setup isend so we can easily copy code from a buffer and paste it into a terminal buffer!
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/"))
(put 'downcase-region 'disabled nil)


;; org-mode global key bindings
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
