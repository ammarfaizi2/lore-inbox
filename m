Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266523AbUG0TaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUG0TaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266516AbUG0TaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:30:11 -0400
Received: from ozlabs.org ([203.10.76.45]:18917 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266502AbUG0T3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:29:07 -0400
Date: Tue, 27 Jul 2004 12:29:49 -0700
From: Martin Pool <mbp@sourcefrog.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] trivial doc patch for partitions
Message-ID: <20040727192949.GC9564@happy.site>
Mail-Followup-To: Martin Pool <mbp@sourcefrog.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG: 1024D/A0B3E88B: AFAC578F 1841EE6B FD95E143 3C63CA3F A0B3E88B
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's slightly hard to see how these variables are used; this patch
adds a short description.

I am planning to change rescan_partitions so that it allows you to
change partitions on a disk that has active partitions, so long as the
active partitions themselves are not changed.  Would anyone object?


Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h	2004-06-18 15:16:35.000000000 -0700
+++ linux-2.6/include/linux/fs.h	2004-07-27 11:50:01.483618248 -0700
@@ -354,6 +354,7 @@
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
 	struct hd_struct *	bd_part;
+	/* number of times partitions within this device have been opened. */
 	unsigned		bd_part_count;
 	int			bd_invalidated;
 	struct gendisk *	bd_disk;
Index: linux-2.6/include/linux/genhd.h
===================================================================
--- linux-2.6.orig/include/linux/genhd.h	2004-03-14 19:24:17.000000000 -0800
+++ linux-2.6/include/linux/genhd.h	2004-07-25 09:58:22.000000000 -0700
@@ -82,7 +82,8 @@
 struct gendisk {
 	int major;			/* major number of driver */
 	int first_minor;
-	int minors;
+	int minors;                     /* maximum number of minors, =1 for
+                                         * disks that can't be partitioned. */
 	char disk_name[32];		/* name of major driver */
 	struct hd_struct **part;	/* [indexed by minor] */
 	struct block_device_operations *fops;


-- 
Martin
