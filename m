Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267499AbUHJQFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267499AbUHJQFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267503AbUHJQFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:05:07 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:59143 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267499AbUHJQEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:04:16 -0400
Date: Tue, 10 Aug 2004 11:03:36 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [2/8] zero out buffer for HP utilities
Message-ID: <20040810160336.GB19909@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch 2 of 8

This patch addresses a problem with our utilities.
We zero out the buffer before copying their data into it.
This patch applies to 2.6.8-rc4. Please consider this for inclusion.
Please apply patches in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3-p001/drivers/block/cciss.c lx268-rc3/drivers/block/cciss.c
--- lx268-rc3-p001/drivers/block/cciss.c	2004-08-05 10:22:43.290646000 -0500
+++ lx268-rc3/drivers/block/cciss.c	2004-08-05 10:28:36.993875112 -0500
@@ -866,6 +866,8 @@ static int cciss_ioctl(struct inode *ino
 				kfree(buff);
 				return -EFAULT;
 			}
+		} else {
+			memset(buff, 0, iocommand.buf_size);
 		}
 		if ((c = cmd_alloc(host , 0)) == NULL)
 		{
@@ -1012,6 +1014,8 @@ static int cciss_ioctl(struct inode *ino
 				copy_from_user(buff[sg_used], data_ptr, sz)) {
 					status = -ENOMEM;
 					goto cleanup1;			
+			} else {
+				memset(buff[sg_used], 0, sz);
 			}
 			left -= sz;
 			data_ptr += sz;
