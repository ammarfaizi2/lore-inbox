Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132491AbRDKADn>; Tue, 10 Apr 2001 20:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDKADe>; Tue, 10 Apr 2001 20:03:34 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:54266 "EHLO
	lynx.turbolabs.com") by vger.kernel.org with ESMTP
	id <S132491AbRDKADP>; Tue, 10 Apr 2001 20:03:15 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104110001.SAA08867@lynx.turbolabs.com>
Subject: [PATCH] comments about conflicting SCSI/CDROM ioctls
To: linux-kernel@vger.kernel.org (Linux kernel development list)
Date: Tue, 10 Apr 2001 18:01:25 -0600 (MDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a couple of comments to the cdrom and SCSI code warning of
duplicate ioctl numbers.

Cheers, Andreas
============================================================================
diff -ru linux.orig/include/linux/cdrom.h linux/include/linux/cdrom.h
--- linux.orig/include/linux/cdrom.h	Thu Jan  4 15:50:47 2001
+++ linux/include/linux/cdrom.h	Fri Feb 16 17:12:05 2001
@@ -128,8 +128,13 @@
 #define CDROM_DEBUG		0x5330	/* Turn debug messages on/off */
 #define CDROM_GET_CAPABILITY	0x5331	/* get capabilities */
 
+/* Note that scsi/scsi_ioctl.h also uses 0x5382 - 0x5386.
+ * Future CDROM ioctls should be kept below 0x537F
+ */
+
 /* This ioctl is only used by sbpcd at the moment */
 #define CDROMAUDIOBUFSIZ        0x5382	/* set the audio buffer size */
+					/* conflict with SCSI_IOCTL_GET_IDLUN */
 
 /* DVD-ROM Specific ioctls */
 #define DVD_READ_STRUCT		0x5390  /* Read structure */
diff -ru -x .[a-z]* ./include/scsi/scsi.h /usr/src/linux-2.4.0-0.3/include/scsi/scsi.h
--- ./include/scsi/scsi.h	Tue Sep  5 15:08:55 2000
+++ /usr/src/linux-2.4.0-0.3/include/scsi/scsi.h	Fri Feb 16 17:11:51 2001
@@ -196,8 +196,9 @@
  * Here are some scsi specific ioctl commands which are sometimes useful.
  */
 /* These are a few other constants  only used by scsi  devices */
+/* Note that include/linux/cdrom.h also defines IOCTL 0x5300 - 0x5395 */
 
-#define SCSI_IOCTL_GET_IDLUN 0x5382
+#define SCSI_IOCTL_GET_IDLUN 0x5382	/* conflicts with CDROMAUDIOBUFSIZ */
 
 /* Used to turn on and off tagged queuing for scsi devices */
 
-- 
Andreas Dilger                               TurboLabs filesystem development
