Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272118AbRH2Wp3>; Wed, 29 Aug 2001 18:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272120AbRH2WpT>; Wed, 29 Aug 2001 18:45:19 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:13356 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272118AbRH2WpE>; Wed, 29 Aug 2001 18:45:04 -0400
Date: Wed, 29 Aug 2001 18:45:20 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] blkgetsize64 ioctl
Message-ID: <Pine.LNX.4.33.0108291840310.28439-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch below reserves an ioctl for getting the size in blocks of a
device as a long long instead of long as the old ioctl did.  The patch for
this to e2fsprogs sneaked in a bit too early.  There is a conflict with
the ia64 get/set sector ioctls, but I that's less common than e2fsprogs.

		-ben

diff -urN /md0/kernels/2.4/v2.4.10-pre2/include/linux/fs.h work-v2.4.10-pre2/include/linux/fs.h
--- /md0/kernels/2.4/v2.4.10-pre2/include/linux/fs.h	Wed Aug 29 18:28:50 2001
+++ work-v2.4.10-pre2/include/linux/fs.h	Wed Aug 29 18:39:48 2001
@@ -166,7 +166,7 @@
 #define BLKROSET   _IO(0x12,93)	/* set device read-only (0 = read-write) */
 #define BLKROGET   _IO(0x12,94)	/* get read-only status (0 = read_write) */
 #define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
-#define BLKGETSIZE _IO(0x12,96)	/* return device size */
+#define BLKGETSIZE _IO(0x12,96)	/* return device size (long *arg) */
 #define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
 #define BLKRASET   _IO(0x12,98)	/* Set read ahead for block device */
 #define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
@@ -182,6 +182,7 @@
 /* This was here just to show that the number is taken -
    probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
 #endif
+#define BLKGETSIZE64 _IO(0x12,109)	/* return device size (long long *arg) */


 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */

