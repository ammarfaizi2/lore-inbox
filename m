Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVDVPEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVDVPEG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVDVPDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:03:41 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:28155 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261968AbVDVPBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:01:42 -0400
Date: Fri, 22 Apr 2005 17:01:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 8/12] s390: enable write barriers in the dasd driver.
Message-ID: <20050422150109.GH17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 8/12] s390: enable write barriers in the dasd driver.

From: Stefan Weinhuber <wein@de.ibm.com>

The DASD device driver never reorders the I/O requests and relies on
the hardware to write all data to nonvolatile storage before signaling
a successful write. Hence, the only thing we have to do to support
write barriers is to set the queue ordered flag.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dasd.c |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-04-22 15:45:04.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-04-22 15:45:04.000000000 +0200
@@ -1635,6 +1635,7 @@ dasd_setup_queue(struct dasd_device * de
 	blk_queue_max_hw_segments(device->request_queue, -1L);
 	blk_queue_max_segment_size(device->request_queue, -1L);
 	blk_queue_segment_boundary(device->request_queue, -1L);
+	blk_queue_ordered(device->request_queue, 1);
 }
 
 /*
