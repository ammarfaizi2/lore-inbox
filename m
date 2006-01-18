Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWARX7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWARX7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWARX7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:37 -0500
Received: from [151.97.230.9] ([151.97.230.9]:14313 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030483AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/8] uml: comments about libc-conflict guards
Date: Thu, 19 Jan 2006 00:55:00 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118235459.4626.36530.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While fixing myself the mktime conflict (which someone already merged), I also
improved a few comments. Merge them up.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 45435ff..936fd72 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -47,13 +47,16 @@ ARCH_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)
 endif
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
-# -Dvmap=kernel_vmap affects everything, and prevents anything from
-# referencing the libpcap.o symbol so named.
+# -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
+# named - it's a common symbol in libpcap, so we get a binary which crashes.
 #
-# Same things for in6addr_loopback - found in libc.
+# Same things for in6addr_loopback and mktime - found in libc. For these two we
+# only get link-time error, luckily.
+#
+# These apply to USER_CFLAGS to.
 
-CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
-	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap \
+CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\"	\
+	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
 	-Din6addr_loopback=kernel_in6addr_loopback
 
 AFLAGS += $(ARCH_INCLUDE)
@@ -66,6 +69,7 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
 # in CFLAGS.  Otherwise, it would cause ld to complain about the two different
 # errnos.
+# These apply to kernelspace only.
 
 CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
 	-Dmktime=kernel_mktime

