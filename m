Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbUJ0F4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbUJ0F4B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbUJ0F4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:56:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32665 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261668AbUJ0FzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:55:23 -0400
Date: Wed, 27 Oct 2004 07:54:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] cfq v2 switch bug
Message-ID: <20041027055456.GC15910@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fix online switching issue with cfq v2. It does deferred clearing of
e->elevator_data, which screws up the current io scheduler. It does not
have to, so just remove it.

Signed-off-by: Jens Axboe <axboe@suse.de>

--- /opt/kernel/linux-2.6.9-mm1/drivers/block/cfq-iosched.c	2004-10-25 17:17:19.000000000 +0200
+++ linux-2.6.9-mm1/drivers/block/cfq-iosched.c	2004-10-26 15:07:51.146772400 +0200
@@ -1482,7 +1482,6 @@
 static void cfq_put_cfqd(struct cfq_data *cfqd)
 {
 	request_queue_t *q = cfqd->queue;
-	elevator_t *e = q->elevator;
 	struct cfq_queue *cfqq;
 
 	if (!atomic_dec_and_test(&cfqd->ref))
@@ -1500,7 +1499,6 @@
 
 	blk_put_queue(q);
 
-	e->elevator_data = NULL;
 	mempool_destroy(cfqd->crq_pool);
 	kfree(cfqd->crq_hash);
 	kfree(cfqd->cfq_hash);

-- 
Jens Axboe

