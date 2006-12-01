Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936516AbWLAPhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936516AbWLAPhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936518AbWLAPhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:37:09 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:22024 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936516AbWLAPhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:37:08 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] sparc64 dma parenthesis fixes
Date: Fri, 1 Dec 2006 16:36:42 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011636.42849.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes some sparc64 dma macros.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-sparc64/dma.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.4.34-pre6-a/include/asm-sparc64/dma.h	2000-02-01 08:37:19.000000000 +0100
+++ linux-2.4.34-pre6-b/include/asm-sparc64/dma.h	2006-12-01 12:00:23.000000000 +0100
@@ -153,9 +153,9 @@ extern void dvma_init(struct sbus_bus *)
 #define DMA_MAXEND(addr) (0x01000000UL-(((unsigned long)(addr))&0x00ffffffUL))
 
 /* Yes, I hack a lot of elisp in my spare time... */
-#define DMA_ERROR_P(regs)  (((sbus_readl((regs) + DMA_CSR) & DMA_HNDL_ERROR))
-#define DMA_IRQ_P(regs)    (((sbus_readl((regs) + DMA_CSR)) & (DMA_HNDL_INTR | DMA_HNDL_ERROR)))
-#define DMA_WRITE_P(regs)  (((sbus_readl((regs) + DMA_CSR) & DMA_ST_WRITE))
+#define DMA_ERROR_P(regs)  (sbus_readl((regs) + DMA_CSR) & DMA_HNDL_ERROR)
+#define DMA_IRQ_P(regs)    ((sbus_readl((regs) + DMA_CSR)) & (DMA_HNDL_INTR | DMA_HNDL_ERROR))
+#define DMA_WRITE_P(regs)  (sbus_readl((regs) + DMA_CSR) & DMA_ST_WRITE)
 #define DMA_OFF(__regs)		\
 do {	u32 tmp = sbus_readl((__regs) + DMA_CSR); \
 	tmp &= ~DMA_ENABLE; \


-- 
Regards,

	Mariusz Kozlowski
