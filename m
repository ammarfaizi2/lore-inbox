Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272299AbTHIJVN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 05:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272300AbTHIJVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 05:21:13 -0400
Received: from [203.145.184.221] ([203.145.184.221]:4100 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S272299AbTHIJVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 05:21:12 -0400
Subject: [PATCH 2.6.0-test3] compile fix for driver/block/paride/pd.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: trivial@rustcorp.com.au
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 09 Aug 2003 15:09:54 +0530
Message-Id: <1060421994.1276.6.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the extra argument to blk_init_queue which prevents
the module from compiling.


--- linux-2.6.0-test3/drivers/block/paride/pd.c	2003-07-28 10:43:52.000000000 +0530
+++ linux-2.6.0-test3-nvk/drivers/block/paride/pd.c	2003-08-09 15:02:19.000000000 +0530
@@ -893,7 +893,7 @@
 	if (register_blkdev(major, name))
 		return -1;
 
-	blk_init_queue(&pd_queue, do_pd_request, &pd_lock);
+	blk_init_queue(do_pd_request, &pd_lock);
 	blk_queue_max_sectors(&pd_queue, cluster);
 
 	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",



