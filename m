Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVGMRMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVGMRMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGMRJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:09:37 -0400
Received: from mta01.mail.t-online.hu ([195.228.240.50]:34246 "EHLO
	mta01.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261583AbVGMRJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:09:21 -0400
Subject: [PATCH 3/19] Kconfig I18N: lxdialog
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:09:14 +0200
Message-Id: <1121274554.2975.14.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I18N support for buttons in lxdialog.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/POTFILES.in  |    8 ++++++++
 scripts/lxdialog/checklist.c |    4 ++--
 scripts/lxdialog/dialog.h    |    5 +++++
 scripts/lxdialog/inputbox.c  |    4 ++--
 scripts/lxdialog/lxdialog.c  |   10 +++-------
 scripts/lxdialog/menubox.c   |    6 +++---
 scripts/lxdialog/msgbox.c    |    2 +-
 scripts/lxdialog/textbox.c   |    2 +-
 scripts/lxdialog/yesno.c     |    4 ++--
 9 files changed, 27 insertions(+), 18 deletions(-)

diff -puN scripts/kconfig/POTFILES.in~kconfig-i18n-03-lxdialog-i18n scripts/kconfig/POTFILES.in
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/POTFILES.in~kconfig-i18n-03-lxdialog-i18n	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/POTFILES.in	2005-07-13 18:36:54.000000000 +0200
@@ -1,3 +1,11 @@
+scripts/lxdialog/checklist.c
+scripts/lxdialog/inputbox.c
+scripts/lxdialog/lxdialog.c
+scripts/lxdialog/menubox.c
+scripts/lxdialog/msgbox.c
+scripts/lxdialog/textbox.c
+scripts/lxdialog/util.c
+scripts/lxdialog/yesno.c
 scripts/kconfig/mconf.c
 scripts/kconfig/conf.c
 scripts/kconfig/confdata.c
diff -puN scripts/lxdialog/checklist.c~kconfig-i18n-03-lxdialog-i18n scripts/lxdialog/checklist.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/checklist.c~kconfig-i18n-03-lxdialog-i18n	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/checklist.c	2005-07-13 18:37:03.000000000 +0200
@@ -109,8 +109,8 @@ print_buttons( WINDOW *dialog, int heigh
     int x = width / 2 - 11;
     int y = height - 2;
 
-    print_button (dialog, "Select", y, x, selected == 0);
-    print_button (dialog, " Help ", y, x + 14, selected == 1);
+    print_button (dialog, _("Select"), y, x, selected == 0);
+    print_button (dialog, _(" Help "), y, x + 14, selected == 1);
 
     wmove(dialog, y, x+1 + 14*selected);
     wrefresh (dialog);
diff -puN scripts/lxdialog/dialog.h~kconfig-i18n-03-lxdialog-i18n scripts/lxdialog/dialog.h
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/dialog.h~kconfig-i18n-03-lxdialog-i18n	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/dialog.h	2005-07-13 18:37:03.000000000 +0200
@@ -25,6 +25,11 @@
 #include <ctype.h>
 #include <stdlib.h>
 #include <string.h>
+#include <libintl.h>
+
+#define _(str) gettext(str)
+#define PACKAGE "linux"
+#define LOCALEDIR ".locale"
 
 #ifdef __sun__
 #define CURS_MACROS
diff -puN scripts/lxdialog/inputbox.c~kconfig-i18n-03-lxdialog-i18n scripts/lxdialog/inputbox.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/inputbox.c~kconfig-i18n-03-lxdialog-i18n	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/inputbox.c	2005-07-13 18:37:03.000000000 +0200
@@ -32,8 +32,8 @@ print_buttons(WINDOW *dialog, int height
     int x = width / 2 - 11;
     int y = height - 2;
 
-    print_button (dialog, "  Ok  ", y, x, selected==0);
-    print_button (dialog, " Help ", y, x + 14, selected==1);
+    print_button (dialog, _("  Ok  "), y, x, selected==0);
+    print_button (dialog, _(" Help "), y, x + 14, selected==1);
 
     wmove(dialog, y, x+1+14*selected);
     wrefresh(dialog);
diff -puN scripts/lxdialog/lxdialog.c~kconfig-i18n-03-lxdialog-i18n scripts/lxdialog/lxdialog.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/lxdialog.c~kconfig-i18n-03-lxdialog-i18n	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/lxdialog.c	2005-07-13 18:32:16.000000000 +0200
@@ -49,19 +49,15 @@ static struct Mode modes[] =
 
 static struct Mode *modePtr;
 
-#ifdef LOCALE
-#include <locale.h>
-#endif
-
 int
 main (int argc, const char * const * argv)
 {
     int offset = 0, opt_clear = 0, end_common_opts = 0, retval;
     const char *title = NULL;
 
-#ifdef LOCALE
-    (void) setlocale (LC_ALL, "");
-#endif
+    setlocale (LC_ALL, "");
+    bindtextdomain (PACKAGE, LOCALEDIR);
+    textdomain (PACKAGE);
 
 #ifdef TRACE
     trace(TRACE_CALLS|TRACE_UPDATE);
diff -puN scripts/lxdialog/menubox.c~kconfig-i18n-03-lxdialog-i18n scripts/lxdialog/menubox.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/menubox.c~kconfig-i18n-03-lxdialog-i18n	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/menubox.c	2005-07-13 18:37:03.000000000 +0200
@@ -151,9 +151,9 @@ print_buttons (WINDOW *win, int height, 
     int x = width / 2 - 16;
     int y = height - 2;
 
-    print_button (win, "Select", y, x, selected == 0);
-    print_button (win, " Exit ", y, x + 12, selected == 1);
-    print_button (win, " Help ", y, x + 24, selected == 2);
+    print_button (win, _("Select"), y, x, selected == 0);
+    print_button (win, _(" Exit "), y, x + 12, selected == 1);
+    print_button (win, _(" Help "), y, x + 24, selected == 2);
 
     wmove(win, y, x+1+12*selected);
     wrefresh (win);
diff -puN scripts/lxdialog/msgbox.c~kconfig-i18n-03-lxdialog-i18n scripts/lxdialog/msgbox.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/msgbox.c~kconfig-i18n-03-lxdialog-i18n	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/msgbox.c	2005-07-13 18:37:04.000000000 +0200
@@ -68,7 +68,7 @@ dialog_msgbox (const char *title, const 
 	wattrset (dialog, dialog_attr);
 	waddch (dialog, ACS_RTEE);
 
-	print_button (dialog, "  Ok  ",
+	print_button (dialog, _("  Ok  "),
 		      height - 2, width / 2 - 4, TRUE);
 
 	wrefresh (dialog);
diff -puN scripts/lxdialog/textbox.c~kconfig-i18n-03-lxdialog-i18n scripts/lxdialog/textbox.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/textbox.c~kconfig-i18n-03-lxdialog-i18n	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/textbox.c	2005-07-13 18:37:04.000000000 +0200
@@ -120,7 +120,7 @@ dialog_textbox (const char *title, const
 	waddstr (dialog, (char *)title);
 	waddch (dialog, ' ');
     }
-    print_button (dialog, " Exit ", height - 2, width / 2 - 4, TRUE);
+    print_button (dialog, _(" Exit "), height - 2, width / 2 - 4, TRUE);
     wnoutrefresh (dialog);
     getyx (dialog, cur_y, cur_x);	/* Save cursor position */
 
diff -puN scripts/lxdialog/yesno.c~kconfig-i18n-03-lxdialog-i18n scripts/lxdialog/yesno.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/yesno.c~kconfig-i18n-03-lxdialog-i18n	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/yesno.c	2005-07-13 18:37:04.000000000 +0200
@@ -30,8 +30,8 @@ print_buttons(WINDOW *dialog, int height
     int x = width / 2 - 10;
     int y = height - 2;
 
-    print_button (dialog, " Yes ", y, x, selected == 0);
-    print_button (dialog, "  No  ", y, x + 13, selected == 1);
+    print_button (dialog, _(" Yes "), y, x, selected == 0);
+    print_button (dialog, _("  No  "), y, x + 13, selected == 1);
 
     wmove(dialog, y, x+1 + 13*selected );
     wrefresh (dialog);
_


