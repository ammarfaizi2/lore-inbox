Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWACNc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWACNc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWACNcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:32:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38149 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932351AbWACNZg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:36 -0500
Subject: [PATCH 07/26] kconfig: make lxdialog/menubox.c more readable
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947251062@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1132526075 +0100

Utilising a small macro for print_item made wonders for readability
for this file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/lxdialog/menubox.c |   42 ++++++++++++++++++------------------------
 1 files changed, 18 insertions(+), 24 deletions(-)

59d3cf7a40dfdbb8e86758ade172831c19630050
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index 461ee08..d0bf32b 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -64,8 +64,8 @@ static int menu_width;
 /*
  * Print menu item
  */
-static void print_item(WINDOW * win, const char *item, int choice,
-		       int selected, int hotkey)
+static void do_print_item(WINDOW * win, const char *item, int choice,
+                          int selected, int hotkey)
 {
 	int j;
 	char *menu_item = malloc(menu_width + 1);
@@ -99,6 +99,12 @@ static void print_item(WINDOW * win, con
 	wrefresh(win);
 }
 
+#define print_item(index, choice, selected) \
+do {\
+	int hotkey = (items[(index) * 2][0] != ':'); \
+	do_print_item(menu, items[(index) * 2 + 1], choice, selected, hotkey); \
+} while (0)
+
 /*
  * Print the scroll indicators.
  */
@@ -251,9 +257,7 @@ int dialog_menu(const char *title, const
 
 	/* Print the menu */
 	for (i = 0; i < max_choice; i++) {
-		print_item(menu, items[(first_item + i) * 2 + 1], i,
-			   i == choice,
-			   (items[(first_item + i) * 2][0] != ':'));
+		print_item(first_item + i, i, i == choice);
 	}
 
 	wnoutrefresh(menu);
@@ -292,34 +296,27 @@ int dialog_menu(const char *title, const
 		    key == '-' || key == '+' ||
 		    key == KEY_PPAGE || key == KEY_NPAGE) {
 			/* Remove highligt of current item */
-			print_item(menu, items[(scroll + choice) * 2 + 1],
-				   choice, FALSE,
-				   (items[(scroll + choice) * 2][0] != ':'));
+			print_item(scroll + choice, choice, FALSE);
 
 			if (key == KEY_UP || key == '-') {
 				if (choice < 2 && scroll) {
 					/* Scroll menu down */
 					do_scroll(menu, &scroll, -1);
 
-					print_item(menu, items[scroll * 2 + 1], 0, FALSE,
-						   (items[scroll * 2][0] != ':'));
+					print_item(scroll, 0, FALSE);
 				} else
 					choice = MAX(choice - 1, 0);
 
 			} else if (key == KEY_DOWN || key == '+') {
-
-				print_item(menu,
-					   items[(scroll + choice) * 2 + 1], choice, FALSE,
-					   (items[(scroll + choice) * 2][0] != ':'));
+				print_item(scroll+choice, choice, FALSE);
 
 				if ((choice > max_choice - 3) &&
 				    (scroll + max_choice < item_no)) {
 					/* Scroll menu up */
 					do_scroll(menu, &scroll, 1);
 
-					print_item(menu, items[(scroll + max_choice - 1) * 2 + 1],
-						   max_choice - 1, FALSE,
-						   (items [(scroll + max_choice - 1) * 2][0] != ':'));
+					print_item(scroll+max_choice - 1,
+						   max_choice - 1, FALSE);
 				} else
 					choice = MIN(choice + 1, max_choice - 1);
 
@@ -328,8 +325,7 @@ int dialog_menu(const char *title, const
 				for (i = 0; (i < max_choice); i++) {
 					if (scroll > 0) {
 						do_scroll(menu, &scroll, -1);
-						print_item(menu, items[scroll * 2 + 1], 0, FALSE,
-							   (items[scroll * 2][0] != ':'));
+						print_item(scroll, 0, FALSE);
 					} else {
 						if (choice > 0)
 							choice--;
@@ -340,9 +336,8 @@ int dialog_menu(const char *title, const
 				for (i = 0; (i < max_choice); i++) {
 					if (scroll + max_choice < item_no) {
 						do_scroll(menu, &scroll, 1);
-						print_item(menu, items[(scroll + max_choice - 1) * 2 + 1],
-							   max_choice - 1, FALSE,
-							   (items [(scroll + max_choice - 1) * 2][0] != ':'));
+						print_item(scroll+max_choice-1,
+							   max_choice - 1, FALSE);
 					} else {
 						if (choice + 1 < max_choice)
 							choice++;
@@ -351,8 +346,7 @@ int dialog_menu(const char *title, const
 			} else
 				choice = i;
 
-			print_item(menu, items[(scroll + choice) * 2 + 1],
-				   choice, TRUE, (items[(scroll + choice) * 2][0] != ':'));
+			print_item(scroll + choice, choice, TRUE);
 
 			print_arrows(dialog, item_no, scroll,
 				     box_y, box_x + ITEM_IDENT + 1, menu_height);
-- 
1.0.6

