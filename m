Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVEDHOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVEDHOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVEDHNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:13:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:62953 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262066AbVEDHLo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:11:44 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: add firmware version to info in sysfs
In-Reply-To: <11151906961976@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:11:37 -0700
Message-Id: <11151906972755@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe: add firmware version to info in sysfs

add firmware version to info in sysfs

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4613ed277ab8a41640434181898ef4649cc7301e
tree a1993e2276302a253f73e5139347e9ab374561bc
parent 93d489fc56f819d8805d80ae83cbafc5e5719804
author Ed L Cashin <ecashin@coraid.com> 1114784665 -0400
committer Greg KH <gregkh@suse.de> 1115188495 -0700

Index: drivers/block/aoe/aoeblk.c
===================================================================
--- 946adcae0abe20dc6d9d58682ea2d6980efd1a4c/drivers/block/aoe/aoeblk.c  (mode:100644 sha1:4780f7926d4292bc8150e2712ea18d8a11204ec2)
+++ a1993e2276302a253f73e5139347e9ab374561bc/drivers/block/aoe/aoeblk.c  (mode:100644 sha1:0e97fcb9f3a15b3bbe5b4a0bb8bd085c20e05b2b)
@@ -37,6 +37,13 @@
 
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
@@ -50,6 +57,10 @@
 	.attr = {.name = "netif", .mode = S_IRUGO },
 	.show = aoedisk_show_netif
 };
+static struct disk_attribute disk_attr_fwver = {
+	.attr = {.name = "firmware-version", .mode = S_IRUGO },
+	.show = aoedisk_show_fwver
+};
 
 static void
 aoedisk_add_sysfs(struct aoedev *d)
@@ -57,6 +68,7 @@
 	sysfs_create_file(&d->gd->kobj, &disk_attr_state.attr);
 	sysfs_create_file(&d->gd->kobj, &disk_attr_mac.attr);
 	sysfs_create_file(&d->gd->kobj, &disk_attr_netif.attr);
+	sysfs_create_file(&d->gd->kobj, &disk_attr_fwver.attr);
 }
 void
 aoedisk_rm_sysfs(struct aoedev *d)
@@ -64,6 +76,7 @@
 	sysfs_remove_link(&d->gd->kobj, "state");
 	sysfs_remove_link(&d->gd->kobj, "mac");
 	sysfs_remove_link(&d->gd->kobj, "netif");
+	sysfs_remove_link(&d->gd->kobj, "firmware-version");
 }
 
 static int

