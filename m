Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWJDN2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWJDN2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWJDN2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:28:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39341 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932417AbWJDN2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:28:53 -0400
Date: Wed, 4 Oct 2006 14:28:52 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: sammy@sammy.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] m68k/kernel/dma.c assumes !MMU_SUN3
Message-ID: <20061004132851.GL29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/kernel/Makefile      |    3 ++-
 include/asm-m68k/dma-mapping.h |    5 +++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index dae6097..1c9ecaa 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -9,10 +9,11 @@ else
 endif
 extra-y	+= vmlinux.lds
 
-obj-y	:= entry.o process.o traps.o ints.o dma.o signal.o ptrace.o \
+obj-y	:= entry.o process.o traps.o ints.o signal.o ptrace.o \
 	   sys_m68k.o time.o semaphore.o setup.o m68k_ksyms.o
 
 obj-$(CONFIG_PCI)	+= bios32.o
 obj-$(CONFIG_MODULES)	+= module.o
+obj-y$(CONFIG_MMU_SUN3) += dma.o	# no, it's not a typo
 
 EXTRA_AFLAGS := -traditional
diff --git a/include/asm-m68k/dma-mapping.h b/include/asm-m68k/dma-mapping.h
index cebbb03..ad33e57 100644
--- a/include/asm-m68k/dma-mapping.h
+++ b/include/asm-m68k/dma-mapping.h
@@ -5,6 +5,7 @@ #include <asm/cache.h>
 
 struct scatterlist;
 
+#ifndef CONFIG_MMU_SUN3
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	return 1;
@@ -88,4 +89,8 @@ static inline int dma_mapping_error(dma_
 	return 0;
 }
 
+#else
+#include <asm-generic/dma-mapping-broken.h>
+#endif
+
 #endif  /* _M68K_DMA_MAPPING_H */
-- 
1.4.2.GIT


