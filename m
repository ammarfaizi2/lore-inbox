Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVADBCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVADBCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVACXZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:25:17 -0500
Received: from mail.dif.dk ([193.138.115.101]:52360 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261935AbVACXYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:24:19 -0500
Date: Tue, 4 Jan 2005 00:35:36 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] pedantic correctness cleanup for conf.c in scripts/kconfig/
 .
Message-ID: <Pine.LNX.4.61.0501040031460.3529@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Tiny, pedantic patch for scripts/kconfig/conf.c
'line' is an array of signed chars, so lets stuff chars into it, not ints.
Doesn't make any actual difference, just feels nicer ;)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk6-orig/scripts/kconfig/conf.c linux-2.6.10-bk6/scripts/kconfig/conf.c
--- linux-2.6.10-bk6-orig/scripts/kconfig/conf.c	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.10-bk6/scripts/kconfig/conf.c	2005-01-04 00:30:02.000000000 +0100
@@ -72,12 +72,12 @@ static void conf_askvalue(struct symbol 
 		printf("(NEW) ");
 
 	line[0] = '\n';
-	line[1] = 0;
+	line[1] = '\0';
 
 	if (!sym_is_changable(sym)) {
 		printf("%s\n", def);
 		line[0] = '\n';
-		line[1] = 0;
+		line[1] = '\0';
 		return;
 	}
 
@@ -114,7 +114,7 @@ static void conf_askvalue(struct symbol 
 		if (sym_tristate_within_range(sym, yes)) {
 			line[0] = 'y';
 			line[1] = '\n';
-			line[2] = 0;
+			line[2] = '\0';
 			break;
 		}
 	case set_mod:
@@ -122,14 +122,14 @@ static void conf_askvalue(struct symbol 
 			if (sym_tristate_within_range(sym, mod)) {
 				line[0] = 'm';
 				line[1] = '\n';
-				line[2] = 0;
+				line[2] = '\0';
 				break;
 			}
 		} else {
 			if (sym_tristate_within_range(sym, yes)) {
 				line[0] = 'y';
 				line[1] = '\n';
-				line[2] = 0;
+				line[2] = '\0';
 				break;
 			}
 		}
@@ -137,7 +137,7 @@ static void conf_askvalue(struct symbol 
 		if (sym_tristate_within_range(sym, no)) {
 			line[0] = 'n';
 			line[1] = '\n';
-			line[2] = 0;
+			line[2] = '\0';
 			break;
 		}
 	case set_random:
@@ -150,7 +150,7 @@ static void conf_askvalue(struct symbol 
 		case yes: line[0] = 'y'; break;
 		}
 		line[1] = '\n';
-		line[2] = 0;
+		line[2] = '\0';
 		break;
 	default:
 		break;
@@ -184,7 +184,7 @@ int conf_string(struct menu *menu)
 				break;
 			}
 		default:
-			line[strlen(line)-1] = 0;
+			line[strlen(line)-1] = '\0';
 			def = line;
 		}
 		if (def && sym_set_string_value(sym, def))
@@ -248,7 +248,7 @@ static int conf_sym(struct menu *menu)
 			if (!line[1] || !strcmp(&line[1], "es"))
 				break;
 			continue;
-		case 0:
+		case '\0':
 			newval = oldval;
 			break;
 		case '?':
@@ -305,8 +305,8 @@ static int conf_choice(struct menu *menu
 		printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
 		def_sym = sym_get_choice_value(sym);
 		cnt = def = 0;
-		line[0] = '0';
-		line[1] = 0;
+		line[0] = '\0';
+		line[1] = '\0';
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;



