Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUEQSGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUEQSGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 14:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUEQSGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 14:06:24 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62206 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261993AbUEQSGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 14:06:21 -0400
Date: Mon, 17 May 2004 11:06:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH][PPC32] Some fixes for 'make O=...'
Message-ID: <20040517180617.GM6763@smtp.west.cox.net>
References: <20040516025514.3fe93f0c.akpm@osdl.org> <20040517174221.GJ6763@smtp.west.cox.net> <20040517175448.GK6763@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517175448.GK6763@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some of the problems with 'make O=...'

Ack'd by Sam Ravnborg.

>From Geoffrey LEVAND <geoffrey.levand@am.sony.com>

 arch/ppc/boot/simple/Makefile |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)
--- 1.28/arch/ppc/boot/simple/Makefile	Wed Mar 17 19:43:04 2004
+++ edited/arch/ppc/boot/simple/Makefile	Mon May 17 08:20:35 2004
@@ -41,7 +41,7 @@
 # if present on 'classic' PPC.
 cacheflag-y	:= -DCLEAR_CACHES=""
 # This file will flush / disable the L2, and L3 if present.
-clear_L2_L3	:= $(boot)/simple/clear.S
+clear_L2_L3	:= $(srctree)/$(boot)/simple/clear.S
 
 #
 # See arch/ppc/kconfig and arch/ppc/platforms/Kconfig
@@ -125,7 +125,7 @@
 AFLAGS_head.o				+= $(cacheflag-y)
 
 # Linker args.  This specifies where the image will be run at.
-LD_ARGS				:= -T $(boot)/ld.script \
+LD_ARGS					:= -T $(srctree)/$(boot)/ld.script \
 				   -Ttext $(CONFIG_BOOT_LOAD) -Bstatic
 OBJCOPY_ARGS			:= -O elf32-powerpc
 
@@ -159,8 +159,8 @@
 
 targets := dummy.o
 
-$(obj)/zvmlinux: $(OBJS) $(LIBS) $(boot)/ld.script $(images)/vmlinux.gz \
-		$(obj)/dummy.o
+$(obj)/zvmlinux: $(OBJS) $(LIBS) $(srctree)/$(boot)/ld.script \
+		$(images)/vmlinux.gz $(obj)/dummy.o
 	$(OBJCOPY) $(OBJCOPY_ARGS) \
 		--add-section=.image=$(images)/vmlinux.gz \
 		--set-section-flags=.image=contents,alloc,load,readonly,data \
@@ -169,7 +169,7 @@
 	$(OBJCOPY) $(OBJCOPY_ARGS) $@ $@ -R .comment -R .stab \
 		-R .stabstr -R .ramdisk -R .sysmap
 
-$(obj)/zvmlinux.initrd: $(OBJS) $(LIBS) $(boot)/ld.script \
+$(obj)/zvmlinux.initrd: $(OBJS) $(LIBS) $(srctree)/$(boot)/ld.script \
 		$(images)/vmlinux.gz $(obj)/dummy.o
 	$(OBJCOPY) $(OBJCOPY_ARGS) \
 		--add-section=.ramdisk=$(images)/ramdisk.image.gz \
@@ -210,10 +210,10 @@
 	$(MKTREE) $(obj)/zvmlinux.initrd $(images)/zImage.initrd.$(end-y) \
 		$(ENTRYPOINT)
 
-$(images)/zImage-PPLUS: $(obj)/zvmlinux $(utils)/mkprep $(MKBUGBOOT)
+$(images)/zImage-PPLUS: $(obj)/zvmlinux $(MKPREP) $(MKBUGBOOT)
 	$(MKPREP) -pbp $(obj)/zvmlinux $(images)/zImage.$(end-y)
 	$(MKBUGBOOT) $(obj)/zvmlinux $(images)/zImage.bugboot
 
-$(images)/zImage.initrd-PPLUS: $(obj)/zvmlinux.initrd $(utils)/mkprep $(MKBUGBOOT)
+$(images)/zImage.initrd-PPLUS: $(obj)/zvmlinux.initrd $(MKPREP) $(MKBUGBOOT)
 	$(MKPREP) -pbp $(obj)/zvmlinux.initrd $(images)/zImage.initrd.$(end-y)
 	$(MKBUGBOOT) $(obj)/zvmlinux.initrd $(images)/zImage.initrd.bugboot

-- 
Tom Rini
http://gate.crashing.org/~trini/
