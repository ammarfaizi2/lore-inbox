Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRB1UIT>; Wed, 28 Feb 2001 15:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRB1UIJ>; Wed, 28 Feb 2001 15:08:09 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:53356 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129131AbRB1UH6>; Wed, 28 Feb 2001 15:07:58 -0500
Message-ID: <3A9D5A29.762D6E7C@sgi.com>
Date: Wed, 28 Feb 2001 12:06:01 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de, torvalds@transmeta.com
Subject: [PATCH] bug in scsi debug code
Content-Type: multipart/mixed;
 boundary="------------AFD7585A80D772750A25FDF0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AFD7585A80D772750A25FDF0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


A small fix in dump_stats() (scsi_merge.c) invoked when (struct req)
has inconsistent number of segments. The list formed
by b_reqnext is null terminated, so the current code is
simply wrong: it can cause a oops if (req->bh) is NULL,
or it fails to print the last element in the b_reqnext chain.



-- 
--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
--------------AFD7585A80D772750A25FDF0
Content-Type: text/plain; charset=us-ascii;
 name="scsi-merge-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi-merge-debug.patch"

--- ../../linux-2.4.2/linux/drivers/scsi/scsi_merge.c	Fri Feb  9 11:30:23 2001
+++ drivers/scsi/scsi_merge.c	Wed Feb 28 11:55:48 2001
@@ -90,7 +90,7 @@
 	printk("nr_segments is %x\n", req->nr_segments);
 	printk("counted segments is %x\n", segments);
 	printk("Flags %d %d\n", use_clustering, dma_host);
-	for (bh = req->bh; bh->b_reqnext != NULL; bh = bh->b_reqnext) 
+	for (bh = req->bh; bh != NULL; bh = bh->b_reqnext)
 	{
 		printk("Segment 0x%p, blocks %d, addr 0x%lx\n",
 		       bh,

--------------AFD7585A80D772750A25FDF0--

