Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTFJPVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTFJPVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:21:05 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57432 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263025AbTFJPTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:19:53 -0400
Date: Tue, 10 Jun 2003 16:35:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop 7/9 remove blk_queue_bounce
In-Reply-To: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101634580.2285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What purpose does loop_make_request's blk_queue_bounce serve?  None,
it's just a relic from before the kmaps were added to loop's transfers,
and ties up mempooled resources - in the file-backed case, with no
guarantee they'll soon be freed.  And what purpose does loop_set_fd's
blk_queue_bounce_limit serve?  None, blk_queue_make_request did that.

--- loop6/drivers/block/loop.c	Tue Jun 10 12:56:34 2003
+++ loop7/drivers/block/loop.c	Tue Jun 10 12:59:47 2003
@@ -548,8 +548,6 @@
 		goto err;
 	}
 
-	blk_queue_bounce(q, &old_bio);
-
 	/*
 	 * file backed, queue for loop_thread to handle
 	 */
@@ -742,7 +740,6 @@
 	 * device
 	 */
 	blk_queue_make_request(&lo->lo_queue, loop_make_request);
-	blk_queue_bounce_limit(&lo->lo_queue, BLK_BOUNCE_HIGH);
 	lo->lo_queue.queuedata = lo;
 
 	/*

