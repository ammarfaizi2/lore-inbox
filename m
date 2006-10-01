Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWJAKxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWJAKxY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWJAKw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:52:59 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:10653 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751570AbWJAKwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:52:50 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@neptun.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 9/13] kconfig/lxdialog: clear long menu lines
Reply-To: sam@ravnborg.org
Date: Sun, 01 Oct 2006 12:52:42 +0200
Message-Id: <1159699967673-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11596999672988-git-send-email-sam@ravnborg.org>
References: <1159699966691-git-send-email-sam@ravnborg.org> <1159699967600-git-send-email-sam@ravnborg.org> <11596999673562-git-send-email-sam@ravnborg.org> <115969996719-git-send-email-sam@ravnborg.org> <11596999673039-git-send-email-sam@ravnborg.org> <11596999672694-git-send-email-sam@ravnborg.org> <11596999673444-git-send-email-sam@ravnborg.org> <11596999672988-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@neptun.ravnborg.org>

Menulines that were wider than the available
line width is now properly null terminated.

While at it renamed the variable choice => line_y
so it better reflect the usage in do_print_item().

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/lxdialog/menubox.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index fcd95a9..0d83159 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -63,19 +63,19 @@ static int menu_width, item_x;
 /*
  * Print menu item
  */
-static void do_print_item(WINDOW * win, const char *item, int choice,
+static void do_print_item(WINDOW * win, const char *item, int line_y,
                           int selected, int hotkey)
 {
 	int j;
 	char *menu_item = malloc(menu_width + 1);
 
 	strncpy(menu_item, item, menu_width - item_x);
-	menu_item[menu_width] = 0;
+	menu_item[menu_width - item_x] = '\0';
 	j = first_alpha(menu_item, "YyNnMmHh");
 
 	/* Clear 'residue' of last item */
 	wattrset(win, dlg.menubox.atr);
-	wmove(win, choice, 0);
+	wmove(win, line_y, 0);
 #if OLD_NCURSES
 	{
 		int i;
@@ -86,14 +86,14 @@ #else
 	wclrtoeol(win);
 #endif
 	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
-	mvwaddstr(win, choice, item_x, menu_item);
+	mvwaddstr(win, line_y, item_x, menu_item);
 	if (hotkey) {
 		wattrset(win, selected ? dlg.tag_key_selected.atr
 			 : dlg.tag_key.atr);
-		mvwaddch(win, choice, item_x + j, menu_item[j]);
+		mvwaddch(win, line_y, item_x + j, menu_item[j]);
 	}
 	if (selected) {
-		wmove(win, choice, item_x + 1);
+		wmove(win, line_y, item_x + 1);
 	}
 	free(menu_item);
 	wrefresh(win);
-- 
1.4.1

