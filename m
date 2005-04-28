Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVD1Fro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVD1Fro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVD1Frd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:47:33 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:64677 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262045AbVD1Fot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:44:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 4/5] sysfs: (driver/block) if show/store is missing return -ENOSYS
Date: Thu, 28 Apr 2005 00:43:25 -0500
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>
References: <200504280030.10214.dtor_core@ameritech.net>
In-Reply-To: <200504280030.10214.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504280043.25942.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs: fix drivers/block so if an attribute doesn't implement
       show or store method read/write will return -ENOSYS
       instead of 0 or -EINVAL.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 as-iosched.c       |    4 ++--
 cfq-iosched.c      |    4 ++--
 deadline-iosched.c |    4 ++--
 genhd.c            |    2 +-
 ll_rw_blk.c        |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

Index: dtor/drivers/block/as-iosched.c
===================================================================
--- dtor.orig/drivers/block/as-iosched.c
+++ dtor/drivers/block/as-iosched.c
@@ -2044,7 +2044,7 @@ as_attr_show(struct kobject *kobj, struc
 	struct as_fs_entry *entry = to_as(attr);
 
 	if (!entry->show)
-		return 0;
+		return -ENOSYS;
 
 	return entry->show(e->elevator_data, page);
 }
@@ -2057,7 +2057,7 @@ as_attr_store(struct kobject *kobj, stru
 	struct as_fs_entry *entry = to_as(attr);
 
 	if (!entry->store)
-		return -EINVAL;
+		return -ENOSYS;
 
 	return entry->store(e->elevator_data, page, length);
 }
Index: dtor/drivers/block/cfq-iosched.c
===================================================================
--- dtor.orig/drivers/block/cfq-iosched.c
+++ dtor/drivers/block/cfq-iosched.c
@@ -1772,7 +1772,7 @@ cfq_attr_show(struct kobject *kobj, stru
 	struct cfq_fs_entry *entry = to_cfq(attr);
 
 	if (!entry->show)
-		return 0;
+		return -ENOSYS;
 
 	return entry->show(e->elevator_data, page);
 }
@@ -1785,7 +1785,7 @@ cfq_attr_store(struct kobject *kobj, str
 	struct cfq_fs_entry *entry = to_cfq(attr);
 
 	if (!entry->store)
-		return -EINVAL;
+		return -ENOSYS;
 
 	return entry->store(e->elevator_data, page, length);
 }
Index: dtor/drivers/block/genhd.c
===================================================================
--- dtor.orig/drivers/block/genhd.c
+++ dtor/drivers/block/genhd.c
@@ -321,7 +321,7 @@ static ssize_t disk_attr_show(struct kob
 	struct gendisk *disk = to_disk(kobj);
 	struct disk_attribute *disk_attr =
 		container_of(attr,struct disk_attribute,attr);
-	ssize_t ret = 0;
+	ssize_t ret = -ENOSYS;
 
 	if (disk_attr->show)
 		ret = disk_attr->show(disk,page);
Index: dtor/drivers/block/ll_rw_blk.c
===================================================================
--- dtor.orig/drivers/block/ll_rw_blk.c
+++ dtor/drivers/block/ll_rw_blk.c
@@ -3582,7 +3582,7 @@ queue_attr_show(struct kobject *kobj, st
 
 	q = container_of(kobj, struct request_queue, kobj);
 	if (!entry->show)
-		return 0;
+		return -ENOSYS;
 
 	return entry->show(q, page);
 }
@@ -3596,7 +3596,7 @@ queue_attr_store(struct kobject *kobj, s
 
 	q = container_of(kobj, struct request_queue, kobj);
 	if (!entry->store)
-		return -EINVAL;
+		return -ENOSYS;
 
 	return entry->store(q, page, length);
 }
Index: dtor/drivers/block/deadline-iosched.c
===================================================================
--- dtor.orig/drivers/block/deadline-iosched.c
+++ dtor/drivers/block/deadline-iosched.c
@@ -886,7 +886,7 @@ deadline_attr_show(struct kobject *kobj,
 	struct deadline_fs_entry *entry = to_deadline(attr);
 
 	if (!entry->show)
-		return 0;
+		return -ENOSYS;
 
 	return entry->show(e->elevator_data, page);
 }
@@ -899,7 +899,7 @@ deadline_attr_store(struct kobject *kobj
 	struct deadline_fs_entry *entry = to_deadline(attr);
 
 	if (!entry->store)
-		return -EINVAL;
+		return -ENOSYS;
 
 	return entry->store(e->elevator_data, page, length);
 }
