Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWALRRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWALRRo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWALRRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:17:43 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:29883 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932278AbWALRRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:17:40 -0500
Date: Thu, 12 Jan 2006 18:17:27 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 10/13] s390: fix blk_queue_ordered call in dasd.c.
Message-ID: <20060112171727.GK16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 10/13] s390: fix blk_queue_ordered call in dasd.c.

Add the missing third argument to the blk_queue_ordered call and
use the constant QUEUE_ORDERED_DRAIN instead of "1".

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/block/dasd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-01-12 15:44:00.000000000 +0100
@@ -1635,7 +1635,7 @@ dasd_setup_queue(struct dasd_device * de
 	blk_queue_max_hw_segments(device->request_queue, -1L);
 	blk_queue_max_segment_size(device->request_queue, -1L);
 	blk_queue_segment_boundary(device->request_queue, -1L);
-	blk_queue_ordered(device->request_queue, 1);
+	blk_queue_ordered(device->request_queue, QUEUE_ORDERED_DRAIN, NULL);
 }
 
 /*
