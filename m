Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267462AbUBSSR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUBSSRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:17:55 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:15378 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267462AbUBSSRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:17:53 -0500
Message-ID: <4034FDCD.B4DEEC5C@SteelEye.com>
Date: Thu, 19 Feb 2004 13:17:49 -0500
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nbd: fix set_capacity call
Content-Type: multipart/mixed;
 boundary="------------6272CEDA8A221EE13A1C3AC6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6272CEDA8A221EE13A1C3AC6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch fixes the initial set_capacity call so that it matches nbd's
internal device size (nbd_device->bytesize).

Thanks,
Paul
--------------6272CEDA8A221EE13A1C3AC6
Content-Type: text/x-patch; charset=us-ascii;
 name="nbd_set_capacity_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd_set_capacity_fix.diff"

--- 2_6_3_rc2/drivers/block/nbd.c.PROC_PARTITIONS_FIXES	Thu Feb 19 11:49:15 2004
+++ 2_6_3_rc2/drivers/block/nbd.c	Thu Feb 19 12:00:55 2004
@@ -737,7 +737,7 @@ static int __init nbd_init(void)
 		INIT_LIST_HEAD(&nbd_dev[i].queue_head);
 		init_MUTEX(&nbd_dev[i].tx_lock);
 		nbd_dev[i].blksize = 1024;
-		nbd_dev[i].bytesize = ((u64)0x7ffffc00) << 10; /* 2TB */
+		nbd_dev[i].bytesize = 0x7ffffc00ULL << 10; /* 2TB */
 		disk->major = NBD_MAJOR;
 		disk->first_minor = i;
 		disk->fops = &nbd_fops;
@@ -745,7 +745,7 @@ static int __init nbd_init(void)
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		sprintf(disk->disk_name, "nbd%d", i);
 		sprintf(disk->devfs_name, "nbd/%d", i);
-		set_capacity(disk, 0x3ffffe);
+		set_capacity(disk, 0x7ffffc00ULL << 1); /* 2 TB */
 		add_disk(disk);
 	}
 

--------------6272CEDA8A221EE13A1C3AC6--

