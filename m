Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUHVPDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUHVPDK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUHVPDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:03:10 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:5257 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267360AbUHVPDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:03:07 -0400
Date: Sun, 22 Aug 2004 17:03:02 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.8.1-mm3: nsc-ircc driver crashes on shutdown
Message-ID: <20040822150302.GF24092@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  bk-dma-decleare-coherent-memory patch adds a requirement for dma_free_coherent
that dev cannot be NULL... But it can (nsc-ircc has no suitable dev) and as
dma_alloc_coherent allows NULL dev, dma_free_coherent should allow it too
IMHO.
						Thanks,
							Petr Vandrovec


diff -urN linux/arch/i386/kernel/pci-dma.c linux/arch/i386/kernel/pci-dma.c
--- linux/arch/i386/kernel/pci-dma.c	2004-08-21 00:51:49.000000000 +0200
+++ linux/arch/i386/kernel/pci-dma.c	2004-08-21 13:51:03.000000000 +0200
@@ -58,7 +58,7 @@
 void dma_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
-	struct dma_coherent_mem *mem = dev->dma_mem;
+	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
 	int order = get_order(size);
 	
 	if (mem && vaddr >= mem->virt_base && vaddr < (mem->virt_base + (mem->size << PAGE_SHIFT))) {
