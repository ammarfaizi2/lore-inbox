Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVCREC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVCREC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVCREAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:00:34 -0500
Received: from soundwarez.org ([217.160.171.123]:39823 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261228AbVCREAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:00:10 -0500
Date: Fri, 18 Mar 2005 05:00:07 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 3/6] kobject/hotplug split - block core
Message-ID: <20050318040007.GA594@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_add() and kobject_del() don't emit hotplug events anymore. Do it
ourselves if we are finished populating the device directory.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== fs/partitions/check.c 1.129 vs edited =====
--- 1.129/fs/partitions/check.c	2005-01-31 07:33:40 +01:00
+++ edited/fs/partitions/check.c	2005-03-18 02:17:18 +01:00
@@ -337,6 +337,7 @@ void register_disk(struct gendisk *disk)
 	if ((err = kobject_add(&disk->kobj)))
 		return;
 	disk_sysfs_symlinks(disk);
+	kobject_hotplug(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
 	if (disk->minors == 1) {
@@ -441,5 +442,6 @@ void del_gendisk(struct gendisk *disk)
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
 		put_device(disk->driverfs_dev);
 	}
+	kobject_hotplug(&disk->kobj, KOBJ_REMOVE);
 	kobject_del(&disk->kobj);
 }

