Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSHTJGH>; Tue, 20 Aug 2002 05:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSHTJGH>; Tue, 20 Aug 2002 05:06:07 -0400
Received: from dp.samba.org ([66.70.73.150]:30365 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316667AbSHTJGG>;
	Tue, 20 Aug 2002 05:06:06 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: marcelo@conectiva.com.br
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] silence invalidate_bdev() a bit
Date: Tue, 20 Aug 2002 18:27:52 +1000
Message-Id: <20020820041035.711C72C49F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Experts, does this make sense?  The Debian kernel tree makes it a
  KERN_DEBUG printk instead. ]

From:  Christoph Hellwig <hch@lst.de>

  The 2.4.1x invalidate_bdev() is a little to verbose and warns about
  conditions that can easily happen in practice.  Silence up those
  printks a little like most vendor trees already do.
  

--- trivial-2.4.20-pre4/fs/buffer.c.orig	2002-08-20 18:00:33.000000000 +1000
+++ trivial-2.4.20-pre4/fs/buffer.c	2002-08-20 18:00:33.000000000 +1000
@@ -695,13 +695,13 @@
 			/* All buffers in the lru lists are mapped */
 			if (!buffer_mapped(bh))
 				BUG();
-			if (buffer_dirty(bh))
+			if (buffer_dirty(bh) && destroy_dirty_buffers)
 				printk("invalidate: dirty buffer\n");
 			if (!atomic_read(&bh->b_count)) {
 				if (destroy_dirty_buffers || !buffer_dirty(bh)) {
 					remove_inode_queue(bh);
 				}
-			} else
+			} else if (!bdev->bd_openers)
 				printk("invalidate: busy buffer\n");
 
 			write_unlock(&hash_table_lock);
-- 
  Don't blame me: the Monkey is driving
  File: Christoph Hellwig <hch@lst.de>: [PATCH] silence invalidate_bdev() a bit
