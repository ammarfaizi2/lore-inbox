Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281034AbRKCUgh>; Sat, 3 Nov 2001 15:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281035AbRKCUgZ>; Sat, 3 Nov 2001 15:36:25 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:54998 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281034AbRKCUgO>; Sat, 3 Nov 2001 15:36:14 -0500
Subject: [PATCH] NTFS sparc compile fix
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Date: Sat, 3 Nov 2001 20:36:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1607WV-0001xb-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,

Please apply below patchlet for your next releases (applies cleanly to
any recent kernel). It fixes compilation of NTFS driver on Sparc.

Thanks to Jan-Benedict Glaw for reporting and testing.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--- ntfs-sparc.diff ---

diff -u -urN linux-2.4.14-pre7-vanilla/fs/ntfs/dir.c linux-2.4.14-pre7-ntfs/fs/ntfs/dir.c
--- linux-2.4.14-pre7-vanilla/fs/ntfs/dir.c	Wed Sep 12 01:02:46 2001
+++ linux-2.4.14-pre7-ntfs/fs/ntfs/dir.c	Sat Nov  3 17:56:40 2001
@@ -19,6 +19,7 @@
 #include "support.h"
 #include "util.h"
 #include <linux/smp_lock.h>
+#include <linux/bitops.h>
 
 static char I30[] = "$I30";
 
diff -u -urN linux-2.4.14-pre7-vanilla/include/linux/ntfs_fs.h linux-2.4.14-pre7-ntfs/include/linux/ntfs_fs.h
--- linux-2.4.14-pre7-vanilla/include/linux/ntfs_fs.h	Sat Sep  8 20:24:40 2001
+++ linux-2.4.14-pre7-ntfs/include/linux/ntfs_fs.h	Sat Nov  3 16:43:03 2001
@@ -10,12 +10,12 @@
  * Attribute flags (16-bit).
  */
 typedef enum {
-	ATTR_IS_COMPRESSED      = cpu_to_le16(0x0001),
-	ATTR_COMPRESSION_MASK   = cpu_to_le16(0x00ff),  /* Compression method
-							 * mask. Also, first
-							 * illegal value. */
-	ATTR_IS_ENCRYPTED       = cpu_to_le16(0x4000),
-	ATTR_IS_SPARSE          = cpu_to_le16(0x8000),
+	ATTR_IS_COMPRESSED      = __constant_cpu_to_le16(0x0001),
+	ATTR_COMPRESSION_MASK   = __constant_cpu_to_le16(0x00ff),
+					/* Compression method mask. Also,
+					 * first illegal value. */
+	ATTR_IS_ENCRYPTED       = __constant_cpu_to_le16(0x4000),
+	ATTR_IS_SPARSE          = __constant_cpu_to_le16(0x8000),
 } __attribute__ ((__packed__)) ATTR_FLAGS;
 
 /*

