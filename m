Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVBMDPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVBMDPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 22:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVBMDPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 22:15:52 -0500
Received: from users.ccur.com ([208.248.32.211]:2428 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261236AbVBMDPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 22:15:42 -0500
Date: Sat, 12 Feb 2005 22:15:32 -0500
From: Joe Korty <joe.korty@ccur.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: memset argument order misuses
Message-ID: <20050213031532.GA8656@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
A simple 'grep memset.*\<0);' shows argument order errors in several uses
of memset.

This grep was inspired by Al Viro's recent patch, megaraid_mbox fix,
which fixed this problem in the megaraid driver.

Completely untested.

Regards,
Joe
--
"Money can buy bandwidth, but latency is forever" -- John Mashey



diff -Nura base/drivers/s390/block/dasd_genhd.c new/drivers/s390/block/dasd_genhd.c
--- base/drivers/s390/block/dasd_genhd.c	2004-12-24 16:35:24.000000000 -0500
+++ new/drivers/s390/block/dasd_genhd.c	2005-02-12 21:55:48.546192009 -0500
@@ -149,8 +149,8 @@
 	 * Can't call delete_partitions directly. Use ioctl.
 	 * The ioctl also does locking and invalidation.
 	 */
-	memset(&bpart, sizeof(struct blkpg_partition), 0);
-	memset(&barg, sizeof(struct blkpg_ioctl_arg), 0);
+	memset(&bpart, 0, sizeof(struct blkpg_partition));
+	memset(&barg, 0, sizeof(struct blkpg_ioctl_arg));
 	barg.data = &bpart;
 	barg.op = BLKPG_DEL_PARTITION;
 	for (bpart.pno = device->gdp->minors - 1; bpart.pno > 0; bpart.pno--)
diff -Nura base/drivers/s390/cio/cmf.c new/drivers/s390/cio/cmf.c
--- base/drivers/s390/cio/cmf.c	2004-12-24 16:33:48.000000000 -0500
+++ new/drivers/s390/cio/cmf.c	2005-02-12 21:56:08.430256458 -0500
@@ -526,7 +526,7 @@
 	time = get_clock() - cdev->private->cmb_start_time;
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
 
-	memset(data, sizeof(struct cmbdata), 0);
+	memset(data, 0, sizeof(struct cmbdata));
 
 	/* we only know values before device_busy_time */
 	data->size = offsetof(struct cmbdata, device_busy_time);
@@ -736,7 +736,7 @@
 	time = get_clock() - cdev->private->cmb_start_time;
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
 
-	memset (data, sizeof(struct cmbdata), 0);
+	memset (data, 0, sizeof(struct cmbdata));
 
 	/* we only know values before device_busy_time */
 	data->size = offsetof(struct cmbdata, device_busy_time);
diff -Nura base/drivers/s390/cio/css.c new/drivers/s390/cio/css.c
--- base/drivers/s390/cio/css.c	2005-02-12 21:51:28.000000000 -0500
+++ new/drivers/s390/cio/css.c	2005-02-12 21:56:20.066538550 -0500
@@ -527,7 +527,7 @@
 	new_slow_sch = kmalloc(sizeof(struct slow_subchannel), GFP_ATOMIC);
 	if (!new_slow_sch)
 		return -ENOMEM;
-	memset(new_slow_sch, sizeof(struct slow_subchannel), 0);
+	memset(new_slow_sch, 0, sizeof(struct slow_subchannel));
 	new_slow_sch->schid = schid;
 	spin_lock_irqsave(&slow_subchannel_lock, flags);
 	list_add_tail(&new_slow_sch->slow_list, &slow_subchannels_head);
