Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVEaXub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVEaXub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 19:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEaXub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 19:50:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60816 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261206AbVEaXuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 19:50:21 -0400
Date: Wed, 1 Jun 2005 01:50:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Blaisorblade <blaisorblade@yahoo.it>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch 1/1] kconfig: trivial cleanup
In-Reply-To: <200505312235.35234.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0506010149070.3728@scrub.home>
References: <20050529174525.A36D7A2FA3@zion.home.lan>
 <Pine.LNX.4.61.0505311123310.3728@scrub.home> <200505312235.35234.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 31 May 2005, Blaisorblade wrote:

> I can regenerate it only with bison 2.0, since that's what I have installed. 
> So if you don't want it to be regenerated, you cannot accept my patch. I 
> proposed sending two patches to avoid mixing the bison changes with this 
> patch changes, that's all.

What I meant is a patch like this:

Index: linux-2.6-mm/scripts/kconfig/zconf.tab.c_shipped
===================================================================
--- linux-2.6-mm.orig/scripts/kconfig/zconf.tab.c_shipped	2005-03-16 13:47:36.000000000 +0100
+++ linux-2.6-mm/scripts/kconfig/zconf.tab.c_shipped	2005-06-01 01:48:19.000000000 +0200
@@ -1531,7 +1531,7 @@ yyreduce:
 
     {
 	menu_add_entry(NULL);
-	menu_add_prop(P_MENU, yyvsp[-1].string, NULL, NULL);
+	menu_add_prompt(P_MENU, yyvsp[-1].string, NULL);
 	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1586,7 +1586,7 @@ yyreduce:
 
     {
 	menu_add_entry(NULL);
-	menu_add_prop(P_COMMENT, yyvsp[-1].string, NULL, NULL);
+	menu_add_prompt(P_COMMENT, yyvsp[-1].string, NULL);
 	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1640,7 +1640,7 @@ yyreduce:
   case 86:
 
     {
-	menu_add_prop(P_PROMPT, yyvsp[-1].string, NULL, yyvsp[0].expr);
+	menu_add_prompt(P_PROMPT, yyvsp[-1].string, yyvsp[0].expr);
 ;}
     break;
 
@@ -1925,7 +1925,7 @@ void conf_parse(const char *name)
 	sym_init();
 	menu_init();
 	modules_sym = sym_lookup("MODULES", 0);
-	rootmenu.prompt = menu_add_prop(P_MENU, "Linux Kernel Configuration", NULL, NULL);
+	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
 
 	//zconfdebug = 1;
 	zconfparse();

bye, Roman
