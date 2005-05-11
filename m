Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVEKVpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVEKVpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVEKVpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:45:16 -0400
Received: from kanga.kvack.org ([66.96.29.28]:12486 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261285AbVEKVpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:45:10 -0400
Date: Wed, 11 May 2005 17:47:49 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: reducing max segments expected to work?
Message-ID: <20050511214749.GA14072@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens et al,

Is reducing the max number of segments in the block layer supposed to 
work (as done in the patch below), or should i be sticking to mucking 
with MAX_PHYS_SEGMENTS?  I seem to get a kernel thatt cannot boot with 
the below patch applied, and was wondering if you're aware of any 
problems in this area.  I'll probably post something more detailed 
tomorrow after trying a few things.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler


diff -purN v2.6.12-rc4/include/linux/blkdev.h test-rc4/include/linux/blkdev.h
--- v2.6.12-rc4/include/linux/blkdev.h	2005-04-28 11:02:01.000000000 -0400
+++ test-rc4/include/linux/blkdev.h	2005-05-11 17:06:10.000000000 -0400
@@ -667,8 +667,8 @@ extern long blk_congestion_wait(int rw, 
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
 extern int blkdev_issue_flush(struct block_device *, sector_t *);
 
-#define MAX_PHYS_SEGMENTS 128
-#define MAX_HW_SEGMENTS 128
+#define MAX_PHYS_SEGMENTS 32
+#define MAX_HW_SEGMENTS 32
 #define MAX_SECTORS 255
 
 #define MAX_SEGMENT_SIZE	65536
