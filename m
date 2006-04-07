Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWDGOgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWDGOgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWDGOgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:36:06 -0400
Received: from [151.97.230.9] ([151.97.230.9]:49372 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932357AbWDGOcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:25 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 16/17] uml: fix parallel make early failure on clean tree
Date: Fri, 07 Apr 2006 16:31:26 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143126.19201.92294.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Parallel make failed once for me - fix this by adding the appropriate command
(mkdir before creating a link in that dir).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index ef8d71d..e79454d 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -159,6 +159,7 @@ archclean:
 $(SYMLINK_HEADERS):
 	@echo '  SYMLINK $@'
 ifneq ($(KBUILD_SRC),)
+	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-um/$(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $@
 else
 	$(Q)cd $(TOPDIR)/$(dir $@) ; \
@@ -168,7 +169,7 @@ endif
 include/asm-um/arch:
 	@echo '  SYMLINK $@'
 ifneq ($(KBUILD_SRC),)
-	$(Q)mkdir -p include/asm-um
+	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-$(SUBARCH) include/asm-um/arch
 else
 	$(Q)cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
