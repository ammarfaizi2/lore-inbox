Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVAJFYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVAJFYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJFYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:24:08 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:17668
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262091AbVAJFOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:06 -0500
Message-Id: <200501100735.j0A7ZIPW005760@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/28] UML - x86-64 config support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:18 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds architecture-specific Kconfig support, plus Kconfig_i386 and
Kconfig_x86_64.  Currently the only option defined there is CONFIG_64_BIT.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.10/arch/um/Kconfig_i386
===================================================================
--- linux-2.6.10.orig/arch/um/Kconfig_i386	2005-01-04 17:02:27.000000000 -0500
+++ linux-2.6.10/arch/um/Kconfig_i386	2005-01-04 23:13:07.000000000 -0500
@@ -1,3 +1,6 @@
+config 64_BIT
+	bool
+	default n
 config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables"
 	default n
Index: linux-2.6.10/arch/um/Kconfig_x86_64
===================================================================
--- linux-2.6.10.orig/arch/um/Kconfig_x86_64	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.10/arch/um/Kconfig_x86_64	2005-01-04 23:13:07.000000000 -0500
@@ -0,0 +1,7 @@
+config 64_BIT
+	bool
+	default y
+
+config 3_LEVEL_PGTABLES
+       bool
+       default y
Index: linux-2.6.10/arch/um/Makefile
===================================================================
--- linux-2.6.10.orig/arch/um/Makefile	2005-01-04 23:13:05.000000000 -0500
+++ linux-2.6.10/arch/um/Makefile	2005-01-04 23:13:07.000000000 -0500
@@ -79,6 +79,8 @@
   echo '		   find in the kernel root.'
 endef
 
+$(shell cd $(ARCH_DIR) && ln -sf Kconfig_$(SUBARCH) Kconfig_arch)
+
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
 	$(ARCH_DIR)/kernel/vmlinux.lds.S
 

