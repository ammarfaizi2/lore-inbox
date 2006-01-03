Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWACNeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWACNeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWACNdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:33:46 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:23301 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932323AbWACNZd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:33 -0500
Subject: [PATCH 03/26] kconfig: lxdialog is now sparse clean
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947252795@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1132435075 +0100

Replacing a gcc idiom with malloc and deleting an unused global
variable made lxdialog sparse clean.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/lxdialog/menubox.c |    5 +++--
 scripts/lxdialog/util.c    |    2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

a06104af7dcf2f5bafaf18f373c8b2554cbfe014
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index 260cc4d..ff3a617 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -67,7 +67,7 @@ static void print_item(WINDOW * win, con
 		       int selected, int hotkey)
 {
 	int j;
-	char menu_item[menu_width + 1];
+	char *menu_item = malloc(menu_width + 1);
 
 	strncpy(menu_item, item, menu_width);
 	menu_item[menu_width] = 0;
@@ -95,6 +95,7 @@ static void print_item(WINDOW * win, con
 		wmove(win, choice, item_x + 1);
 		wrefresh(win);
 	}
+	free(menu_item);
 }
 
 /*
@@ -221,7 +222,7 @@ int dialog_menu(const char *title, const
 
 	/*
 	 * Find length of longest item in order to center menu.
-	 * Set 'choice' to default item. 
+	 * Set 'choice' to default item.
 	 */
 	item_x = 0;
 	for (i = 0; i < item_no; i++) {
diff --git a/scripts/lxdialog/util.c b/scripts/lxdialog/util.c
index 1f84809..ce41147 100644
--- a/scripts/lxdialog/util.c
+++ b/scripts/lxdialog/util.c
@@ -26,8 +26,6 @@ bool use_colors = 1;
 
 const char *backtitle = NULL;
 
-const char *dialog_result;
-
 /*
  * Attribute values, default is for mono display
  */
-- 
1.0.6

