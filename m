Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSFKB6X>; Mon, 10 Jun 2002 21:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316657AbSFKB6W>; Mon, 10 Jun 2002 21:58:22 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:42487 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316650AbSFKB6V>; Mon, 10 Jun 2002 21:58:21 -0400
Date: Mon, 10 Jun 2002 21:58:23 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] pci dma patch rediffed for 2.5.21
Message-ID: <20020610215823.E13225@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This is the same patch as was posted against 2.4.19-pre10: pci_map_page 
was missing a cast on x86, which resulted in the high 32 bits of an 
address being silently discarded.  This patch fixes that by casting 
the page number before multiplying it out.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.5/v2.5.21-pci.diff
diff -urN v2.5.21/include/asm-i386/pci.h pci/include/asm-i386/pci.h
--- v2.5.21/include/asm-i386/pci.h	Mon Jun 10 21:41:10 2002
+++ pci/include/asm-i386/pci.h	Mon Jun 10 21:54:11 2002
@@ -109,7 +109,7 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	return (page - mem_map) * PAGE_SIZE + offset;
+	return (dma_addr_t)(page - mem_map) * PAGE_SIZE + offset;
 }
 
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
