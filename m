Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVCNVXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVCNVXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVCNVXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:23:40 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:6926 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261929AbVCNVWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:22:20 -0500
Date: Mon, 14 Mar 2005 22:22:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kai@germaschewski.name
Subject: Re: 2.6.11-bk10 build problems
Message-ID: <20050314212234.GC17925@mars.ravnborg.org>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kai@germaschewski.name
References: <1110829177.19340.8.camel@localhost> <20050314194930.GB17373@mars.ravnborg.org> <566920000.1110832470@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566920000.1110832470@flay>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 
> > On popular request 'make install' no longer try to update vmlinux.
> > This is to avoid errornous recompilation when installing the kernel
> > as root especially when fetching kernel via nfs where path may have
> > changed.
> 
> That's frigging annoying. It's worked that way for ages, and all our
> scripts assume it works. 

The reason to put it in -mm is to check how things are used.
I will change it back and add an:
make kernel_install

kernel_install is then analogous to modules_install

	Sam

===== arch/i386/Makefile 1.80 vs edited =====
--- 1.80/arch/i386/Makefile	2005-03-12 08:48:59 +01:00
+++ edited/arch/i386/Makefile	2005-03-14 22:20:56 +01:00
@@ -123,7 +123,7 @@
 boot := arch/i386/boot
 
 .PHONY: zImage bzImage compressed zlilo bzlilo \
-	zdisk bzdisk fdimage fdimage144 fdimage288 install
+	zdisk bzdisk fdimage fdimage144 fdimage288 install kernel_install
 
 all: bzImage
 
@@ -145,8 +145,9 @@
 fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
 
-install:
-	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
+install: vmlinux
+install kernel_install:
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
 
 prepare: include/asm-$(ARCH)/asm_offsets.h
 CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h

