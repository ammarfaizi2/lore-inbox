Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265073AbUFAOD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbUFAOD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUFAOD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:03:56 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:3333 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265073AbUFAODD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:03:03 -0400
Message-ID: <40BC8C49.4020602@steeleye.com>
Date: Tue, 01 Jun 2004 10:01:45 -0400
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: fix device names
References: <4034FDD0.33BC57AF@SteelEye.com>
In-Reply-To: <4034FDD0.33BC57AF@SteelEye.com>
Content-Type: multipart/mixed;
 boundary="------------040201010704020000030600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040201010704020000030600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It seems more appropriate to call the devices "nbX" rather than "nbdX",
since that's what the device nodes are actually named.

--
Paul





--------------040201010704020000030600
Content-Type: text/plain;
 name="nbd_nb_devname.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd_nb_devname.diff"

--- linux/drivers/block/nbd.c.PRISTINE      Thu Apr 15 13:40:18 2004
+++ linux/drivers/block/nbd.c       Thu Apr 15 13:53:18 2004
@@ -713,7 +753,7 @@ static int __init nbd_init(void)
 		disk->fops = &nbd_fops;
 		disk->private_data = &nbd_dev[i];
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
-		sprintf(disk->disk_name, "nbd%d", i);
+		sprintf(disk->disk_name, "nb%d", i);
 		sprintf(disk->devfs_name, "nbd/%d", i);
 		set_capacity(disk, 0x7ffffc00ULL << 1); /* 2 TB */
 		add_disk(disk);


--------------040201010704020000030600--
