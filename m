Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVIJSHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVIJSHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVIJSHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:07:43 -0400
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]:31656 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932228AbVIJSE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:04:27 -0400
Message-Id: <20050910174626.850521000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
Date: Sat, 10 Sep 2005 19:44:53 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: [patch 1/7] Uml: more cleaning
Content-Disposition: inline; filename=uml-more-clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We must remove even arch/um/os-Linux/util/mk_user_constants, which we don't do.
Also, Kconfig_arch must be listed only once, between CLEAN_FILES.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -103,7 +103,6 @@ endef
 
 ifneq ($(KBUILD_SRC),)
 $(shell mkdir -p $(ARCH_DIR) && ln -fsn $(srctree)/$(ARCH_DIR)/Kconfig.$(SUBARCH) $(ARCH_DIR)/Kconfig.arch)
-CLEAN_FILES += $(ARCH_DIR)/Kconfig.arch
 else
 $(shell cd $(ARCH_DIR) && ln -sf Kconfig.$(SUBARCH) Kconfig.arch)
 endif
@@ -144,14 +143,14 @@ endef
 #TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/include/uml-config.h \
 	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h \
-	$(ARCH_DIR)/include/user_constants.h
+	$(ARCH_DIR)/include/user_constants.h $(ARCH_DIR)/Kconfig.arch
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
-	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os \
-	$(ARCH_DIR)/Kconfig.arch
+	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/util
+	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/os-$(OS)/util
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 

--
