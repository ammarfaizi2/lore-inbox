Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVDIAIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVDIAIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 20:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVDIAIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 20:08:48 -0400
Received: from mail.dif.dk ([193.138.115.101]:13966 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261209AbVDIAH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 20:07:57 -0400
Date: Sat, 9 Apr 2005 02:10:27 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Eberhard Moenkeberg <emoenke@gwdg.de>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cosmetic fixes for example programs in Documentation/cdrom/sbpcd
Message-ID: <Pine.LNX.4.62.0504090205250.2455@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

I'm sending this to you directly since Eberhard Moenkeberg already 
indicated to me that he approves of the patch.

This patch makes a few minor changes to the example programs in 
Documentation/cdrom/sbpcd to kill off some warnings and build failures.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 sbpcd |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

--- linux-2.6.12-rc2-mm2-orig/Documentation/cdrom/sbpcd	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.12-rc2-mm2/Documentation/cdrom/sbpcd	2005-04-09 02:04:11.000000000 +0200
@@ -419,6 +419,7 @@
  */
 #include <stdio.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
 #include <linux/cdrom.h>
 
 static struct cdrom_tochdr hdr;
@@ -429,7 +430,7 @@
 static int i, j, limit, track, err;
 static char filename[32];
 
-main(int argc, char *argv[])
+int main(int argc, char *argv[])
 {
 /*
  * open /dev/cdrom
@@ -516,6 +517,7 @@
 	}
       arg.addr.lba++;
     }
+    return 0;
 }
 /*===================== end program ========================================*/
 
@@ -564,15 +566,16 @@
 #include <stdio.h>
 #include <malloc.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
 #include <linux/cdrom.h>
 
 #ifdef AZT_PRIVATE_IOCTLS
 #include <linux/../../drivers/cdrom/aztcd.h>
-#endif AZT_PRIVATE_IOCTLS
+#endif /* AZT_PRIVATE_IOCTLS */
 #ifdef SBP_PRIVATE_IOCTLS
 #include <linux/../../drivers/cdrom/sbpcd.h>
 #include <linux/fs.h>
-#endif SBP_PRIVATE_IOCTLS
+#endif /* SBP_PRIVATE_IOCTLS */
 
 struct cdrom_tochdr hdr;
 struct cdrom_tochdr tocHdr;
@@ -590,7 +593,7 @@
 	struct cdrom_msf msf;
 	unsigned char buf[CD_FRAMESIZE_RAW];
 } azt;
-#endif AZT_PRIVATE_IOCTLS
+#endif /* AZT_PRIVATE_IOCTLS */
 int i, i1, i2, i3, j, k;
 unsigned char sequence=0;
 unsigned char command[80];
@@ -738,7 +741,7 @@
 	} 
 } 
 
-main(int argc, char *argv[])
+int main(int argc, char *argv[])
 {
 	printf("\nTesting tool for a CDROM driver's audio functions V0.1\n");
 	printf("(C) 1995 Eberhard Moenkeberg <emoenke@gwdg.de>\n");
@@ -1046,12 +1049,13 @@
 			rc=ioctl(drive,CDROMAUDIOBUFSIZ,j);
 			printf("%d frames granted.\n",rc);
 			break;
-#endif SBP_PRIVATE_IOCTLS
+#endif /* SBP_PRIVATE_IOCTLS */
 		default:
 			printf("unknown command: \"%s\".\n",command);
 			break;
 		}
 	}
+	return 0;
 }
 /*==========================================================================*/
 


