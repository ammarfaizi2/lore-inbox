Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSADRkz>; Fri, 4 Jan 2002 12:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbSADRkq>; Fri, 4 Jan 2002 12:40:46 -0500
Received: from rj.sgi.com ([204.94.215.100]:12257 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S288695AbSADRkd>;
	Fri, 4 Jan 2002 12:40:33 -0500
Subject: [PATCH] BLKGETSIZE64 broken in 2.4.18-pre1, 2.5.2-pre7
From: Eric Sandeen <sandeen@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Jan 2002 11:40:30 -0600
Message-Id: <1010166030.2576.0.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BLKGETSIZE64 is supposed to return device size in bytes:

#define BLKGETSIZE64 _IOR(0x12,114,sizeof(u64)) /* return device size in
bytes (u64 *arg) */

but in drivers/block/blkpg.c, it's just returning device size/512 as a
u64 number.

This patch should apply to both kernels.

--- linux/drivers/block/blkpg.c.orig	Fri Jan  4 11:30:37 2002
+++ linux/drivers/block/blkpg.c	Fri Jan  4 11:31:15 2002
@@ -247,7 +247,7 @@
 			if (cmd == BLKGETSIZE)
 				return put_user((unsigned long)ullval, (unsigned long *)arg);
 			else
-				return put_user(ullval, (u64 *)arg);
+				return put_user(ullval << 9, (u64 *)arg);
 #if 0
 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN)) 


-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.

