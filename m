Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbTHYOCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbTHYOCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:02:31 -0400
Received: from verein.lst.de ([212.34.189.10]:28061 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261933AbTHYOC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:02:28 -0400
Date: Mon, 25 Aug 2003 16:01:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@hera.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use list_add_tail in buffer_insert_list
Message-ID: <20030825140125.GA17194@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, marcelo@hera.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a really old patch from the XFS tree.

We need to call list_add_tail in buffer_insert_list to preserve buffer
ordering.  This essential for a good extent layout with XFS's delayed
allocation and a while ago the reiserfs group requested the same change.

ACKed by sct.


--- 1.77/fs/buffer.c	Sun Aug  3 16:49:59 2003
+++ edited/fs/buffer.c	Tue Aug  5 01:42:38 2003
@@ -619,7 +655,7 @@
 	if (buffer_attached(bh))
 		list_del(&bh->b_inode_buffers);
 	set_buffer_attached(bh);
-	list_add(&bh->b_inode_buffers, list);
+	list_add_tail(&bh->b_inode_buffers, list);
 	spin_unlock(&lru_list_lock);
 }
 
