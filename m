Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUJNWOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUJNWOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUJNWOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:14:22 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:46469
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S267263AbUJNWFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:05:38 -0400
Subject: [patch 1/1] uml: readd linux Makefile target
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Fri, 15 Oct 2004 00:05:53 +0200
Message-Id: <20041014220554.0F20244BE@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since people are used to doing "make linux ARCH=um" and to use "linux" as the
kernel image, make it be an hard link to vmlinux. This should hurt the less
possible the users (actually nothing) while not slowing down the build.

Acked-by: Jeff Dike <jdike@addtoit.com>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN arch/um/Makefile~uml-readd-linux-target arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-readd-linux-target	2004-10-14 22:52:47.274383552 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-14 22:52:47.276383248 +0200
@@ -62,6 +62,18 @@ ifeq ($(CONFIG_MODE_SKAS), y)
 $(SYS_HEADERS) : $(ARCH_DIR)/include/skas_ptregs.h
 endif
 
+all: linux
+
+linux: vmlinux
+	$(RM) $@
+	ln $< $@
+
+define archhelp
+  echo '* linux		- Binary kernel image (./linux) - for backward'
+  echo '		   compatibility only: now you can simply run'
+  echo '		   the vmlinux binary you find in the kernel root.'
+endef
+
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
 	$(ARCH_DIR)/kernel/vmlinux.lds.S
 
_
