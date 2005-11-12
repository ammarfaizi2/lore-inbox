Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVKLVaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVKLVaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbVKLVaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:30:05 -0500
Received: from mail.isurf.ca ([66.154.97.68]:52901 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S964832AbVKLVaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:30:03 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: markus.lidel@shadowconnect.com
Subject: [PATCH] drivers/message/i2o/i2o_block.c unsigned comparison
Date: Sat, 12 Nov 2005 16:29:54 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121629.54699.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In i2o_block_ioctl, the parameter arg is declared an unsigned long, but then compared < 0, which is meaningless.
This redefines arg as a long, so that comparison is meaningful.

Thanks to LinuxICC (http://linuxicc.sf.net)

Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>

diff --git a/drivers/message/i2o/i2o_block.c b/drivers/message/i2o/i2o_block.c
index f283b5b..6bd8083 100644
--- a/drivers/message/i2o/i2o_block.c
+++ b/drivers/message/i2o/i2o_block.c
@@ -670,7 +670,7 @@ static int i2o_block_release(struct inod
  *	Return 0 on success or negative error on failure.
  */
 static int i2o_block_ioctl(struct inode *inode, struct file *file,
-			   unsigned int cmd, unsigned long arg)
+			   unsigned int cmd, long arg)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct i2o_block_device *dev = disk->private_data;


-- 
Gabriel A. Devenyi
ace@staticwave.ca
