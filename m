Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUIGOdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUIGOdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUIGObq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:31:46 -0400
Received: from verein.lst.de ([213.95.11.210]:17817 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268111AbUIGObf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:31:35 -0400
Date: Tue, 7 Sep 2004 16:31:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't export blkdev_open and def_blk_ops
Message-ID: <20040907143130.GA8358@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Already since 2.4 all block devices use block_device_operations and
shouldn't deal with file operations directly.


--- 1.163/fs/block_dev.c	2004-06-29 16:44:49 +02:00
+++ edited/fs/block_dev.c	2004-09-07 13:26:09 +02:00
@@ -666,7 +666,7 @@
 
 EXPORT_SYMBOL(blkdev_get);
 
-int blkdev_open(struct inode * inode, struct file * filp)
+static int blkdev_open(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev;
 	int res;
@@ -695,8 +695,6 @@
 	return res;
 }
 
-EXPORT_SYMBOL(blkdev_open);
-
 int blkdev_put(struct block_device *bdev)
 {
 	int ret = 0;
@@ -797,8 +795,6 @@
 	.writev		= generic_file_write_nolock,
 	.sendfile	= generic_file_sendfile,
 };
-
-EXPORT_SYMBOL(def_blk_fops);
 
 int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
 {
--- 1.343/include/linux/fs.h	2004-08-27 08:30:32 +02:00
+++ edited/include/linux/fs.h	2004-09-07 13:40:30 +02:00
@@ -1251,7 +1251,6 @@
 extern void bd_set_size(struct block_device *, loff_t size);
 extern void bd_forget(struct inode *inode);
 extern void bdput(struct block_device *);
-extern int blkdev_open(struct inode *, struct file *);
 extern struct block_device *open_by_devnum(dev_t, unsigned);
 extern struct file_operations def_blk_fops;
 extern struct address_space_operations def_blk_aops;
