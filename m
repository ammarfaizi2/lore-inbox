Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSE1D72>; Mon, 27 May 2002 23:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312486AbSE1D71>; Mon, 27 May 2002 23:59:27 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:29453 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S293203AbSE1D70>;
	Mon, 27 May 2002 23:59:26 -0400
Date: Mon, 27 May 2002 23:50:11 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.18 : drivers/pci/pool.c (revised)
Message-ID: <Pine.LNX.4.33.0205272347350.1518-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  Here's a revised patch for drivers/pci/pool.c that addresses the 
warning. This one fixes the cause. Please review for inclusion.

Regards,
Frank

--- drivers/pci/pool.c.old	Mon May 27 23:45:08 2002
+++ drivers/pci/pool.c	Mon May 27 23:45:13 2002
@@ -309,9 +309,9 @@
 		return;
 	}
 	if (page->bitmap [map] & (1UL << block)) {
-		printk (KERN_ERR "pci_pool_free %s/%s, dma %x already free\n",
+		printk (KERN_ERR "pci_pool_free %s/%s, dma %lx already free\n",
 			pool->dev ? pool->dev->slot_name : NULL,
-			pool->name, dma);
+	A		pool->name, (unsigned long) dma);
 		return;
 	}
 	memset (vaddr, POOL_POISON_BYTE, pool->size);

