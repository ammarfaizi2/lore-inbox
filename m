Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271606AbTHMHeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 03:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271687AbTHMHeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 03:34:10 -0400
Received: from egeo.unipg.it ([141.250.1.4]:2758 "EHLO egeo.unipg.it")
	by vger.kernel.org with ESMTP id S271606AbTHMHeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 03:34:07 -0400
From: Francesco Sportolari <francesco@unipg.it>
Organization: University of Perugia - ITALY
To: linux-kernel@vger.kernel.org
Subject: [bug 1079] [PATCH] 2.6.0-test3: pmac ide driver doesn't compile
Date: Wed, 13 Aug 2003 09:34:56 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308130934.56092.francesco@unipg.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
the pmac IDE driver (drivers/ide/ppc/pmac.c) doesn't compile due to a change 
in ide_drive_s struct.
 
 Patch follows.

-- Francesco

--- old/drivers/ide/ppc/pmac.c	2003-08-11 11:45:27.000000000 +0200
+++ linux-2.6.0-test3/drivers/ide/ppc/pmac.c	2003-08-11 11:40:11.000000000 
+0200
@@ -942,7 +942,7 @@
 	if (hwif->sg_dma_active)
 		BUG();

-	nents = blk_rq_map_sg(&drive->queue, rq, sg);
+	nents = blk_rq_map_sg(drive->queue, rq, sg);

 	if (rq_data_dir(rq) == READ)
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
@@ -1589,7 +1589,7 @@
 		HWGROUP(drive)->busy = 1;
 		pmac_ide_dma_check(drive);
 		HWGROUP(drive)->busy = 0;
-		if (!list_empty(&drive->queue.queue_head))
+		if (!list_empty(&drive->queue->queue_head))
 			ide_do_request(HWGROUP(drive), 0);
 		spin_unlock_irq(&ide_lock);
 	}
@@ -1673,7 +1673,7 @@
 	/* We resume processing on the HW group */
 	spin_lock_irqsave(&ide_lock, flags);
 	HWGROUP(drive)->busy = 0;
-	if (!list_empty(&drive->queue.queue_head))
+	if (!list_empty(&drive->queue->queue_head))
 		ide_do_request(HWGROUP(drive), 0);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }


