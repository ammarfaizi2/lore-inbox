Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbUKRRue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbUKRRue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUKRRrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:47:12 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:8710 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S262808AbUKRRnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:43:43 -0500
Subject: [patch 1/1] uml: partial KBUILD_OUTPUT fix
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 18 Nov 2004 18:23:04 +0100
Message-Id: <20041118172304.02EE055C9B@zion.localdomain>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.80; host: ssc.unict.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Start fixing KBUILD_OUTPUT support for UML. These changes are trivial and
no-ops when this feature is not enabled - the "hard part" of this support is
under discussion because it's hard to do properly (UML uses both shipped and
build-generated headers from a lot of different directories, and for good
reasons).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/um/Makefile~uml-KBUILD_OUTPUT-fix arch/um/Makefile
--- linux-2.6.10-rc/arch/um/Makefile~uml-KBUILD_OUTPUT-fix	2004-11-18 18:18:20.916697608 +0100
+++ linux-2.6.10-rc-paolo/arch/um/Makefile	2004-11-18 18:18:20.918697304 +0100
@@ -29,14 +29,14 @@ MAKEFILE-$(CONFIG_MODE_TT) += Makefile-t
 MAKEFILE-$(CONFIG_MODE_SKAS) += Makefile-skas
 
 ifneq ($(MAKEFILE-y),)
-  include $(addprefix $(ARCH_DIR)/,$(MAKEFILE-y))
+  include $(addprefix $(srctree)/$(ARCH_DIR)/,$(MAKEFILE-y))
 endif
 
 ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
-include $(ARCH_DIR)/Makefile-$(SUBARCH)
-include $(ARCH_DIR)/Makefile-os-$(OS)
+include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
_
