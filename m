Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWDGOfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWDGOfL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWDGOc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:27 -0400
Received: from [151.97.230.9] ([151.97.230.9]:31964 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932301AbWDGOcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:23 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 08/17] uml: prepare fixing compilation output
Date: Fri, 07 Apr 2006 16:31:08 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143107.19201.23684.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Move the build of user-offsets to arch/um/Kbuild, this will allow using the
normal user-objs machinery. I had written this to fixup for a Kbuild change, but
another fix was merged. This is still useful however.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kbuild   |    4 ++++
 arch/um/Makefile |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kbuild b/arch/um/Kbuild
new file mode 100644
index 0000000..ae2a254
--- /dev/null
+++ b/arch/um/Kbuild
@@ -0,0 +1,4 @@
+ARCH_DIR := arch/um
+
+$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
+	$(CC) $(USER_CFLAGS) -S -o $@ $<
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 24790be..ef8d71d 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -202,8 +202,8 @@ endef
 $(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
 	$(call filechk,umlconfig)
 
-$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
-	$(CC) $(USER_CFLAGS) -S -o $@ $<
+$(ARCH_DIR)/user-offsets.s: FORCE
+	$(Q)$(MAKE) $(build)=$(ARCH_DIR) $@
 
 define filechk_gen-asm-offsets
         (set -e; \
