Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUHFRcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUHFRcz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268226AbUHFRbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:31:07 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:54029 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S268210AbUHFR1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:27:45 -0400
Date: Thu, 5 Aug 2004 16:18:50 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates again [2/6] zero out buffer for HP utils for 2.6.8-rc3
Message-ID: <20040805211850.GA6578@beardog.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 6

This patch addresses a problem with our utilities.
We zero out the buffer before copying their data into it.
This patch applies to 2.6.8-rc3. Please consider this for inclusion.
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
