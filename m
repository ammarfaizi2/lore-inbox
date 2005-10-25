Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVJYWMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVJYWMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVJYWLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:11:20 -0400
Received: from [151.97.230.9] ([151.97.230.9]:44472 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932440AbVJYWLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:11:18 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/6] uml: remove old UM_FASTCALL, and make the thing work again
Date: Wed, 26 Oct 2005 00:12:30 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025221229.21106.22616.stgit@zion.home.lan>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This was used in the old dark age of 2.4, ARCH_CFLAGS doesn't work any more
since some time, and UM_FASTCALL was never used in 2.6.

Instead, reintroduce the thing more properly now, directly in
include/asm-um/linkage.h.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-i386    |    4 ----
 include/asm-um/linkage.h |    8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -29,10 +29,6 @@ endif
 
 CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
 
-ifneq ($(CONFIG_GPROF),y)
-ARCH_CFLAGS += -DUM_FASTCALL
-endif
-
 # First of all, tune CFLAGS for the specific CPU. This actually sets cflags-y.
 include $(srctree)/arch/i386/Makefile.cpu
 
diff --git a/include/asm-um/linkage.h b/include/asm-um/linkage.h
--- a/include/asm-um/linkage.h
+++ b/include/asm-um/linkage.h
@@ -3,4 +3,12 @@
 
 #include "asm/arch/linkage.h"
 
+#include <linux/config.h>
+
+/* <linux/linkage.h> will pick sane defaults */
+#ifdef CONFIG_GPROF
+#undef FASTCALL
+#undef fastcall
+#endif
+
 #endif

