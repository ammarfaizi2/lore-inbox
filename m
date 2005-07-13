Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVGMR3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVGMR3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGMR2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:28:16 -0400
Received: from mta01.mail.t-online.hu ([195.228.240.50]:37887 "EHLO
	mta01.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261704AbVGMR1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:27:34 -0400
Subject: [PATCH 14/19] Kconfig I18N: menuconfig: missing macros
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
Date: Wed, 13 Jul 2005 19:27:32 +0200
Message-Id: <1121275652.2975.41.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Supplementing missing macros.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/mconf.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff -puN scripts/kconfig/mconf.c~kconfig-i18n-14-menuconfig-missing scripts/kconfig/mconf.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/mconf.c~kconfig-i18n-14-menuconfig-missing	2005-07-13 18:32:19.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/mconf.c	2005-07-13 18:32:19.000000000 +0200
@@ -385,7 +385,7 @@ static void get_prompt_str(struct gstr *
 		str_printf(r, _("  Location:\n"));
 		for (j = 4; --i >= 0; j += 2) {
 			menu = submenu[i];
-			str_printf(r, "%*c-> %s", j, ' ', menu_get_prompt(menu));
+			str_printf(r, "%*c-> %s", j, ' ', _(menu_get_prompt(menu)));
 			if (menu->sym) {
 				str_printf(r, " (%s [=%s])", menu->sym->name ?
 					menu->sym->name : _("<choice>"),
@@ -544,7 +544,7 @@ again:
 	case 0:
 		break;
 	case 1:
-		show_helptext(_("Search Configuration"), search_help);
+		show_helptext(_("Search Configuration"), _(search_help));
 		goto again;
 	default:
 		return;
@@ -573,7 +573,7 @@ static void build_conf(struct menu *menu
 	prop = menu->prompt;
 	if (!sym) {
 		if (prop && menu != current_menu) {
-			const char *prompt = menu_get_prompt(menu);
+			const char *prompt = _(menu_get_prompt(menu));
 			switch (prop->type) {
 			case P_MENU:
 				child_count++;
@@ -634,10 +634,10 @@ static void build_conf(struct menu *menu
 			cprint1("   ");
 		}
 
-		cprint1("%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+		cprint1("%*c%s", indent + 1, ' ', _(menu_get_prompt(menu)));
 		if (val == yes) {
 			if (def_menu) {
-				cprint1(" (%s)", menu_get_prompt(def_menu));
+				cprint1(" (%s)", _(menu_get_prompt(def_menu)));
 				cprint1("  --->");
 				cprint_done();
 				if (def_menu->list) {
@@ -653,7 +653,7 @@ static void build_conf(struct menu *menu
 	} else {
 		if (menu == current_menu) {
 			cprint(":%p", menu);
-			cprint("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+			cprint("---%*c%s", indent + 1, ' ', _(menu_get_prompt(menu)));
 			goto conf_childs;
 		}
 		child_count++;
@@ -688,14 +688,14 @@ static void build_conf(struct menu *menu
 				tmp = indent - tmp + 4;
 				if (tmp < 0)
 					tmp = 0;
-				cprint1("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
+				cprint1("%*c%s%s", tmp, ' ', _(menu_get_prompt(menu)),
 					(sym_has_value(sym) || !sym_is_changable(sym)) ?
 					"" : _(" (NEW)"));
 				cprint_done();
 				goto conf_childs;
 			}
 		}
-		cprint1("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
+		cprint1("%*c%s%s", indent + 1, ' ', _(menu_get_prompt(menu)),
 			(sym_has_value(sym) || !sym_is_changable(sym)) ?
 			"" : _(" (NEW)"));
 		if (menu->prompt->type == P_MENU) {
@@ -716,7 +716,7 @@ conf_childs:
 static void conf(struct menu *menu)
 {
 	struct menu *submenu;
-	const char *prompt = menu_get_prompt(menu);
+	const char *prompt = _(menu_get_prompt(menu));
 	struct symbol *sym;
 	char active_entry[40];
 	int stat, type, i;
@@ -798,7 +798,7 @@ static void conf(struct menu *menu)
 			if (sym)
 				show_help(submenu);
 			else
-				show_helptext("README", _(mconf_readme));
+				show_helptext(_("README"), _(mconf_readme));
 			break;
 		case 3:
 			if (type == 't') {
@@ -861,7 +861,7 @@ static void show_help(struct menu *menu)
 		str_append(&help, nohelp_text);
 	}
 	get_symbol_str(&help, sym);
-	show_helptext(menu_get_prompt(menu), str_get(&help));
+	show_helptext(_(menu_get_prompt(menu)), str_get(&help));
 	str_free(&help);
 }
 
@@ -882,7 +882,7 @@ static void show_file(const char *filena
 
 static void conf_choice(struct menu *menu)
 {
-	const char *prompt = menu_get_prompt(menu);
+	const char *prompt = _(menu_get_prompt(menu));
 	struct menu *child;
 	struct symbol *active;
 	int stat;
@@ -903,7 +903,7 @@ static void conf_choice(struct menu *men
 			if (!menu_is_visible(child))
 				continue;
 			cprint("%p", child);
-			cprint("%s", menu_get_prompt(child));
+			cprint("%s", _(menu_get_prompt(child)));
 			if (child->sym == sym_get_choice_value(menu->sym))
 				cprint("ON");
 			else if (child->sym == active)
@@ -934,7 +934,7 @@ static void conf_choice(struct menu *men
 
 static void conf_string(struct menu *menu)
 {
-	const char *prompt = menu_get_prompt(menu);
+	const char *prompt = _(menu_get_prompt(menu));
 	int stat;
 
 	while (1) {
@@ -981,7 +981,7 @@ static void conf_load(void)
 	while (1) {
 		cprint_init();
 		cprint("--inputbox");
-		cprint(load_config_text);
+		cprint(_(load_config_text));
 		cprint("11");
 		cprint("55");
 		cprint("%s", filename);
@@ -995,7 +995,7 @@ static void conf_load(void)
 			show_textbox(NULL, _("File does not exist!"), 5, 38);
 			break;
 		case 1:
-			show_helptext(_("Load Alternate Configuration"), load_config_help);
+			show_helptext(_("Load Alternate Configuration"), _(load_config_help));
 			break;
 		case 255:
 			return;
@@ -1010,7 +1010,7 @@ static void conf_save(void)
 	while (1) {
 		cprint_init();
 		cprint("--inputbox");
-		cprint(save_config_text);
+		cprint(_(save_config_text));
 		cprint("11");
 		cprint("55");
 		cprint("%s", filename);
@@ -1024,7 +1024,7 @@ static void conf_save(void)
 			show_textbox(NULL, _("Can't create file!  Probably a nonexistent directory."), 5, 60);
 			break;
 		case 1:
-			show_helptext(_("Save Alternate Configuration"), save_config_help);
+			show_helptext(_("Save Alternate Configuration"), _(save_config_help));
 			break;
 		case 255:
 			return;
_


