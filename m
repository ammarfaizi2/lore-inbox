Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUHFRkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUHFRkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUHFR3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:29:32 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:43280 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S268195AbUHFR1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:27:40 -0400
Date: Thu, 5 Aug 2004 16:14:39 -0500
From: root <root@beardog.americas.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates again [1/6] 32/64-bit conversion fixes
Message-ID: <20040805211439.GA6541@beardog.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope word wrapping is not a problem now.
Patch 1 of 6
This patch fixes our usage of copy_to_user. We were passing in the size
of the address rather than the size of the struct.
Patch applies to 2.6.8-rc3. Please apply in order.

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
