Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267862AbUHETbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267862AbUHETbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267884AbUHET3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:29:33 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:30213 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267862AbUHET3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:29:04 -0400
Subject: cciss update [1/6] fixes to 32/64-bit conversions
From: mikem <mike.miller@hp.com>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1091734096.4826.2.camel@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 14:28:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 6
This patch fixes our usage of copy_to_user. We were passing in the size
of the address rather than the size of the struct.
Patch applies to 2.6.8-rc3. Please apply in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3.orig/drivers/block/cciss.c
lx268-rc3/drivers/block/cciss.c
--- lx268-rc3.orig/drivers/block/cciss.c	2004-08-05 09:55:58.023683000
-0500
+++ lx268-rc3/drivers/block/cciss.c	2004-08-05 10:22:43.290646176 -0500
@@ -578,7 +578,7 @@ int cciss_ioctl32_passthru(unsigned int 
 	err = sys_ioctl(fd, CCISS_PASSTHRU, (unsigned long) p);
 	if (err)
 		return err;
-	err |= copy_in_user(&arg32->error_info, &p->error_info,
sizeof(&arg32->error_info));
+	err |= copy_in_user(&arg32->error_info, &p->error_info,
sizeof(arg32->error_info));
 	if (err)
 		return -EFAULT;
 	return err;
@@ -610,7 +610,7 @@ int cciss_ioctl32_big_passthru(unsigned 
 	err = sys_ioctl(fd, CCISS_BIG_PASSTHRU, (unsigned long) p);
 	if (err)
 		return err;
-	err |= copy_in_user(&arg32->error_info, &p->error_info,
sizeof(&arg32->error_info));
+	err |= copy_in_user(&arg32->error_info, &p->error_info,
sizeof(arg32->error_info));
 	if (err)
 		return -EFAULT;
 	return err;


