Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281499AbRLAHEQ>; Sat, 1 Dec 2001 02:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283966AbRLAHEG>; Sat, 1 Dec 2001 02:04:06 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:20898 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S283965AbRLAHDs>; Sat, 1 Dec 2001 02:03:48 -0500
Subject: [PATCH] 2.5.1-pre5 Fix sector offset by 1 error.
To: torvalds@transmeta.com
Date: Sat, 1 Dec 2001 07:03:42 +0000 (GMT)
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16A4Ba-0003b3-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply below patch. It fixes my "hda2 is offset by 1 sector" problem
on my athlon.

Fix is trivial and is basically a compile fix for ldm which was causing
the problem in some weird way. With this applied the problem is gone.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
  

--- l251p5/fs/partitions/ldm.c	Mon Nov 12 17:43:11 2001
+++ linux-2.5.1-pre5/fs/partitions/ldm.c	Sat Dec  1 06:10:58 2001
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
+#include <linux/pagemap.h>
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
 #include <linux/slab.h>
