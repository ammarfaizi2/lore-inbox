Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVEAVUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVEAVUu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVEAVTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:19:49 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:23315 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262683AbVEAVS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:29 -0400
Message-Id: <200505012112.j41LCHjt016392@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH 2/22] UML - Use variables rather than symlinks in dependencies
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

	Use explicit os-... in make dependencies instead of playing with
symlinks (symlink in question is still created - it's needed for other
things; however, there's no reason to complicate ordering here).

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -urN RC12-rc3-uml-ldscript/arch/um/Makefile RC12-rc3-uml-os/arch/um/Makefile
--- RC12-rc3-uml-ldscript/arch/um/Makefile	Wed Apr 27 17:07:20 2005
+++ RC12-rc3-uml-os/arch/um/Makefile	Wed Apr 27 17:07:21 2005
@@ -169,7 +169,7 @@
 $(ARCH_DIR)/include/task.h: $(ARCH_DIR)/util/mk_task
 	$(call filechk,gen_header)
 
-$(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/os/util/mk_user_constants
+$(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/os-$(OS)/util/mk_user_constants
 	$(call filechk,gen_header)
 
 $(ARCH_DIR)/include/kern_constants.h: $(ARCH_DIR)/util/mk_constants
@@ -178,7 +178,7 @@
 $(ARCH_DIR)/include/skas_ptregs.h: $(ARCH_DIR)/kernel/skas/util/mk_ptregs
 	$(call filechk,gen_header)
 
-$(ARCH_DIR)/os/util/mk_user_constants: $(ARCH_DIR)/os/util FORCE ;
+$(ARCH_DIR)/os-$(OS)/util/mk_user_constants: $(ARCH_DIR)/os-$(OS)/util FORCE ;
 
 $(ARCH_DIR)/util/mk_task $(ARCH_DIR)/util/mk_constants: $(ARCH_DIR)/include/user_constants.h $(ARCH_DIR)/util \
 	FORCE ;
@@ -191,7 +191,7 @@
 $(ARCH_DIR)/kernel/skas/util: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=$@
 
-$(ARCH_DIR)/os/util: scripts_basic FORCE
+$(ARCH_DIR)/os-$(OS)/util: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=$@
 
 export SUBARCH USER_CFLAGS OS

