Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbULIHSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbULIHSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 02:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbULIHSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 02:18:48 -0500
Received: from mail.telpin.com.ar ([200.43.18.243]:26543 "EHLO
	mail.telpin.com.ar") by vger.kernel.org with ESMTP id S261463AbULIHSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 02:18:45 -0500
Date: Thu, 9 Dec 2004 04:18:10 -0300
From: Alberto Bertogli <albertogli@telpin.com.ar>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Export disk->policy to sysfs
Message-ID: <20041209071621.GA8868@telpin.com.ar>
Mail-Followup-To: Alberto Bertogli <albertogli@telpin.com.ar>,
	axboe@suse.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi!

This small patch against 2.6.10-rc3 exports the disk->policy variable to
sysfs as /sys/block/DEVICE/read_only.

It can be useful for people or scripts wanting to check the state of a
device, specially now that USB storage has write protect detection.

Thanks,
		Alberto


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sysfs-block_read_only.patch"

--- linux-2.6.10-rc3/drivers/block/genhd.c.orig	2004-12-09 03:39:20.000000000 -0300
+++ linux-2.6.10-rc3/drivers/block/genhd.c	2004-12-09 03:48:44.000000000 -0300
@@ -384,6 +384,10 @@
 		jiffies_to_msecs(disk_stat_read(disk, io_ticks)),
 		jiffies_to_msecs(disk_stat_read(disk, time_in_queue)));
 }
+static ssize_t disk_read_only_read(struct gendisk * disk, char *page)
+{
+	return sprintf(page, "%d\n", disk->policy);
+}
 static struct disk_attribute disk_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
 	.show	= disk_dev_read
@@ -404,6 +408,10 @@
 	.attr = {.name = "stat", .mode = S_IRUGO },
 	.show	= disk_stats_read
 };
+static struct disk_attribute disk_attr_read_only = {
+	.attr = {.name = "read_only", .mode = S_IRUGO },
+	.show	= disk_read_only_read
+};
 
 static struct attribute * default_attrs[] = {
 	&disk_attr_dev.attr,
@@ -411,6 +419,7 @@
 	&disk_attr_removable.attr,
 	&disk_attr_size.attr,
 	&disk_attr_stat.attr,
+	&disk_attr_read_only.attr,
 	NULL,
 };
 

--TakKZr9L6Hm6aLOc--

