Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTDXBXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 21:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTDXBXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 21:23:25 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:16508 "EHLO
	dyn9-47-17-83.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S264371AbTDXBXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 21:23:24 -0400
Message-ID: <3EA73852.24923A52@us.ibm.com>
Date: Wed, 23 Apr 2003 18:05:22 -0700
From: Janet Morgan <janetmor@us.ibm.com>
Reply-To: janetmor@us.ibm.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@digeo.com, linux-aio@kvack.org
Subject: [PATCH] aio methods for block devices
Content-Type: multipart/mixed;
 boundary="------------898C87BE3C05C42CD152210C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------898C87BE3C05C42CD152210C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here's a small patch that adds aio_read and aio_write methods to the
block device driver.

Thanks,
-Janet

--------------898C87BE3C05C42CD152210C
Content-Type: text/plain; charset=us-ascii;
 name="blkaio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blkaio.patch"

--- linux-2.5.68/fs/block_dev.c	Sat Apr 19 19:51:22 2003
+++ aio/fs/block_dev.c	Wed Apr 23 13:21:26 2003
@@ -703,6 +703,15 @@ static ssize_t blkdev_file_write(struct 
 	return generic_file_write_nolock(file, &local_iov, 1, ppos);
 }
 
+static ssize_t blkdev_file_aio_write(struct kiocb *iocb, const char *buf,
+				   size_t count, loff_t pos)
+{
+	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
+
+	return generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
+}
+
+
 struct address_space_operations def_blk_aops = {
 	.readpage	= blkdev_readpage,
 	.writepage	= blkdev_writepage,
@@ -719,6 +728,8 @@ struct file_operations def_blk_fops = {
 	.llseek		= block_llseek,
 	.read		= generic_file_read,
 	.write		= blkdev_file_write,
+  	.aio_read	= generic_file_aio_read,
+  	.aio_write	= blkdev_file_aio_write, 
 	.mmap		= generic_file_mmap,
 	.fsync		= block_fsync,
 	.ioctl		= blkdev_ioctl,

--------------898C87BE3C05C42CD152210C--

