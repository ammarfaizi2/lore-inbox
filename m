Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWAMM0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWAMM0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWAMM0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:26:34 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:8670 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964813AbWAMM0d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:26:33 -0500
Date: Fri, 13 Jan 2006 13:26:26 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: fix blk_queue_ordered call in dasd.c fixup
Message-ID: <20060113122626.GC8268@osiris.boeblingen.de.ibm.com>
References: <20060112171727.GK16629@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112171727.GK16629@skybase.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The QUEUE_ORDERED_* numbers got renumbered and by accident the dasd driver
was changed to use QUEUE_ORDERED_DRAIN instead of QUEUE_ORDERED_TAG.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -urN a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
--- a/drivers/s390/block/dasd.c	2006-01-13 12:15:58.000000000 +0100
+++ b/drivers/s390/block/dasd.c	2006-01-13 12:25:42.000000000 +0100
@@ -1635,7 +1635,7 @@
 	blk_queue_max_hw_segments(device->request_queue, -1L);
 	blk_queue_max_segment_size(device->request_queue, -1L);
 	blk_queue_segment_boundary(device->request_queue, -1L);
-	blk_queue_ordered(device->request_queue, QUEUE_ORDERED_DRAIN, NULL);
+	blk_queue_ordered(device->request_queue, QUEUE_ORDERED_TAG, NULL);
 }
 
 /*
