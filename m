Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbTDULne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbTDULne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:43:34 -0400
Received: from angband.namesys.com ([212.16.7.85]:17545 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S263815AbTDULnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:43:33 -0400
Date: Mon, 21 Apr 2003 15:55:30 +0400
From: Oleg Drokin <green@namesys.com>
To: hch@lst.de, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: "[PATCH] devfs: switch over ubd to ->devfs_name" breaks ubd/sysfs
Message-ID: <20030421155530.A7544@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   The "[PATCH] devfs: switch over ubd to ->devfs_name" patch that was included into 2.5.68,
   have broken UML's ubd/sysfs interaction.
   Sysfs is very upset when something tries to register several devices with 
   same name, so I was forced to use following patch.
   If this is wrong, then please explain to me why, and suggest the correct way of handling
   this situation.

   Thank you.
   
Bye,
    Oleg

===== arch/um/drivers/ubd_kern.c 1.32 vs edited =====
--- 1.32/arch/um/drivers/ubd_kern.c	Sun Apr 20 01:17:05 2003
+++ edited/arch/um/drivers/ubd_kern.c	Mon Apr 21 15:52:54 2003
@@ -494,7 +494,7 @@
 	disk->first_minor = unit << UBD_SHIFT;
 	disk->fops = &ubd_blops;
 	set_capacity(disk, size / 512);
-	sprintf(disk->disk_name, "ubd");
+	sprintf(disk->disk_name, "ubd%d", unit);
 	sprintf(disk->devfs_name, "ubd/disc%d", unit);
 
 	disk->private_data = &ubd_dev[unit];
@@ -527,7 +527,7 @@
 	if(err) 
 		return(err);
  
-	if(fake_major)
+	if(fake_major != MAJOR_NR)
 		ubd_new_disk(fake_major, dev->size, n, 
 			     &fake_gendisk[n]);
 
