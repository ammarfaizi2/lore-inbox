Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUHJQCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUHJQCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267490AbUHJQCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:02:40 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:41486 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267482AbUHJQCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:02:22 -0400
Date: Tue, 10 Aug 2004 11:01:40 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [1/8] ioctl32 fix
Message-ID: <20040810160140.GA19909@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My latest updates are not in 2.6.8-rc4. So I am resubmitting them.

Patch 1 of 8
This patch fixes our usage of copy_to_user. We were passing in the size
of the address rather than the size of the struct.
Patch applies to 2.6.8-rc4. Please apply in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3.orig/drivers/block/cciss.c lx268-rc3/drivers/block/cciss.c
--- lx268-rc3.orig/drivers/block/cciss.c	2004-08-05 09:55:58.023683000 -0500
+++ lx268-rc3/drivers/block/cciss.c	2004-08-05 10:22:43.290646176 -0500
@@ -578,7 +578,7 @@ int cciss_ioctl32_passthru(unsigned int 
 	err = sys_ioctl(fd, CCISS_PASSTHRU, (unsigned long) p);
 	if (err)
 		return err;
-	err |= copy_in_user(&arg32->error_info, &p->error_info, sizeof(&arg32->error_info));
+	err |= copy_in_user(&arg32->error_info, &p->error_info, sizeof(arg32->error_info));
 	if (err)
 		return -EFAULT;
 	return err;
@@ -610,7 +610,7 @@ int cciss_ioctl32_big_passthru(unsigned 
 	err = sys_ioctl(fd, CCISS_BIG_PASSTHRU, (unsigned long) p);
 	if (err)
 		return err;
-	err |= copy_in_user(&arg32->error_info, &p->error_info, sizeof(&arg32->error_info));
+	err |= copy_in_user(&arg32->error_info, &p->error_info, sizeof(arg32->error_info));
 	if (err)
 		return -EFAULT;
 	return err;
