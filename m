Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWACNeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWACNeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWACNdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:33:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25349 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932328AbWACNZe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:34 -0500
Subject: [PATCH 05/26] kconfig: Left aling menu items in menuconfig
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947252201@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1132522881 +0100

Keeping menu lines on a fixed position creates less visual
noise when navigating the menus.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/lxdialog/menubox.c |   30 +++++++++++-------------------
 1 files changed, 11 insertions(+), 19 deletions(-)

0e175d05a4e72f85918da3ea4bd9f5d3d78face4
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index ebfe6a3..89fcf41 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -58,7 +58,8 @@
 
 #include "dialog.h"
 
-static int menu_width, item_x;
+#define ITEM_IDENT 4   /* Indent of menu entries. Fixed for all menus */
+static int menu_width;
 
 /*
  * Print menu item
@@ -86,13 +87,13 @@ static void print_item(WINDOW * win, con
 	wclrtoeol(win);
 #endif
 	wattrset(win, selected ? item_selected_attr : item_attr);
-	mvwaddstr(win, choice, item_x, menu_item);
+	mvwaddstr(win, choice, ITEM_IDENT, menu_item);
 	if (hotkey) {
 		wattrset(win, selected ? tag_key_selected_attr : tag_key_attr);
-		mvwaddch(win, choice, item_x + j, menu_item[j]);
+		mvwaddch(win, choice, ITEM_IDENT + j, menu_item[j]);
 	}
 	if (selected) {
-		wmove(win, choice, item_x + 1);
+		wmove(win, choice, ITEM_IDENT + 1);
 		wrefresh(win);
 	}
 	free(menu_item);
@@ -207,19 +208,10 @@ int dialog_menu(const char *title, const
 	draw_box(dialog, box_y, box_x, menu_height + 2, menu_width + 2,
 		 menubox_border_attr, menubox_attr);
 
-	/*
-	 * Find length of longest item in order to center menu.
-	 * Set 'choice' to default item.
-	 */
-	item_x = 0;
-	for (i = 0; i < item_no; i++) {
-		item_x =
-		    MAX(item_x, MIN(menu_width, strlen(items[i * 2 + 1]) + 2));
+	/* Set choice to default item */
+	for (i = 0; i < item_no; i++)
 		if (strcmp(current, items[i * 2]) == 0)
 			choice = i;
-	}
-
-	item_x = (menu_width - item_x) / 2;
 
 	/* get the scroll info from the temp file */
 	if ((f = fopen("lxdialog.scrltmp", "r")) != NULL) {
@@ -254,10 +246,10 @@ int dialog_menu(const char *title, const
 	wnoutrefresh(menu);
 
 	print_arrows(dialog, item_no, scroll,
-		     box_y, box_x + item_x + 1, menu_height);
+		     box_y, box_x + ITEM_IDENT + 1, menu_height);
 
 	print_buttons(dialog, height, width, 0);
-	wmove(menu, choice, item_x + 1);
+	wmove(menu, choice, ITEM_IDENT + 1);
 	wrefresh(menu);
 
 	while (key != ESC) {
@@ -286,7 +278,7 @@ int dialog_menu(const char *title, const
 		    key == KEY_UP || key == KEY_DOWN ||
 		    key == '-' || key == '+' ||
 		    key == KEY_PPAGE || key == KEY_NPAGE) {
-
+			/* Remove highligt of current item */
 			print_item(menu, items[(scroll + choice) * 2 + 1],
 				   choice, FALSE,
 				   (items[(scroll + choice) * 2][0] != ':'));
@@ -364,7 +356,7 @@ int dialog_menu(const char *title, const
 				   choice, TRUE, (items[(scroll + choice) * 2][0] != ':'));
 
 			print_arrows(dialog, item_no, scroll,
-				     box_y, box_x + item_x + 1, menu_height);
+				     box_y, box_x + ITEM_IDENT + 1, menu_height);
 
 			wnoutrefresh(dialog);
 			wrefresh(menu);
-- 
1.0.6

