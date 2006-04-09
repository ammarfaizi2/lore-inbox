Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWDIP1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWDIP1R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDIP1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:27:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28842 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750773AbWDIP1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:27:15 -0400
Date: Sun, 9 Apr 2006 17:27:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 3/19] kconfig: recenter menuconfig
Message-ID: <Pine.LNX.4.64.0604091726550.23116@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move the menuconfig output more into the centre again, it's using a
fixed position depending on the window width using the fact that the
menu output has to work in a 80 chars terminal.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/lxdialog/menubox.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Index: linux-2.6-git/scripts/kconfig/lxdialog/menubox.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lxdialog/menubox.c
+++ linux-2.6-git/scripts/kconfig/lxdialog/menubox.c
@@ -58,8 +58,7 @@
 
 #include "dialog.h"
 
-#define ITEM_IDENT 1   /* Indent of menu entries. Fixed for all menus */
-static int menu_width;
+static int menu_width, item_x;
 
 /*
  * Print menu item
@@ -70,7 +69,7 @@ static void do_print_item(WINDOW * win, 
 	int j;
 	char *menu_item = malloc(menu_width + 1);
 
-	strncpy(menu_item, item, menu_width - ITEM_IDENT);
+	strncpy(menu_item, item, menu_width - item_x);
 	menu_item[menu_width] = 0;
 	j = first_alpha(menu_item, "YyNnMmHh");
 
@@ -87,13 +86,13 @@ static void do_print_item(WINDOW * win, 
 	wclrtoeol(win);
 #endif
 	wattrset(win, selected ? item_selected_attr : item_attr);
-	mvwaddstr(win, choice, ITEM_IDENT, menu_item);
+	mvwaddstr(win, choice, item_x, menu_item);
 	if (hotkey) {
 		wattrset(win, selected ? tag_key_selected_attr : tag_key_attr);
-		mvwaddch(win, choice, ITEM_IDENT + j, menu_item[j]);
+		mvwaddch(win, choice, item_x + j, menu_item[j]);
 	}
 	if (selected) {
-		wmove(win, choice, ITEM_IDENT + 1);
+		wmove(win, choice, item_x + 1);
 	}
 	free(menu_item);
 	wrefresh(win);
@@ -227,6 +226,8 @@ int dialog_menu(const char *title, const
 	draw_box(dialog, box_y, box_x, menu_height + 2, menu_width + 2,
 		 menubox_border_attr, menubox_attr);
 
+	item_x = (menu_width - 70) / 2;
+
 	/* Set choice to default item */
 	for (i = 0; i < item_no; i++)
 		if (strcmp(current, items[i * 2]) == 0)
@@ -263,10 +264,10 @@ int dialog_menu(const char *title, const
 	wnoutrefresh(menu);
 
 	print_arrows(dialog, item_no, scroll,
-		     box_y, box_x + ITEM_IDENT + 1, menu_height);
+		     box_y, box_x + item_x + 1, menu_height);
 
 	print_buttons(dialog, height, width, 0);
-	wmove(menu, choice, ITEM_IDENT + 1);
+	wmove(menu, choice, item_x + 1);
 	wrefresh(menu);
 
 	while (key != ESC) {
@@ -349,7 +350,7 @@ int dialog_menu(const char *title, const
 			print_item(scroll + choice, choice, TRUE);
 
 			print_arrows(dialog, item_no, scroll,
-				     box_y, box_x + ITEM_IDENT + 1, menu_height);
+				     box_y, box_x + item_x + 1, menu_height);
 
 			wnoutrefresh(dialog);
 			wrefresh(menu);
