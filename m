Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVGMRSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVGMRSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVGMRQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:16:40 -0400
Received: from mta02.mail.t-online.hu ([195.228.240.51]:28383 "EHLO
	mta02.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261166AbVGMRPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:15:37 -0400
Subject: [PATCH 6/19] Kconfig I18N: config
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
Date: Wed, 13 Jul 2005 19:15:35 +0200
Message-Id: <1121274935.2975.22.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I18N support for conf.c .

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>

---

 scripts/kconfig/conf.c |   44 ++++++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff -puN scripts/kconfig/conf.c~kconfig-i18n-06-config-i18n scripts/kconfig/conf.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/conf.c~kconfig-i18n-06-config-i18n	2005-07-13 18:32:17.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/conf.c	2005-07-13 18:32:17.000000000 +0200
@@ -69,7 +69,7 @@ static void conf_askvalue(struct symbol 
 	tristate val;
 
 	if (!sym_has_value(sym))
-		printf("(NEW) ");
+		printf(_("(NEW) "));
 
 	line[0] = '\n';
 	line[1] = 0;
@@ -164,7 +164,7 @@ int conf_string(struct menu *menu)
 	const char *def, *help;
 
 	while (1) {
-		printf("%*s%s ", indent - 1, "", menu->prompt->text);
+		printf("%*s%s ", indent - 1, "", _(menu->prompt->text));
 		printf("(%s) ", sym->name);
 		def = sym_get_string_value(sym);
 		if (sym_get_string_value(sym))
@@ -176,10 +176,10 @@ int conf_string(struct menu *menu)
 		case '?':
 			/* print help */
 			if (line[1] == '\n') {
-				help = nohelp_text;
+				help = _(nohelp_text);
 				if (menu->sym->help)
-					help = menu->sym->help;
-				printf("\n%s\n", menu->sym->help);
+					help = _(menu->sym->help);
+				printf("\n%s\n", help);
 				def = NULL;
 				break;
 			}
@@ -200,7 +200,7 @@ static int conf_sym(struct menu *menu)
 	const char *help;
 
 	while (1) {
-		printf("%*s%s ", indent - 1, "", menu->prompt->text);
+		printf("%*s%s ", indent - 1, "", _(menu->prompt->text));
 		if (sym->name)
 			printf("(%s) ", sym->name);
 		type = sym_get_type(sym);
@@ -259,9 +259,9 @@ static int conf_sym(struct menu *menu)
 		if (sym_set_tristate_value(sym, newval))
 			return 0;
 help:
-		help = nohelp_text;
+		help = _(nohelp_text);
 		if (sym->help)
-			help = sym->help;
+			help = _(sym->help);
 		printf("\n%s\n", help);
 	}
 }
@@ -292,7 +292,7 @@ static int conf_choice(struct menu *menu
 		case no:
 			return 1;
 		case mod:
-			printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
+			printf("%*s%s\n", indent - 1, "", _(menu_get_prompt(menu)));
 			return 0;
 		case yes:
 			break;
@@ -302,7 +302,7 @@ static int conf_choice(struct menu *menu
 	while (1) {
 		int cnt, def;
 
-		printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
+		printf("%*s%s\n", indent - 1, "", _(menu_get_prompt(menu)));
 		def_sym = sym_get_choice_value(sym);
 		cnt = def = 0;
 		line[0] = '0';
@@ -311,7 +311,7 @@ static int conf_choice(struct menu *menu
 			if (!menu_is_visible(child))
 				continue;
 			if (!child->sym) {
-				printf("%*c %s\n", indent, '*', menu_get_prompt(child));
+				printf("%*c %s\n", indent, '*', _(menu_get_prompt(child)));
 				continue;
 			}
 			cnt++;
@@ -320,14 +320,14 @@ static int conf_choice(struct menu *menu
 				printf("%*c", indent, '>');
 			} else
 				printf("%*c", indent, ' ');
-			printf(" %d. %s", cnt, menu_get_prompt(child));
+			printf(" %d. %s", cnt, _(menu_get_prompt(child)));
 			if (child->sym->name)
 				printf(" (%s)", child->sym->name);
 			if (!sym_has_value(child->sym))
-				printf(" (NEW)");
+				printf(_(" (NEW)"));
 			printf("\n");
 		}
-		printf("%*schoice", indent - 1, "");
+		printf(_("%*schoice"), indent - 1, "");
 		if (cnt == 1) {
 			printf("[1]: 1\n");
 			goto conf_childs;
@@ -351,7 +351,7 @@ static int conf_choice(struct menu *menu
 			strip(line);
 			if (line[0] == '?') {
 				printf("\n%s\n", menu->sym->help ?
-					menu->sym->help : nohelp_text);
+					_(menu->sym->help) : _(nohelp_text));
 				continue;
 			}
 			if (!line[0])
@@ -383,7 +383,7 @@ static int conf_choice(struct menu *menu
 			continue;
 		if (line[strlen(line) - 1] == '?') {
 			printf("\n%s\n", child->sym->help ?
-				child->sym->help : nohelp_text);
+				_(child->sym->help) : _(nohelp_text));
 			continue;
 		}
 		sym_set_choice_value(sym, child->sym);
@@ -417,7 +417,7 @@ static void conf(struct menu *menu)
 				return;
 			}
 		case P_COMMENT:
-			prompt = menu_get_prompt(menu);
+			prompt = _(menu_get_prompt(menu));
 			if (prompt)
 				printf("%*c\n%*c %s\n%*c\n",
 					indent, '*',
@@ -488,6 +488,10 @@ int main(int ac, char **av)
 	const char *name;
 	struct stat tmpstat;
 
+	setlocale (LC_ALL, "");
+	bindtextdomain (PACKAGE, LOCALEDIR);
+	textdomain (PACKAGE);
+
 	if (ac > i && av[i][0] == '-') {
 		switch (av[i++][1]) {
 		case 'o':
@@ -524,7 +528,7 @@ int main(int ac, char **av)
 			break;
 		case 'h':
 		case '?':
-			printf("%s [-o|-s] config\n", av[0]);
+			printf(_("%s [-o|-s] config\n"), av[0]);
 			exit(0);
 		}
 	}
@@ -539,9 +543,9 @@ int main(int ac, char **av)
 		if (!defconfig_file)
 			defconfig_file = conf_get_default_confname();
 		if (conf_read(defconfig_file)) {
-			printf("***\n"
+			printf(_("***\n"
 				"*** Can't find default configuration \"%s\"!\n"
-				"***\n", defconfig_file);
+				"***\n"), defconfig_file);
 			exit(1);
 		}
 		break;
_


