Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265458AbTFSNCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 09:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbTFSNCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 09:02:11 -0400
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:44752 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S265458AbTFSNCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 09:02:06 -0400
Subject: [PATCH] buffer_insert_list should use list_add_tail
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1056028538.6757.94.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Jun 2003 09:15:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

buffer_insert_list puts buffers onto the head of bh->b_inode_buffers,
which means that on fsync we are writing things out in reverse order.  I
think we either want this patch, or we want to walk the list in reverse
in fsync_buffers_list

(this has not been well tested, but I can't think of any problems it
would cause)

-chris

--- linux.marcelo/fs/buffer.c	Thu Jun 19 09:09:28 2003
+++ linux/fs/buffer.c	Thu Jun 19 09:04:17 2003
@@ -591,7 +604,7 @@
 	if (buffer_attached(bh))
 		list_del(&bh->b_inode_buffers);
 	set_buffer_attached(bh);
-	list_add(&bh->b_inode_buffers, list);
+	list_add_tail(&bh->b_inode_buffers, list);
 	spin_unlock(&lru_list_lock);
 }
 



