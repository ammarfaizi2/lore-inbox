Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWAXWeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWAXWeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWAXWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:34:12 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:64402 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750792AbWAXWeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:34:09 -0500
Message-Id: <200601242326.k0ONQ1kT008903@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/2] UML - Add a build dependency
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Jan 2006 18:26:01 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kern_constants.h now depends on arch/um/include to make sure it exists
before we try to create symlinks in it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/Makefile	2006-01-24 17:04:35.000000000 -0500
+++ linux-2.6.15-mm/arch/um/Makefile	2006-01-24 17:05:13.000000000 -0500
@@ -172,10 +172,13 @@ else
 	$(Q)cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
 endif
 
-$(ARCH_DIR)/include/sysdep:
+$(objtree)/$(ARCH_DIR)/include:
+	@echo '  MKDIR $@'
+	$(Q)mkdir -p $@
+
+$(ARCH_DIR)/include/sysdep: $(objtree)/$(ARCH_DIR)/include
 	@echo '  SYMLINK $@'
 ifneq ($(KBUILD_SRC),)
-	$(Q)mkdir -p $(ARCH_DIR)/include
 	$(Q)ln -fsn $(srctree)/$(ARCH_DIR)/include/sysdep-$(SUBARCH) $(ARCH_DIR)/include/sysdep
 else
 	$(Q)cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
@@ -218,7 +221,7 @@ $(ARCH_DIR)/include/user_constants.h: $(
 
 CLEAN_FILES += $(ARCH_DIR)/user-offsets.s
 
-$(ARCH_DIR)/include/kern_constants.h:
+$(ARCH_DIR)/include/kern_constants.h: $(objtree)/$(ARCH_DIR)/include
 	@echo '  SYMLINK $@'
 	$(Q) ln -sf ../../../include/asm-um/asm-offsets.h $@
 

