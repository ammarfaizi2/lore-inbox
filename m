Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVELKfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVELKfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 06:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVELKfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 06:35:33 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:23213 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261413AbVELKfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 06:35:17 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 12 May 2005 12:30:43 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: saa7134: mark little endian ptr
Message-ID: <20050512103043.GB30474@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

> -			*ptr = sg_dma_address(list) - list->offset;
> +			*ptr = cpu_to_le32(sg_dma_address(list) - list->offset);

Clearly mark pointers to little-endian things.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Acked-by: Gerd Knorr <kraxel@bytesex.org>

diff -uprN linux-vanilla/drivers/media/video/saa7134/saa7134-core.c linux-saa/drivers/media/video/saa7134/saa7134-core.c
--- linux-vanilla/drivers/media/video/saa7134/saa7134-core.c	2005-05-10 03:13:22.000000000 +0400
+++ linux-saa/drivers/media/video/saa7134/saa7134-core.c	2005-05-12 00:27:23.000000000 +0400
@@ -316,7 +316,7 @@ unsigned long saa7134_buffer_base(struct
 
 int saa7134_pgtable_alloc(struct pci_dev *pci, struct saa7134_pgtable *pt)
 {
-        u32          *cpu;
+        __le32       *cpu;
         dma_addr_t   dma_addr;
 
 	cpu = pci_alloc_consistent(pci, SAA7134_PGTABLE_SIZE, &dma_addr);
@@ -332,7 +332,7 @@ int saa7134_pgtable_build(struct pci_dev
 			  struct scatterlist *list, unsigned int length,
 			  unsigned int startpage)
 {
-	u32           *ptr;
+	__le32        *ptr;
 	unsigned int  i,p;
 
 	BUG_ON(NULL == pt || NULL == pt->cpu);
diff -uprN linux-vanilla/drivers/media/video/saa7134/saa7134.h linux-saa/drivers/media/video/saa7134/saa7134.h
--- linux-vanilla/drivers/media/video/saa7134/saa7134.h	2005-05-10 03:13:22.000000000 +0400
+++ linux-saa/drivers/media/video/saa7134/saa7134.h	2005-05-12 00:26:20.000000000 +0400
@@ -241,7 +241,7 @@ struct saa7134_dma;
 /* saa7134 page table */
 struct saa7134_pgtable {
 	unsigned int               size;
-	u32                        *cpu;
+	__le32                     *cpu;
 	dma_addr_t                 dma;
 };
 

----- End forwarded message -----

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3
