Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWJJV6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWJJV6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbWJJVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:45:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31940 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030501AbWJJVpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:45:07 -0400
To: torvalds@osdl.org
Subject: [PATCH] fix misannotations in loop.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPPP-0007KI-5E@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:45:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/block/loop.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d6bb8da..19a09a1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -295,7 +295,7 @@ fail:
  * and do_lo_send_write().
  */
 static int __do_lo_send_write(struct file *file,
-		u8 __user *buf, const int len, loff_t pos)
+		u8 *buf, const int len, loff_t pos)
 {
 	ssize_t bw;
 	mm_segment_t old_fs = get_fs();
@@ -324,7 +324,7 @@ static int do_lo_send_direct_write(struc
 		struct bio_vec *bvec, int bsize, loff_t pos, struct page *page)
 {
 	ssize_t bw = __do_lo_send_write(lo->lo_backing_file,
-			(u8 __user *)kmap(bvec->bv_page) + bvec->bv_offset,
+			kmap(bvec->bv_page) + bvec->bv_offset,
 			bvec->bv_len, pos);
 	kunmap(bvec->bv_page);
 	cond_resched();
@@ -351,7 +351,7 @@ static int do_lo_send_write(struct loop_
 			bvec->bv_offset, bvec->bv_len, pos >> 9);
 	if (likely(!ret))
 		return __do_lo_send_write(lo->lo_backing_file,
-				(u8 __user *)page_address(page), bvec->bv_len,
+				page_address(page), bvec->bv_len,
 				pos);
 	printk(KERN_ERR "loop: Transfer error at byte offset %llu, "
 			"length %i.\n", (unsigned long long)pos, bvec->bv_len);
-- 
1.4.2.GIT


