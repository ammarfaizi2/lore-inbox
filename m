Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVKCKJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVKCKJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 05:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVKCKJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 05:09:29 -0500
Received: from [218.25.172.144] ([218.25.172.144]:518 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932518AbVKCKJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 05:09:29 -0500
Date: Thu, 3 Nov 2005 18:08:44 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] __find_get_block_slow() cleanup
Message-ID: <20051103100520.GA4321@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Get rid of the `int unused' parameter of __find_get_block_slow().


		Coywolf

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---


--- 2.6.14-cy/fs/buffer.c~__find_get_block_slow-cleanup	2005-10-31 15:24:11.000000000 +0800
+++ 2.6.14-cy/fs/buffer.c	2005-11-03 17:58:54.000000000 +0800
@@ -396,7 +396,7 @@ asmlinkage long sys_fdatasync(unsigned i
  * private_lock is contended then so is mapping->tree_lock).
  */
 static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block, int unused)
+__find_get_block_slow(struct block_device *bdev, sector_t block)
 {
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
@@ -1438,7 +1438,7 @@ __find_get_block(struct block_device *bd
 	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
 
 	if (bh == NULL) {
-		bh = __find_get_block_slow(bdev, block, size);
+		bh = __find_get_block_slow(bdev, block);
 		if (bh)
 			bh_lru_install(bh);
 	}
@@ -1694,7 +1694,7 @@ void unmap_underlying_metadata(struct bl
 
 	might_sleep();
 
-	old_bh = __find_get_block_slow(bdev, block, 0);
+	old_bh = __find_get_block_slow(bdev, block);
 	if (old_bh) {
 		clear_buffer_dirty(old_bh);
 		wait_on_buffer(old_bh);
