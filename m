Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLAN2e>; Fri, 1 Dec 2000 08:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQLAN2Y>; Fri, 1 Dec 2000 08:28:24 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:57101 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129210AbQLAN2S>;
	Fri, 1 Dec 2000 08:28:18 -0500
Date: Fri, 1 Dec 2000 14:56:57 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] docbook fix in /drivers/block/ll_rw_blk.c
Message-ID: <Pine.LNX.4.10.10012011448190.12870-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

 there is a warning in make docs and there is no documentation generated
for blk_init_queue because of another function declaration between the
comments and the definition .

This patch moves the declaration before the comments.

please apply . 


--- /usr/src/clean/linux-2.4/drivers/block/ll_rw_blk.c	Thu Nov 30 18:13:46 2000
+++ ll_rw_blk.c	Fri Dec  1 14:23:50 2000
@@ -383,6 +383,8 @@
 	spin_lock_init(&q->request_lock);
 }
 
+static int __make_request(request_queue_t * q, int rw, struct buffer_head * bh);
+
 /**
  * blk_init_queue  - prepare a request queue for use with a block device
  * @q:    The &request_queue_t to be initialised
@@ -416,7 +418,6 @@
  *    blk_init_queue() must be paired with a blk_cleanup-queue() call
  *    when the block device is deactivated (such as at module unload).
  **/
-static int __make_request(request_queue_t * q, int rw,  struct buffer_head * bh);
 void blk_init_queue(request_queue_t * q, request_fn_proc * rfn)
 {
 	INIT_LIST_HEAD(&q->queue_head);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
