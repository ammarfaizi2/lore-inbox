Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUHDU6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUHDU6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267418AbUHDU6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:58:55 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:3596 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267417AbUHDU6x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:58:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: cciss update [1 of 6]
Date: Wed, 4 Aug 2004 15:58:51 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107436092@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: cciss update [1 of 6]
Thread-index: AcR6ZdhMKVKv5NvMQHqjGuVEi+LkKQ==
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <akpm@osdl.org>, <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 20:58:52.0408 (UTC) FILETIME=[D8FECF80:01C47A65]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 6
Name: p001_ioctl32_fix_for_268rc2.patch

This patch fixes a bug in our call to copy_to_user in our 32/64 conversions.
We were passing in the sizeof the address instead of the sizeof the struct.
Stupid bug.
This applies to 2.6.8-rc2. Please consider this for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc2.orig/drivers/block/cciss.c lx268-rc2/drivers/block/cciss.c
--- lx268-rc2.orig/drivers/block/cciss.c        2004-07-30 10:00:16.670069000 -0500
+++ lx268-rc2/drivers/block/cciss.c     2004-07-30 10:26:55.243049808 -0500
@@ -579,7 +579,7 @@ int cciss_ioctl32_passthru(unsigned int
        set_fs(old_fs);
        if (err)
                return err;
-       err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(&arg32->error_info));
+       err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(arg32->error_info));
        if (err)
                return -EFAULT;
        return err;
@@ -612,7 +612,7 @@ int cciss_ioctl32_big_passthru(unsigned
        set_fs(old_fs);
        if (err)
                return err;
-       err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(&arg32->error_info));
+       err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(arg32->error_info));
        if (err)
                return -EFAULT;
        return err;
