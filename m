Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbVAKWGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVAKWGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVAKWCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:02:47 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:63457 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262899AbVAKWBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:01:40 -0500
Date: Tue, 11 Jan 2005 14:01:36 -0800
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [RFC] move struct disk_attribute to genhd.h
Message-ID: <20050111220136.GB18663@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any complaints about me sending this patch onward?  It's needed for
drivers to put sysfs attributes in their block device subdirectory, like
the aoe driver does.

It's against the latest -bk tree.

diffstat:
 drivers/block/aoe/aoeblk.c |    9 +--------
 drivers/block/genhd.c      |    6 ------
 include/linux/genhd.h      |    6 ++++++
 3 files changed, 7 insertions(+), 14 deletions(-)

thanks,

greg k-h

-----

Block: move struct disk_attribute to genhd.h

This allows other block devices to add attributes to their sysfs
entries.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


--- a/drivers/block/genhd.c	2005-01-07 11:18:22 -08:00
+++ b/drivers/block/genhd.c	2005-01-11 13:47:01 -08:00
@@ -322,12 +315,6 @@ subsys_initcall(device_init);
 /*
  * kobject & sysfs bindings for block devices
  */
-
-struct disk_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct gendisk *, char *);
-};
-
 static ssize_t disk_attr_show(struct kobject *kobj, struct attribute *attr,
 			      char *page)
 {
--- a/drivers/block/aoe/aoeblk.c	2005-01-11 09:04:06 -08:00
+++ b/drivers/block/aoe/aoeblk.c	2005-01-11 13:47:26 -08:00
@@ -12,14 +12,7 @@
 #include <linux/netdevice.h>
 #include "aoe.h"
 
-/* add attributes for our block devices in sysfs
- * (see drivers/block/genhd.c:disk_attr_show, etc.)
- */
-struct disk_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct gendisk *, char *);
-};
-
+/* add attributes for our block devices in sysfs */
 static ssize_t aoedisk_show_state(struct gendisk * disk, char *page)
 {
 	struct aoedev *d = disk->private_data;
--- a/include/linux/genhd.h	2005-01-05 05:13:44 -08:00
+++ b/include/linux/genhd.h	2005-01-11 13:46:27 -08:00
@@ -128,6 +128,12 @@ struct gendisk {
 #endif
 };
 
+/* Structure for sysfs attributes on block devices */
+struct disk_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct gendisk *, char *);
+};
+
 /* 
  * Macros to operate on percpu disk statistics:
  *
