Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVCPVPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVCPVPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVCPVPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:15:48 -0500
Received: from mail.dif.dk ([193.138.115.101]:11493 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262800AbVCPVP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:15:29 -0500
Date: Wed, 16 Mar 2005 22:16:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Eberhard Moenkeberg <emoenke@gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] small fixes for example programs in Documentation/cdrom/sbpcd
Message-ID: <Pine.LNX.4.62.0503162210250.2558@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Example programs in documentation files are great, but they are even 
better when they compile :)

The second one, the "cdtester" utility, is still not completely happy, but 
at least the patch fixes up most of the warnings and errors when trying to 
build it. The first app is perfectly happy here after this patch.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.11-mm4-orig/Documentation/cdrom/sbpcd linux-2.6.11-mm4/Documentation/cdrom/sbpcd
--- linux-2.6.11-mm4-orig/Documentation/cdrom/sbpcd	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11-mm4/Documentation/cdrom/sbpcd	2005-03-16 22:11:18.000000000 +0100
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
 


