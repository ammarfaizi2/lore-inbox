Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285569AbRLSXe2>; Wed, 19 Dec 2001 18:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285570AbRLSXeS>; Wed, 19 Dec 2001 18:34:18 -0500
Received: from zok.SGI.COM ([204.94.215.101]:8358 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285569AbRLSXeD>;
	Wed, 19 Dec 2001 18:34:03 -0500
Subject: [PATCH] BLKSIZEGET64 broken in blkpg.c: blk_ioctl()
From: Eric Sandeen <sandeen@sgi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Dec 2001 17:34:01 -0600
Message-Id: <1008804842.24833.28.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless I'm missing something here...

BLKSIZEGET64 is supposed to return device size in bytes, right?

[eric@stout linux]$ grep BLKGETSIZE64 include/linux/fs.h 
#define BLKGETSIZE64 _IOR(0x12,114,sizeof(u64))	/* return device size in bytes (u64 *arg) */

But now it's just returning number of sectors as a u64 number in
blk_ioctl()

So:

--- /usr/tmp/TmpDir.26482-0/linux/drivers/block/blkpg.c_1.13	Wed Dec 19 17:03:39 2001
+++ linux/drivers/block/blkpg.c	Wed Dec 19 17:02:21 2001
@@ -247,7 +247,7 @@
 			if (cmd == BLKGETSIZE)
 				return put_user((unsigned long)ullval, (unsigned long *)arg);
 			else
-				return put_user(ullval, (u64 *)arg);
+				return put_user(ullval << 9, (u64 *)arg);
 #if 0
 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN)) 


-Eric

-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.

