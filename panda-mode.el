;;; panda-mode.el --- A major mode for the Panda programming language -*- lexical-binding: t -*-

;; Version: 0.0.1
;; Author: XXIV
;; Keywords: files, panda
;; Package-Requires: ((emacs "24.3"))
;; Homepage: https://github.com/thechampagne/panda-mode

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A major mode for the Panda programming language.

;;;; Installation

;; You can use built-in package manager (package.el) or do everything by your hands.

;;;;; Using package manager

;; Add the following to your Emacs config file

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)

;; Then use `M-x package-install RET panda-mode RET` to install the mode.
;; Use `M-x panda-mode` to change your current mode.

;;;;; Manual

;; Download the mode to your local directory.  You can do it through `git clone` command:

;; git clone git://github.com/thechampagne/panda-mode.git

;; Then add path to panda-mode to load-path list — add the following to your Emacs config file

;; (add-to-list 'load-path
;; 	     "/path/to/panda-mode/")
;; (require 'panda-mode)

;; Use `M-x panda-mode` to change your current mode.

;;; Code:

(defconst panda-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    (modify-syntax-entry ?\' "\"" table)
    (modify-syntax-entry ?\" "\"" table)
    table))


(defconst panda-keywords
  '("main" "new" "log" "module"
    "require" "import" "export"
    "mut" "nil" "late" "if" "else"
    "loop" "for" "foreach" "while"
    "return" "continue" "break"
    "throw" "try" "catch" "type"
    "open" "shared" "internal"
    "constructor" "this" "static"
    "base" "interface" "override"))


(defconst panda-data-types
  '("Int" "Float" "Byte" "Short"
    "Long" "Double" "String" "Bool"))


(defconst panda-operators
  '(;; Arithmetic Operators
    "+" "-" "*" "/" "%"
    "++" "--"

    ;; Assignment Operators
    "=" "+=" "-=" "*="
    "/="

    ;; Comparison Operators
    "==" "!=" ">" "<"
    ">=" "<="

    ;; Logical Operators
    "&&" "||" "!"))


(defconst panda-constants
  '("true" "false" "null"))


(defconst panda-font-lock-keywords
  (list
   `(,(regexp-opt panda-constants 'words) . font-lock-constant-face)
   `(,(regexp-opt panda-data-types 'words) . font-lock-type-face)
   `(,(regexp-opt panda-keywords 'symbols) . font-lock-keyword-face)
   `("type[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>" . (1 font-lock-type-face))
   `("type[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)[[:space:]]*:[[:space:]]*\\(\\([a-zA-Z0-9_]*\\)\\([[:space:]]*,[[:space:]]*[a-zA-Z0-9_]*\\)*\\)\\>" (1 font-lock-type-face) (2 font-lock-type-face))
   `("interface[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>" . (1 font-lock-type-face))
   `(")[[:space:]]*->[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>" . (1 font-lock-type-face))
   `("\\<\\([a-zA-Z0-9_]*\\)\\>[[:space:]]*(" . (1 font-lock-function-name-face))
   `(,(regexp-opt panda-operators) . font-lock-builtin-face)))

;;;###autoload
(define-derived-mode panda-mode prog-mode "Panda"
  "A major mode for the Panda programming language."
  :syntax-table panda-mode-syntax-table
  (setq-local font-lock-defaults '(panda-font-lock-keywords)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.panda\\'" . panda-mode))

(provide 'panda-mode)

;;; panda-mode.el ends here
