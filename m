Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272485AbRIFSps>; Thu, 6 Sep 2001 14:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272489AbRIFSpj>; Thu, 6 Sep 2001 14:45:39 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:34720 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S272485AbRIFSpc>; Thu, 6 Sep 2001 14:45:32 -0400
Subject: [PATCH2] 2.4.9-ac9 NTFS minor fix to previous patch
To: alan@lxorguk.ukuu.org.uk
Date: Thu, 6 Sep 2001 19:45:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15f49w-00043M-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

Below patch is incremental to previous large patch and fixes a small no
brainer on my part which caused the ntfs module to have an undefined
symbol if compiled without debug support... - Please apply. Thanks.

</me writes on my forehead>Test all compile options before sending a
patch.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


--- linux-2.4.9-ac9-ntfs-1.1.18b/fs/ntfs/support.h	Mon Jul 16 23:14:10 2001
+++ linux-2.4.9-ac9-ntfs-1.1.18/fs/ntfs/support.h	Thu Sep  6 19:21:40 2001
@@ -19,7 +19,11 @@
 #define DEBUG_NAME1  1024
 #define DEBUG_NAME2  2048
 
+#ifdef DEBUG
 void ntfs_debug(int mask, const char *fmt, ...);
+#else
+#define ntfs_debug(mask, fmt, ...)	do {} while (0)
+#endif
 
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
--- linux-2.4.9-ac9-ntfs-1.1.18b/fs/ntfs/support.c	Thu Sep  6 19:32:28 2001
+++ linux-2.4.9-ac9-ntfs-1.1.18/fs/ntfs/support.c	Thu Sep  6 19:20:55 2001
@@ -62,7 +62,6 @@
 }
 #endif
 #else /* End of DEBUG functions. Normal ones below... */
-#define ntfs_debug(mask, fmt, ...)	do {} while (0)
 
 #ifndef ntfs_malloc
 void *ntfs_malloc(int size)
