Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVAQWDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVAQWDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbVAQWDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:03:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:58036 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262915AbVAQVtX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:23 -0500
Cc: greg@kroah.com
Subject: [PATCH] Block: move struct disk_attribute to genhd.h
In-Reply-To: <11059983002081@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:45:00 -0800
Message-Id: <11059983001705@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2331, 2005/01/14 11:57:48-08:00, greg@kroah.com

[PATCH] Block: move struct disk_attribute to genhd.h

This allows other block devices to add attributes to their sysfs
entries.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/block/aoe/aoeblk.c |    9 +--------
 drivers/block/genhd.c      |    6 ------
 include/linux/genhd.h      |    6 ++++++
 3 files changed, 7 insertions(+), 14 deletions(-)


diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- a/drivers/block/aoe/aoeblk.c	2005-01-17 13:35:31 -08:00
+++ b/drivers/block/aoe/aoeblk.c	2005-01-17 13:35:31 -08:00
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
diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	2005-01-17 13:35:31 -08:00
+++ b/drivers/block/genhd.c	2005-01-17 13:35:31 -08:00
@@ -315,12 +315,6 @@
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
diff -Nru a/include/linux/genhd.h b/include/linux/genhd.h
--- a/include/linux/genhd.h	2005-01-17 13:35:31 -08:00
+++ b/include/linux/genhd.h	2005-01-17 13:35:31 -08:00
@@ -128,6 +128,12 @@
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

