Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVDTRR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVDTRR4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVDTRRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:17:49 -0400
Received: from ns1.coraid.com ([65.14.39.133]:19368 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261743AbVDTRRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:17:10 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
References: <874qe1pejv.fsf@coraid.com>
Subject: [PATCH 2.6.12-rc2] aoe [5/6]: add firmware version to info in sysfs
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 20 Apr 2005 13:06:04 -0400
Message-ID: <87d5spnzsz.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add firmware version to info in sysfs

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- a/drivers/block/aoe/aoeblk.c	2005-04-20 11:41:18.000000000 -0400
+++ b/drivers/block/aoe/aoeblk.c	2005-04-20 11:42:23.000000000 -0400
@@ -37,6 +37,13 @@ static ssize_t aoedisk_show_netif(struct
 
 	return snprintf(page, PAGE_SIZE, "%s\n", d->ifp->name);
 }
+/* firmware version */
+static ssize_t aoedisk_show_fwver(struct gendisk * disk, char *page)
+{
+	struct aoedev *d = disk->private_data;
+
+	return snprintf(page, PAGE_SIZE, "0x%04x\n", (unsigned int) d->fw_ver);
+}
 
 static struct disk_attribute disk_attr_state = {
 	.attr = {.name = "state", .mode = S_IRUGO },
@@ -50,6 +57,10 @@ static struct disk_attribute disk_attr_n
 	.attr = {.name = "netif", .mode = S_IRUGO },
 	.show = aoedisk_show_netif
 };
+static struct disk_attribute disk_attr_fwver = {
+	.attr = {.name = "fwver", .mode = S_IRUGO },
+	.show = aoedisk_show_fwver
+};
 
 static void
 aoedisk_add_sysfs(struct aoedev *d)
@@ -57,6 +68,7 @@ aoedisk_add_sysfs(struct aoedev *d)
 	sysfs_create_file(&d->gd->kobj, &disk_attr_state.attr);
 	sysfs_create_file(&d->gd->kobj, &disk_attr_mac.attr);
 	sysfs_create_file(&d->gd->kobj, &disk_attr_netif.attr);
+	sysfs_create_file(&d->gd->kobj, &disk_attr_fwver.attr);
 }
 void
 aoedisk_rm_sysfs(struct aoedev *d)
@@ -64,6 +76,7 @@ aoedisk_rm_sysfs(struct aoedev *d)
 	sysfs_remove_link(&d->gd->kobj, "state");
 	sysfs_remove_link(&d->gd->kobj, "mac");
 	sysfs_remove_link(&d->gd->kobj, "netif");
+	sysfs_remove_link(&d->gd->kobj, "fwver");
 }
 
 static int


-- 
  Ed L. Cashin <ecashin@coraid.com>

