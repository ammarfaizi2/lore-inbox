Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbVKCPIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVKCPIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVKCPIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:08:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28873 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030272AbVKCPIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:08:37 -0500
Date: Thu, 3 Nov 2005 16:08:31 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 5/9] kconfig: update kconfig Makefile
Message-ID: <Pine.LNX.4.61.0511031607490.2509@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove the long obsolete zconf.tab.h and fix kconfig make rules to 
generate the correct output files. Setting LKC_GENPARSER will now also 
update the shipped files.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/Makefile            |   18 ++---
 scripts/kconfig/zconf.tab.h_shipped |  125 ------------------------------------
 2 files changed, 7 insertions(+), 136 deletions(-)

Index: linux-2.6/scripts/kconfig/Makefile
===================================================================
--- linux-2.6.orig/scripts/kconfig/Makefile	2005-11-03 13:10:15.000000000 +0100
+++ linux-2.6/scripts/kconfig/Makefile	2005-11-03 13:10:31.000000000 +0100
@@ -114,7 +114,7 @@ gconf-objs	:= gconf.o kconfig_load.o zco
 endif
 
 clean-files	:= lkc_defs.h qconf.moc .tmp_qtcheck \
-		   .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c
+		   .tmp_gtkcheck zconf.tab.c lex.zconf.c
 
 # generated files seem to need this to find local include files
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
@@ -127,12 +127,6 @@ HOSTLOADLIBES_gconf	= `pkg-config gtk+-2
 HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags` \
                           -D LKC_DIRECT_LINK
 
-$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o $(obj)/kxgettext: $(obj)/zconf.tab.h
-
-$(obj)/zconf.tab.h: $(src)/zconf.tab.h_shipped
-$(obj)/zconf.tab.c: $(src)/zconf.tab.c_shipped
-$(obj)/lex.zconf.c: $(src)/lex.zconf.c_shipped
-
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
 ifeq ($(qconf-target),1)
@@ -216,13 +210,15 @@ $(obj)/lkc_defs.h: $(src)/lkc_proto.h
 
 ifdef LKC_GENPARSER
 
-$(obj)/zconf.tab.c: $(obj)/zconf.y 
-$(obj)/zconf.tab.h: $(obj)/zconf.tab.c
+$(obj)/zconf.tab.c: $(src)/zconf.y
+$(obj)/lex.zconf.c: $(src)/zconf.l
 
 %.tab.c: %.y
-	bison -t -d -v -b $* -p $(notdir $*) $<
+	bison -l -b $* -p $(notdir $*) $<
+	cp $@ $@_shipped
 
 lex.%.c: %.l
-	flex -P$(notdir $*) -o$@ $<
+	flex -L -P$(notdir $*) -o$@ $<
+	cp $@ $@_shipped
 
 endif
Index: linux-2.6/scripts/kconfig/zconf.tab.h_shipped
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.tab.h_shipped	2005-11-03 13:10:15.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,125 +0,0 @@
-/* A Bison parser, made from zconf.y, by GNU bison 1.75.  */
-
-/* Skeleton parser for Yacc-like parsing with Bison,
-   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002 Free Software Foundation, Inc.
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2, or (at your option)
-   any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 59 Temple Place - Suite 330,
-   Boston, MA 02111-1307, USA.  */
-
-/* As a special exception, when this file is copied by Bison into a
-   Bison output file, you may use that output file without restriction.
-   This special exception was added by the Free Software Foundation
-   in version 1.24 of Bison.  */
-
-#ifndef BISON_ZCONF_TAB_H
-# define BISON_ZCONF_TAB_H
-
-/* Tokens.  */
-#ifndef YYTOKENTYPE
-# define YYTOKENTYPE
-   /* Put the tokens into the symbol table, so that GDB and other debuggers
-      know about them.  */
-   enum yytokentype {
-     T_MAINMENU = 258,
-     T_MENU = 259,
-     T_ENDMENU = 260,
-     T_SOURCE = 261,
-     T_CHOICE = 262,
-     T_ENDCHOICE = 263,
-     T_COMMENT = 264,
-     T_CONFIG = 265,
-     T_HELP = 266,
-     T_HELPTEXT = 267,
-     T_IF = 268,
-     T_ENDIF = 269,
-     T_DEPENDS = 270,
-     T_REQUIRES = 271,
-     T_OPTIONAL = 272,
-     T_PROMPT = 273,
-     T_DEFAULT = 274,
-     T_TRISTATE = 275,
-     T_BOOLEAN = 276,
-     T_INT = 277,
-     T_HEX = 278,
-     T_WORD = 279,
-     T_STRING = 280,
-     T_UNEQUAL = 281,
-     T_EOF = 282,
-     T_EOL = 283,
-     T_CLOSE_PAREN = 284,
-     T_OPEN_PAREN = 285,
-     T_ON = 286,
-     T_OR = 287,
-     T_AND = 288,
-     T_EQUAL = 289,
-     T_NOT = 290
-   };
-#endif
-#define T_MAINMENU 258
-#define T_MENU 259
-#define T_ENDMENU 260
-#define T_SOURCE 261
-#define T_CHOICE 262
-#define T_ENDCHOICE 263
-#define T_COMMENT 264
-#define T_CONFIG 265
-#define T_HELP 266
-#define T_HELPTEXT 267
-#define T_IF 268
-#define T_ENDIF 269
-#define T_DEPENDS 270
-#define T_REQUIRES 271
-#define T_OPTIONAL 272
-#define T_PROMPT 273
-#define T_DEFAULT 274
-#define T_TRISTATE 275
-#define T_BOOLEAN 276
-#define T_INT 277
-#define T_HEX 278
-#define T_WORD 279
-#define T_STRING 280
-#define T_UNEQUAL 281
-#define T_EOF 282
-#define T_EOL 283
-#define T_CLOSE_PAREN 284
-#define T_OPEN_PAREN 285
-#define T_ON 286
-#define T_OR 287
-#define T_AND 288
-#define T_EQUAL 289
-#define T_NOT 290
-
-
-
-
-#ifndef YYSTYPE
-#line 33 "zconf.y"
-typedef union {
-	int token;
-	char *string;
-	struct symbol *symbol;
-	struct expr *expr;
-	struct menu *menu;
-} yystype;
-/* Line 1281 of /usr/share/bison/yacc.c.  */
-#line 118 "zconf.tab.h"
-# define YYSTYPE yystype
-#endif
-
-extern YYSTYPE zconflval;
-
-
-#endif /* not BISON_ZCONF_TAB_H */
-
