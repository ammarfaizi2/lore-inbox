Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSL3CoY>; Sun, 29 Dec 2002 21:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbSL3CoY>; Sun, 29 Dec 2002 21:44:24 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:65033 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265909AbSL3CoX>; Sun, 29 Dec 2002 21:44:23 -0500
Date: Mon, 30 Dec 2002 03:37:14 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: tabs on otherwise empty lines
In-Reply-To: <20021229222538.GK29422@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0212300300130.11574-100000@spit.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 29 Dec 2002, William Lee Irwin III wrote:

> The <HELP> state is willing to consume config options as part of help
> texts AFAICT:
>
> (1)	[ \t]+  {
> (2)	\n/[^ \t\n] {
> (3)	[ \t]*\n        {
> (4)	[^ \t\n].* {
> (5)	<<EOF>> {
>
> Now consider: "\tSome help text.\n\t\nconfig FOO\n\tdepends on BAR\n"

Try to change (2) into [ \t]*\n/[^ \t\n]
This should eat these empty lines correctly. I'll have to test it a bit
more. Thanks for finding this.

bye, Roman

--- linux/scripts/kconfig/zconf.l	2002-12-16 21:02:55.000000000 +0100
+++ linux/scripts/kconfig/zconf.l	2002-12-30 02:50:00.000000000 +0100
@@ -208,7 +208,7 @@
 		}

 	}
-	\n/[^ \t\n] {
+	[ \t]*\n/[^ \t\n] {
 		current_file->lineno++;
 		zconf_endhelp();
 		return T_HELPTEXT;
--- linux/scripts/kconfig/lex.zconf.c_shipped	2002-12-16 21:02:53.000000000 +0100
+++ linux/scripts/kconfig/lex.zconf.c_shipped	2002-12-30 02:50:06.000000000 +0100
@@ -853,10 +853,10 @@
     },

     {
-       11,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,
-      -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,
-      -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,
-      -76,  -76,  -76,  -76,  -76,  -76,  -76
+       11,   77,  -76,  -76,   77,   77,   77,   77,   77,   77,
+       77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
+       77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
+       77,   77,   77,   77,   77,   77,   77
     },

     {
@@ -2229,7 +2229,7 @@
 	YY_BREAK
 case 53:
 *yy_cp = yy_hold_char; /* undo effects of setting up yytext */
-yy_c_buf_p = yy_cp = yy_bp + 1;
+yy_c_buf_p = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up yytext again */
 YY_RULE_SETUP
 {



