Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUKJXlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUKJXlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUKJXlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:41:45 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:42975 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262063AbUKJXll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:41:41 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@redhat.com, neilb@cse.unsw.edu.au,
       james4765@verizon.net
Message-Id: <20041110234139.21620.58620.39135@localhost.localdomain>
Subject: [PATCH][resend] md: Documentation/md.txt update
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [70.16.226.208] at Wed, 10 Nov 2004 17:41:39 -0600
Date: Wed, 10 Nov 2004 17:41:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to Documentation/md.txt - included some extra info I found out while
digging deeper into init/do_mounts_md.c

Signed-off-by: James Nelson <James4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/md.txt linux-2.6.9/Documentation/md.txt
--- linux-2.6.9-original/Documentation/md.txt	2004-10-18 17:54:38.000000000 -0400
+++ linux-2.6.9/Documentation/md.txt	2004-11-10 18:33:43.224334682 -0500
@@ -45,7 +45,8 @@
 When md is compiled into the kernel (not as module), partitions of
 type 0xfd are scanned and automatically assembled into RAID arrays.
 This autodetection may be suppressed with the kernel parameter
-"raid=noautodetect".
+"raid=noautodetect".  As of kernel 2.6.9, only drives with a type 0
+superblock can be autodetected and run at boot time.
 
 The kernel parameter "raid=partitionable" (or "raid=part") means
 that all auto-detected arrays are assembled as partitionable.
@@ -55,13 +56,13 @@
 ------------------
 
 The md driver can support a variety of different superblock formats.
-(It doesn't yet, but it can)
+Currently, it supports superblock formats "0.90.0" and the "md-1" format
+introduced in the 2.5 development series.
 
-The kernel does *NOT* autodetect which format superblock is being
-used. It must be told.
+The kernel will autodetect which format superblock is being used.
 
 Superblock format '0' is treated differently to others for legacy
-reasons.
+reasons - it is the original superblock format.
 
 
 General Rules - apply for all superblock formats
@@ -69,6 +70,7 @@
 
 An array is 'created' by writing appropriate superblocks to all
 devices.
+
 It is 'assembled' by associating each of these devices with an
 particular md virtual device.  Once it is completely assembled, it can
 be accessed.
@@ -76,10 +78,10 @@
 An array should be created by a user-space tool.  This will write
 superblocks to all devices.  It will usually mark the array as
 'unclean', or with some devices missing so that the kernel md driver
-can create approrpriate redundancy (copying in raid1, parity
+can create appropriate redundancy (copying in raid1, parity
 calculation in raid4/5).
 
-When an array is assembled, it is first initialised with the
+When an array is assembled, it is first initialized with the
 SET_ARRAY_INFO ioctl.  This contains, in particular, a major and minor
 version number.  The major version number selects which superblock
 format is to be used.  The minor number might be used to tune handling
@@ -101,15 +103,16 @@
 
 
 Specific Rules that apply to format-0 super block arrays, and
-       arrays with no superblock (non-persistant).
+       arrays with no superblock (non-persistent).
 -------------------------------------------------------------
 
 An array can be 'created' by describing the array (level, chunksize
 etc) in a SET_ARRAY_INFO ioctl.  This must has major_version==0 and
 raid_disks != 0.
-Then uninitialised devices can be added with ADD_NEW_DISK.  The
+
+Then uninitialized devices can be added with ADD_NEW_DISK.  The
 structure passed to ADD_NEW_DISK must specify the state of the device
 and it's role in the array.
 
-One started with RUN_ARRAY, uninitialised spares can be added with
+Once started with RUN_ARRAY, uninitialized spares can be added with
 HOT_ADD_DISK.
