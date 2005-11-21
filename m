Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVKUWlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVKUWlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKUWlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:41:50 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:19479 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751191AbVKUWlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:41:20 -0500
Date: Mon, 21 Nov 2005 23:41:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: [7/7] kconfig: truncate too long menu lines in menuconfig
Message-ID: <20051121224127.GH19157@mars.ravnborg.org>
References: <20051121223702.GA19157@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121223702.GA19157@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    kconfig: truncate too long menu lines in menuconfig
    
    menu lines wrapped over too lines when too long - truncate them.
    Also fixed a coding style issue
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index d0bf32b..2d91880 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -68,11 +68,11 @@ static void do_print_item(WINDOW * win, 
                           int selected, int hotkey)
 {
 	int j;
 	char *menu_item = malloc(menu_width + 1);
 
-	strncpy(menu_item, item, menu_width);
+	strncpy(menu_item, item, menu_width - ITEM_IDENT);
 	menu_item[menu_width] = 0;
 	j = first_alpha(menu_item, "YyNnMmHh");
 
 	/* Clear 'residue' of last item */
 	wattrset(win, menubox_attr);
@@ -182,12 +182,12 @@ static void do_scroll(WINDOW *win, int *
 int dialog_menu(const char *title, const char *prompt, int height, int width,
                 int menu_height, const char *current, int item_no,
                 const char *const *items)
 {
 	int i, j, x, y, box_x, box_y;
-	int key = 0, button = 0, scroll = 0, choice = 0, first_item =
-	    0, max_choice;
+	int key = 0, button = 0, scroll = 0, choice = 0;
+	int first_item =  0, max_choice;
 	WINDOW *dialog, *menu;
 	FILE *f;
 
 	max_choice = MIN(menu_height, item_no);
 
