Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVGMR2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVGMR2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGMRZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:25:58 -0400
Received: from mta02.mail.t-online.hu ([195.228.240.51]:40401 "EHLO
	mta02.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261326AbVGMRYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:24:37 -0400
Subject: [PATCH 12/19] Kconfig I18N: menuconfig
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
Date: Wed, 13 Jul 2005 19:24:35 +0200
Message-Id: <1121275475.2975.36.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Full I18N support for menuconfig.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/mconf.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff -puN scripts/kconfig/mconf.c~kconfig-i18n-12-menuconfig-i18n scripts/kconfig/mconf.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/mconf.c~kconfig-i18n-12-menuconfig-i18n	2005-07-13 18:32:18.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/mconf.c	2005-07-13 18:36:46.000000000 +0200
@@ -308,8 +308,8 @@ static void init_wsize(void)
 	}
 
 	if (rows < 19 || cols < 80) {
-		fprintf(stderr, N_("Your display is too small to run Menuconfig!\n"));
-		fprintf(stderr, N_("It must be at least 19 lines by 80 columns.\n"));
+		fprintf(stderr, _("Your display is too small to run Menuconfig!\n"
+			"It must be at least 19 lines by 80 columns.\n"));
 		exit(1);
 	}
 
@@ -370,11 +370,11 @@ static void get_prompt_str(struct gstr *
 	int i, j;
 	struct menu *submenu[8], *menu;
 
-	str_printf(r, "Prompt: %s\n", prop->text);
-	str_printf(r, "  Defined at %s:%d\n", prop->menu->file->name,
+	str_printf(r, _("Prompt: %s\n"), _(prop->text));
+	str_printf(r, _("  Defined at %s:%d\n"), prop->menu->file->name,
 		prop->menu->lineno);
 	if (!expr_is_yes(prop->visible.expr)) {
-		str_append(r, "  Depends on: ");
+		str_append(r, _("  Depends on: "));
 		expr_gstr_print(prop->visible.expr, r);
 		str_append(r, "\n");
 	}
@@ -382,13 +382,13 @@ static void get_prompt_str(struct gstr *
 	for (i = 0; menu != &rootmenu && i < 8; menu = menu->parent)
 		submenu[i++] = menu;
 	if (i > 0) {
-		str_printf(r, "  Location:\n");
+		str_printf(r, _("  Location:\n"));
 		for (j = 4; --i >= 0; j += 2) {
 			menu = submenu[i];
 			str_printf(r, "%*c-> %s", j, ' ', menu_get_prompt(menu));
 			if (menu->sym) {
 				str_printf(r, " (%s [=%s])", menu->sym->name ?
-					menu->sym->name : "<choice>",
+					menu->sym->name : _("<choice>"),
 					sym_get_string_value(menu->sym));
 			}
 			str_append(r, "\n");
@@ -401,14 +401,14 @@ static void get_symbol_str(struct gstr *
 	bool hit;
 	struct property *prop;
 
-	str_printf(r, "Symbol: %s [=%s]\n", sym->name,
+	str_printf(r, _("Symbol: %s [=%s]\n"), sym->name,
 	                               sym_get_string_value(sym));
 	for_all_prompts(sym, prop)
 		get_prompt_str(r, prop);
 	hit = false;
 	for_all_properties(sym, prop, P_SELECT) {
 		if (!hit) {
-			str_append(r, "  Selects: ");
+			str_append(r, _("  Selects: "));
 			hit = true;
 		} else
 			str_printf(r, " && ");
@@ -417,7 +417,7 @@ static void get_symbol_str(struct gstr *
 	if (hit)
 		str_append(r, "\n");
 	if (sym->rev_dep.expr) {
-		str_append(r, "  Selected by: ");
+		str_append(r, _("  Selected by: "));
 		expr_gstr_print(sym->rev_dep.expr, r);
 		str_append(r, "\n");
 	}
@@ -433,7 +433,7 @@ static struct gstr get_relations_str(str
 	for (i = 0; sym_arr && (sym = sym_arr[i]); i++)
 		get_symbol_str(&res, sym);
 	if (!i)
-		str_append(&res, "No matches found.\n");
+		str_append(&res, _("No matches found.\n"));
 	return res;
 }
 
@@ -503,7 +503,8 @@ static int exec_conf(void)
 		return -1;
 	}
 	if (WIFSIGNALED(stat)) {
-		printf("\finterrupted(%d)\n", WTERMSIG(stat));
+		printf("\f");
+		printf(_("interrupted(%d)\n"), WTERMSIG(stat));
 		exit(1);
 	}
 #if 0
@@ -512,7 +513,8 @@ static int exec_conf(void)
 #endif
 	sigpending(&sset);
 	if (sigismember(&sset, SIGINT)) {
-		printf("\finterrupted\n");
+		printf("\f");
+		printf(_("interrupted\n"));
 		exit(1);
 	}
 	sigprocmask(SIG_SETMASK, &osset, NULL);
@@ -688,14 +690,14 @@ static void build_conf(struct menu *menu
 					tmp = 0;
 				cprint1("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
 					(sym_has_value(sym) || !sym_is_changable(sym)) ?
-					"" : " (NEW)");
+					"" : _(" (NEW)"));
 				cprint_done();
 				goto conf_childs;
 			}
 		}
 		cprint1("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
 			(sym_has_value(sym) || !sym_is_changable(sym)) ?
-			"" : " (NEW)");
+			"" : _(" (NEW)"));
 		if (menu->prompt->type == P_MENU) {
 			cprint1("  --->");
 			cprint_done();
_


