Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWJAKxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWJAKxX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWJAKxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:53:06 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:49118 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751613AbWJAKwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:52:50 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@neptun.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 10/13] kconfig/menuconfig: do not let ncurses clutter screen on exit
Reply-To: sam@ravnborg.org
Date: Sun, 01 Oct 2006 12:52:43 +0200
Message-Id: <115969996811-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1159699967673-git-send-email-sam@ravnborg.org>
References: <1159699966691-git-send-email-sam@ravnborg.org> <1159699967600-git-send-email-sam@ravnborg.org> <11596999673562-git-send-email-sam@ravnborg.org> <115969996719-git-send-email-sam@ravnborg.org> <11596999673039-git-send-email-sam@ravnborg.org> <11596999672694-git-send-email-sam@ravnborg.org> <11596999673444-git-send-email-sam@ravnborg.org> <11596999672988-git-send-email-sam@ravnborg.org> <1159699967673-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@neptun.ravnborg.org>

Do not initialize ncurses twice - it causes unpredicable
results. My display was sometimes weird after running
make menuconfig and I had to execute 'reset' to properly
restore my display.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/mconf.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index f7abca4..08a4c7a 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -401,7 +401,7 @@ static void search_conf(void)
 	struct gstr res;
 	int dres;
 again:
-	reset_dialog();
+	dialog_clear();
 	dres = dialog_inputbox(_("Search Configuration Parameter"),
 			      _("Enter CONFIG_ (sub)string to search for (omit CONFIG_)"),
 			      10, 75, "");
@@ -603,7 +603,7 @@ static void conf(struct menu *menu)
 			item_make(_("    Save an Alternate Configuration File"));
 			item_set_tag('S');
 		}
-		reset_dialog();
+		dialog_clear();
 		res = dialog_menu(prompt ? prompt : _("Main Menu"),
 				  _(menu_instructions),
 				  active_menu, &s_scroll);
@@ -684,7 +684,7 @@ static void conf(struct menu *menu)
 
 static void show_textbox(const char *title, const char *text, int r, int c)
 {
-	reset_dialog();
+	dialog_clear();
 	dialog_textbox(title, text, r, c);
 }
 
@@ -736,7 +736,7 @@ static void conf_choice(struct menu *men
 			if (child->sym == sym_get_choice_value(menu->sym))
 				item_set_tag('X');
 		}
-		reset_dialog();
+		dialog_clear();
 		res = dialog_checklist(prompt ? prompt : _("Main Menu"),
 					_(radiolist_instructions),
 					 15, 70, 6);
@@ -785,7 +785,7 @@ static void conf_string(struct menu *men
 		default:
 			heading = "Internal mconf error!";
 		}
-		reset_dialog();
+		dialog_clear();
 		res = dialog_inputbox(prompt ? prompt : _("Main Menu"),
 				      heading, 10, 75,
 				      sym_get_string_value(menu->sym));
@@ -809,7 +809,7 @@ static void conf_load(void)
 
 	while (1) {
 		int res;
-		reset_dialog();
+		dialog_clear();
 		res = dialog_inputbox(NULL, load_config_text,
 				      11, 55, filename);
 		switch(res) {
@@ -833,7 +833,7 @@ static void conf_save(void)
 {
 	while (1) {
 		int res;
-		reset_dialog();
+		dialog_clear();
 		res = dialog_inputbox(NULL, save_config_text,
 				      11, 55, filename);
 		switch(res) {
@@ -889,7 +889,7 @@ int main(int ac, char **av)
 	init_dialog(menu_backtitle);
 	do {
 		conf(&rootmenu);
-		reset_dialog();
+		dialog_clear();
 		res = dialog_yesno(NULL,
 				   _("Do you wish to save your "
 				     "new kernel configuration?\n"
-- 
1.4.1

