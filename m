Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSFJX4o>; Mon, 10 Jun 2002 19:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316572AbSFJX4n>; Mon, 10 Jun 2002 19:56:43 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:64240 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316571AbSFJX4n>; Mon, 10 Jun 2002 19:56:43 -0400
Date: Mon, 10 Jun 2002 19:56:44 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: highmem pci dma mapping does not work, missing cast in asm-i386/pci.h
Message-ID: <20020610195644.C13225@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

There's a missing cast in pci_map_page that causes 64 bit capable 
drivers to access the wrong memory for highmem pages.  Please 
include the patch below to fix it.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.4/v2.4.19-pre10-pci_highmem.diff
diff -urN v2.4.19-pre10/include/asm-i386/pci.h pci-v2.4.19-pre10/include/asm-i386/pci.h
--- v2.4.19-pre10/include/asm-i386/pci.h	Thu Jun  6 20:10:08 2002
+++ pci-v2.4.19-pre10/include/asm-i386/pci.h	Mon Jun 10 19:54:16 2002
@@ -103,7 +103,7 @@
 	if (direction == PCI_DMA_NONE)
 		out_of_line_bug();
 
-	return (page - mem_map) * PAGE_SIZE + offset;
+	return (dma_addr_t)(page - mem_map) * PAGE_SIZE + offset;
 }
 
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
