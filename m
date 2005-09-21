Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVIUQrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVIUQrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVIUQrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:47:05 -0400
Received: from [151.97.230.9] ([151.97.230.9]:34702 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751120AbVIUQrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:47:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 06/10] uml: Fix conflict between libc and ipv6
Date: Wed, 21 Sep 2005 18:39:32 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921163930.30500.68480.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

gcc is now complaining during link on some hosts - fix it as for other things.
Reported by Antoine Martin <antoine@nagafix.co.uk>.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -53,9 +53,13 @@ SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$
 
 # -Dvmap=kernel_vmap affects everything, and prevents anything from
 # referencing the libpcap.o symbol so named.
+#
+# Same things for in6addr_loopback - found in libc.
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
-	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap
+	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap \
+	-Din6addr_loopback=kernel_in6addr_loopback
+
 AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))

