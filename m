Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUAVHQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 02:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbUAVHQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 02:16:28 -0500
Received: from dp.samba.org ([66.70.73.150]:19606 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264433AbUAVHQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 02:16:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix Careless bio->_bio change in rq_for_each_bio().
Date: Thu, 22 Jan 2004 17:40:33 +1100
Message-Id: <20040122071637.735A32C100@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like an obvious typo.  Works fine if "bio" is the name of the
iterator.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.2-rc1/include/linux/blkdev.h tmp/include/linux/blkdev.h
--- linux-2.6.2-rc1/include/linux/blkdev.h	2004-01-21 16:19:05.000000000 +1100
+++ tmp/include/linux/blkdev.h	2004-01-22 17:38:52.000000000 +1100
@@ -485,7 +485,7 @@ static inline void blk_queue_bounce(requ
 
 #define rq_for_each_bio(_bio, rq)	\
 	if ((rq->bio))			\
-		for (_bio = (rq)->bio; _bio; _bio = bio->bi_next)
+		for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)
 
 struct sec_size {
 	unsigned block_size;
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
