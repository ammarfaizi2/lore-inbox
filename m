Return-Path: <linux-kernel-owner+w=401wt.eu-S1754673AbXAAT0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbXAAT0q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbXAAT0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:26:46 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:42263 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673AbXAAT0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:26:45 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] kconfig: remove the unused "requires" syntax
Date: Mon, 1 Jan 2007 20:08:54 +0100
User-Agent: KMail/1.9.5
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0612181138360.27491@localhost.localdomain> <Pine.LNX.4.64.0612191850220.1867@scrub.home> <20061228210521.GG20714@stusta.de>
In-Reply-To: <20061228210521.GG20714@stusta.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GxVmFO4RGToS8XD"
Message-Id: <200701012008.54631.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GxVmFO4RGToS8XD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday 28 December 2006 22:05, Adrian Bunk wrote:

> How to add some warning prints?

Simple, see the attached patch.

> And what's the problem with changing the generated files?
> There doesn't seem to be much activity in this area, and the noise of
> changing the generated files doesn't seem to be a problem for me (except
> if anyone else is semnding patches for the same area at the same time.
> It's not as if this noise was big compared to the diff between two Linux
> releases...

The additional syntax doesn't hurt anyone, thus I prefer the simpler change.

> Regarding external trees:
> Do you know about anyone actually using it?

No and that's not the point, there is simply no need to change the syntax this 
drastically. Just printing a warning is sufficient, which actually tells the 
user more specifically what to change, instead of an anonymous syntax error.

bye, Roman

--Boundary-00=_GxVmFO4RGToS8XD
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="requires_warn.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="requires_warn.patch"

---
 scripts/kconfig/zconf.tab.c_shipped |    2 ++
 scripts/kconfig/zconf.y             |    2 ++
 2 files changed, 4 insertions(+)

Index: linux-2.6/scripts/kconfig/zconf.tab.c_shipped
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.tab.c_shipped	2007-01-01 19:54:14.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.tab.c_shipped	2007-01-01 19:55:16.000000000 +0100
@@ -1738,6 +1738,7 @@ yyreduce:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
+	zconfprint("warning: 'depends' used without 'on' keyword");
 	printd(DEBUG_PARSE, "%s:%d:depends\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1746,6 +1747,7 @@ yyreduce:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
+	zconfprint("warning: 'requires' keyword is deprecated");
 	printd(DEBUG_PARSE, "%s:%d:requires\n", zconf_curname(), zconf_lineno());
 ;}
     break;
Index: linux-2.6/scripts/kconfig/zconf.y
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.y	2007-01-01 19:52:20.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.y	2007-01-01 19:53:57.000000000 +0100
@@ -422,11 +422,13 @@ depends: T_DEPENDS T_ON expr T_EOL
 	| T_DEPENDS expr T_EOL
 {
 	menu_add_dep($2);
+	zconfprint("warning: 'depends' used without 'on' keyword");
 	printd(DEBUG_PARSE, "%s:%d:depends\n", zconf_curname(), zconf_lineno());
 }
 	| T_REQUIRES expr T_EOL
 {
 	menu_add_dep($2);
+	zconfprint("warning: 'requires' keyword is deprecated");
 	printd(DEBUG_PARSE, "%s:%d:requires\n", zconf_curname(), zconf_lineno());
 };
 

--Boundary-00=_GxVmFO4RGToS8XD--
