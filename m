Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267603AbUHMWE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267603AbUHMWE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUHMWE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:04:26 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:57094 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S267603AbUHMWEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:04:20 -0400
Date: Fri, 13 Aug 2004 17:03:40 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [2/5] fix for 32/64-bit conversions
Message-ID: <20040813220340.GB1016@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 5.
This patch fixes our usage of copy_to_user in our 32/64-bit
conversions. We were passing in the size of the address
rather than the size of the struct.
Applies to 2.4.27. Please consider this for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burNp lx2427-p001/drivers/block/cciss.c lx2427/drivers/block/cciss.c
--- lx2427-p001/drivers/block/cciss.c	2004-08-13 15:38:30.808314000 -0500
+++ lx2427/drivers/block/cciss.c	2004-08-13 15:45:07.640986640 -0500
@@ -592,7 +592,7 @@ int cciss_ioctl32_passthru(unsigned int 
 	set_fs(old_fs);
 	if (err)
 		return err;
-	err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(&arg32->error_info));
+	err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(arg32->error_info));
 	if (err) 
 		return -EFAULT; 
 	return err;
@@ -620,7 +620,7 @@ int cciss_ioctl32_big_passthru(unsigned 
 	set_fs(old_fs);
 	if (err)
 		return err;
-	err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(&arg32->error_info));
+	err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(arg32->error_info));
 	if (err) 
 		return -EFAULT; 
 	return err;
