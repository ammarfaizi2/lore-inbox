Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVBIOXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVBIOXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 09:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVBIOXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 09:23:41 -0500
Received: from smtp.gentoo.org ([156.56.111.197]:8384 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261825AbVBIOXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 09:23:39 -0500
From: Stefan Knoblich <stkn@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 - alpha: add missing dma_mapping_error
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Date: Wed, 9 Feb 2005 15:23:45 +0100
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xi2zBPjl5P1VNkg";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502091523.45868.stkn@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

attached patch defines dma_mapping_error on alpha. Without this libata-core.c 
won't compile.

stefan

--- linux-2.6.10/include/asm-alpha/dma-mapping.h.orig 2004-12-26 
20:45:25.139475104 +0100
+++ linux-2.6.10/include/asm-alpha/dma-mapping.h 2004-12-26 20:46:54.684862136 
+0100
@@ -25,6 +25,8 @@
   pci_unmap_sg(alpha_gendev_to_pci(dev), sg, nents, dir)
 #define dma_supported(dev, mask)   \
   pci_dma_supported(alpha_gendev_to_pci(dev), mask)
+#define dma_mapping_error(addr)   \
+  pci_dma_mapping_error(addr)
 
 #else /* no PCI - no IOMMU. */
 
@@ -43,6 +45,8 @@
 #define dma_unmap_page(dev, addr, size, dir) do { } while (0)
 #define dma_unmap_sg(dev, sg, nents, dir) do { } while (0)
 
+#define dma_mapping_error(addr)  (0)
+
 #endif /* !CONFIG_PCI */
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
