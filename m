Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272718AbTG1Hrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272728AbTG1Hrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:47:53 -0400
Received: from dm4-157.slc.aros.net ([66.219.220.157]:1413 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S272718AbTG1Hrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:47:51 -0400
Message-ID: <3F24D8B8.5030107@aros.net>
Date: Mon, 28 Jul 2003 02:03:04 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@digeo.com>
Subject: [RFC][PATCH 2.6.0-test2] get rid of unused request_queue field queue_wait
Content-Type: multipart/mixed;
 boundary="------------010205000107090500000704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010205000107090500000704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Are we going to use the queue_wait field of struct request_queue 
someday? As of 2.6.0-test2, I don't see any use of it. If it's not 
needed anymore, the following patch gets rid of it. Tested this patch by 
compiling for i386 and also doing a grep through all .h and .c files to 
see if it's used somewhere else (admittedly weak).

--------------010205000107090500000704
Content-Type: text/plain;
 name="patch-2.6.0-test2-no_queue_wait"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.0-test2-no_queue_wait"

diff -urN linux-2.6.0-test2/drivers/block/ll_rw_blk.c linux-2.6.0-test2-no_queue_wait/drivers/block/ll_rw_blk.c
--- linux-2.6.0-test2/drivers/block/ll_rw_blk.c	2003-07-27 19:02:48.000000000 -0600
+++ linux-2.6.0-test2-no_queue_wait/drivers/block/ll_rw_blk.c	2003-07-27 22:36:16.000000000 -0600
@@ -225,7 +225,6 @@
 	 */
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 
-	init_waitqueue_head(&q->queue_wait);
 	INIT_LIST_HEAD(&q->plug_list);
 }
 
diff -urN linux-2.6.0-test2/include/linux/blkdev.h linux-2.6.0-test2-no_queue_wait/include/linux/blkdev.h
--- linux-2.6.0-test2/include/linux/blkdev.h	2003-07-27 19:02:52.000000000 -0600
+++ linux-2.6.0-test2-no_queue_wait/include/linux/blkdev.h	2003-07-27 22:18:19.000000000 -0600
@@ -337,8 +337,6 @@
 	unsigned long		seg_boundary_mask;
 	unsigned int		dma_alignment;
 
-	wait_queue_head_t	queue_wait;
-
 	struct blk_queue_tag	*queue_tags;
 
 	/*

--------------010205000107090500000704--

