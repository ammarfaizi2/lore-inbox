Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263224AbSJIAuu>; Tue, 8 Oct 2002 20:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263223AbSJIAt6>; Tue, 8 Oct 2002 20:49:58 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40876 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263224AbSJIAtm>;
	Tue, 8 Oct 2002 20:49:42 -0400
Date: Tue, 8 Oct 2002 17:57:44 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210081747180.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210081757340.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.600, 2002-10-08 17:32:17-07:00, mochel@osdl.org
  IDE: call device_unregister() instead of put_device() in ide-disk->cleanup().

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Tue Oct  8 17:55:17 2002
+++ b/drivers/ide/ide-disk.c	Tue Oct  8 17:55:17 2002
@@ -1692,7 +1692,7 @@
 {
 	struct gendisk *g = drive->disk;
 
-	put_device(&drive->disk->disk_dev);
+	device_unregister(&drive->disk->disk_dev);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",

