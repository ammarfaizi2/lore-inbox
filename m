Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWDJN3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWDJN3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 09:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWDJN3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 09:29:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58546 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751148AbWDJN3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 09:29:05 -0400
Date: Mon, 10 Apr 2006 15:29:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] kconfig: move .kernelrelease
In-Reply-To: <20060410025851.641022a0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604101523031.32445@scrub.home>
References: <Pine.LNX.4.64.0604091728560.23148@scrub.home>
 <20060410015727.69b5c1f6.akpm@osdl.org> <20060410104250.GA24160@mars.ravnborg.org>
 <20060410025851.641022a0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Apr 2006, Andrew Morton wrote:

> hm, it takes nearly five seconds, but it wasn't that - something actually
> broke.  But I forget what it was.  I'll put it back and will wait for it
> to reoccur.

The patch below should speed this up. You know that you have to update 
this file explicitly?

bye, Roman

---

 Makefile |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6-git/Makefile
===================================================================
--- linux-2.6-git.orig/Makefile
+++ linux-2.6-git/Makefile
@@ -366,7 +366,8 @@ outputmakefile:
 # of make so .config is not included in this case either (for *config).
 
 no-dot-config-targets := clean mrproper distclean \
-			 cscope TAGS tags help %docs check%
+			 cscope TAGS tags help %docs check% \
+			 kernelrelease kernelversion
 
 config-targets := 0
 mixed-targets  := 0
@@ -1251,7 +1252,7 @@ namespacecheck:
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 
-PHONY += checkstack
+PHONY += checkstack kernelrelease kernelversion
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
