Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270161AbTGPF6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 01:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270164AbTGPF6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 01:58:12 -0400
Received: from [66.212.224.118] ([66.212.224.118]:47378 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270161AbTGPF6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 01:58:09 -0400
Date: Wed, 16 Jul 2003 02:01:38 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: bcollins@debian.org
Subject: [PATCH][2.6] Fix warning in iee1394 dma.c
Message-ID: <Pine.LNX.4.53.0307160156480.32541@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also removed the panic, the BUG should shaft things bad enough.

drivers/ieee1394/dma.c: In function `dma_region_find':
drivers/ieee1394/dma.c:161: warning: control reaches end of non-void function

Index: linux-2.5/drivers/ieee1394/dma.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/ieee1394/dma.c,v
retrieving revision 1.5
diff -u -p -B -r1.5 dma.c
--- linux-2.5/drivers/ieee1394/dma.c	27 Jun 2003 04:49:52 -0000	1.5
+++ linux-2.5/drivers/ieee1394/dma.c	16 Jul 2003 03:46:10 -0000
@@ -157,7 +157,9 @@ static inline int dma_region_find(struct
 		off -= sg_dma_len(&dma->sglist[i]);
 	}
 
-	panic("dma_region_find: offset %lu beyond end of DMA mapping\n", offset);
+	printk("dma_region_find: offset %lu beyond end of DMA mapping\n", offset);
+	BUG();
+	return -ENOENT;
 }
 
 dma_addr_t dma_region_offset_to_bus(struct dma_region *dma, unsigned long offset)
