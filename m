Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVAJFrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVAJFrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVAJFqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:46:22 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:35076
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262113AbVAJFO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:58 -0500
Message-Id: <200501100736.j0A7aEPW005860@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, cw@foof.org
Subject: [PATCH 26/28] UML - Fix make clean
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:36:14 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Chris Wright - make clean gets rid of more stuff

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/Makefile
===================================================================
--- 2.6.10.orig/arch/um/Makefile	2005-01-07 22:58:55.000000000 -0500
+++ 2.6.10/arch/um/Makefile	2005-01-09 15:46:08.000000000 -0500
@@ -14,11 +14,15 @@
 core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/drivers/
 
+clean-dirs := sys-$(SUBARCH)
+
 # Have to precede the include because the included Makefiles reference them.
 SYMLINK_HEADERS = archparam.h system.h sigcontext.h processor.h ptrace.h \
 	arch-signal.h module.h vm-flags.h
 SYMLINK_HEADERS := $(foreach header,$(SYMLINK_HEADERS),include/asm-um/$(header))
 
+CLEAN_FILES += $(ARCH_SYMLINKS)
+
 ARCH_SYMLINKS = include/asm-um/arch $(ARCH_DIR)/include/sysdep $(ARCH_DIR)/os \
 	$(SYMLINK_HEADERS) $(ARCH_DIR)/include/uml-config.h
 
@@ -81,6 +85,9 @@
 
 $(shell cd $(ARCH_DIR) && ln -sf Kconfig_$(SUBARCH) Kconfig_arch)
 
+CLEAN_FILES += $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h \
+	$(TOPDIR)/$(ARCH_DIR)/os
+
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
 	$(ARCH_DIR)/kernel/vmlinux.lds.S
 
@@ -141,7 +148,8 @@
 #When cleaning we don't include .config, so we don't include
 #TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/include/uml-config.h \
-	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h
+	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h \
+	$(ARCH_DIR)/util/mk_constants $(ARCH_DIR)/util/mk_task
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
 	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os

