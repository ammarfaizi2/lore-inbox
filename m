Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUEEGUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUEEGUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 02:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUEEGUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 02:20:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:37551 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263003AbUEEGUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 02:20:53 -0400
Subject: [PATCH] ppc32: Add missing [pci_]dma_mapping_error()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083737764.19138.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 16:16:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Those were missing from ppc32, please apply.

Ben.

diff -urN linux-2.5/include/asm-ppc/dma-mapping.h linuxppc-2.5-benh/include/asm-ppc/dma-mapping.h
--- linux-2.5/include/asm-ppc/dma-mapping.h	2004-05-03 09:30:28.000000000 +1000
+++ linuxppc-2.5-benh/include/asm-ppc/dma-mapping.h	2004-05-04 15:06:15.000000000 +1000
@@ -184,4 +184,10 @@
 {
 	consistent_sync(vaddr, size, (int)direction);
 }
+
+static inline int dma_mapping_error(dma_addr_t dma_addr)
+{
+	return 0;
+}
+
 #endif				/* __ASM_PPC_DMA_MAPPING_H */
diff -urN linux-2.5/include/asm-ppc/pci.h linuxppc-2.5-benh/include/asm-ppc/pci.h
--- linux-2.5/include/asm-ppc/pci.h	2004-05-03 09:30:28.000000000 +1000
+++ linuxppc-2.5-benh/include/asm-ppc/pci.h	2004-05-04 15:06:23.000000000 +1000
@@ -290,6 +290,11 @@
 	/* Nothing to do. */
 }
 
+static inline int pci_dma_mapping_error(dma_addr_t dma_addr)
+{
+	return 0;
+}
+
 /* Return the index of the PCI controller for device PDEV. */
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 


