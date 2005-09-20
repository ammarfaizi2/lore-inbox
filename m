Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVITJ2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVITJ2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 05:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVITJ2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 05:28:49 -0400
Received: from [213.132.87.177] ([213.132.87.177]:21949 "EHLO gserver.ymgeo.ru")
	by vger.kernel.org with ESMTP id S964946AbVITJ2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 05:28:48 -0400
From: Ustyugov Roman <dr_unique@ymg.ru>
To: thayumk@gmail.com, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kbuild: using well known kernel symbols as module names.
Date: Tue, 20 Sep 2005 13:32:31 +0400
User-Agent: KMail/1.8
References: <200509191432.58736.dr_unique@ymg.ru> <200509201213.44638.dr_unique@ymg.ru> <3b8510d8050920015139d45449@mail.gmail.com>
In-Reply-To: <3b8510d8050920015139d45449@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201332.32333.dr_unique@ymg.ru>
X-OriginalArrivalTime: 20 Sep 2005 09:36:12.0307 (UTC) FILETIME=[BD106630:01C5BDC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a Thayumanavar's (thayumk@gmail.com) patch with small changes.  I have 
to use double quotes, but not single ones.
Problem was solved.

--- linux/scripts/Makefile.lib.orig	2005-03-02 10:38:09.000000000 +0300
+++ linux/scripts/Makefile.lib	2005-09-20 13:14:13.000000000 +0400
@@ -96,7 +96,7 @@ depfile = $(subst $(comma),_,$(@D)/.$(@F
 #       than one module. In that case KBUILD_MODNAME will be set to foo_bar,
 #       where foo and bar are the name of the modules.
 basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
-modname_flags  = $(if $(filter 1,$(words 
$(modname))),-DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname))))
+modname_flags  = $(if $(filter 1,$(words $(modname))),-D"DUM(a)=\#a" 
-D"KBUILD_MODNAME=DUM($(subst $(comma),_,$(subst -,_,$(modname))))")
 
 _c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
--- linux/scripts/mod/modpost.c.orig	2005-07-23 04:41:06.000000000 +0400
+++ linux/scripts/mod/modpost.c	2005-09-20 13:19:21.000000000 +0400
@@ -575,7 +575,7 @@ add_header(struct buffer *b, struct modu
 	buf_printf(b, "#undef unix\n"); /* We have a module called "unix" */
 	buf_printf(b, "struct module __this_module\n");
 	buf_printf(b, "__attribute__((section(\".gnu.linkonce.this_module\"))) = 
{\n");
-	buf_printf(b, " .name = __stringify(KBUILD_MODNAME),\n");
+	buf_printf(b, " .name = KBUILD_MODNAME,\n");
 	if (mod->has_init)
 		buf_printf(b, " .init = init_module,\n");
 	if (mod->has_cleanup)

-- 
RomanU
