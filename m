Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWJIBLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWJIBLx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 21:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWJIBLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 21:11:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:63965 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751581AbWJIBLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 21:11:52 -0400
Date: Mon, 9 Oct 2006 02:11:47 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: sammy@sammy.net, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k/kernel/dma.c assumes !MMU_SUN3
Message-ID: <20061009011146.GK29920@ftp.linux.org.uk>
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
index c1299c3..d90d841 100644
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

