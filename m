Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVLPWf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVLPWf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVLPWf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:35:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25832 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964790AbVLPWf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:35:28 -0500
To: torvalds@osdl.org
Subject: [PATCH] ppc: ppc4xx_dma DMA_MODE_{READ,WRITE} fix
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <E1EnOAd-0006JR-TM@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Fri, 16 Dec 2005 22:35:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DMA_MODE_{READ,WRITE} are declared in asm-powerpc/dma.h and their
declarations there match the definitions.  Old declarations in
ppc4xx_dma.h are not right anymore (wrong type, to start with).
Killed them, added include of asm/dma.h where needed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 arch/ppc/syslib/ppc4xx_dma.c |    1 +
 include/asm-ppc/ppc4xx_dma.h |    3 ---
 2 files changed, 1 insertions(+), 3 deletions(-)

fc830a6f62230c04590f711798ea8de44e567439
diff --git a/arch/ppc/syslib/ppc4xx_dma.c b/arch/ppc/syslib/ppc4xx_dma.c
index f15e642..05ccd59 100644
--- a/arch/ppc/syslib/ppc4xx_dma.c
+++ b/arch/ppc/syslib/ppc4xx_dma.c
@@ -30,6 +30,7 @@
 
 #include <asm/system.h>
 #include <asm/io.h>
+#include <asm/dma.h>
 #include <asm/ppc4xx_dma.h>
 
 ppc_dma_ch_t dma_channels[MAX_PPC4xx_DMA_CHANNELS];
diff --git a/include/asm-ppc/ppc4xx_dma.h b/include/asm-ppc/ppc4xx_dma.h
index a415001..46a086f 100644
--- a/include/asm-ppc/ppc4xx_dma.h
+++ b/include/asm-ppc/ppc4xx_dma.h
@@ -33,9 +33,6 @@
 
 #define MAX_PPC4xx_DMA_CHANNELS		4
 
-/* in arch/ppc/kernel/setup.c -- Cort */
-extern unsigned long DMA_MODE_WRITE, DMA_MODE_READ;
-
 /*
  * Function return status codes
  * These values are used to indicate whether or not the function
-- 
0.99.9.GIT

