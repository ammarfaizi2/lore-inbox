Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287863AbSAFNDH>; Sun, 6 Jan 2002 08:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSAFNC6>; Sun, 6 Jan 2002 08:02:58 -0500
Received: from mail4.home.nl ([213.51.129.228]:5290 "EHLO mail4.home.nl")
	by vger.kernel.org with ESMTP id <S287863AbSAFNCl>;
	Sun, 6 Jan 2002 08:02:41 -0500
Message-ID: <3C384B33.4090801@home.nl>
Date: Sun, 06 Jan 2002 14:03:47 +0100
From: Gertjan van Wingerde <gwingerde@home.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, osst@riede.org
CC: linux-kernel@vger.kernel.org
Subject: OSST driver compile fixes.
Content-Type: multipart/mixed;
 boundary="------------040503070003040404000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040503070003040404000604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The attached patch contains the compile fixes regarding the kdev_t 
changes for the OSST driver.

-- 
	Best regards/MvG,

		Gertjan

----------

Gertjan van Wingerde
Geessinkweg 177
7544 TX Enschede
The Netherlands
E-mail: gwingerde@home.nl

--------------040503070003040404000604
Content-Type: text/plain;
 name="linux-osst.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-osst.diff"

diff -u --recursive linux-2.5.2-pre8/drivers/scsi/osst.c linux-2.5.x/drivers/scsi/osst.c
--- linux-2.5.2-pre8/drivers/scsi/osst.c	Tue Jan  1 18:28:53 2002
+++ linux-2.5.x/drivers/scsi/osst.c	Sat Jan  5 13:06:55 2002
@@ -125,8 +125,8 @@
 #define OSST_TIMEOUT (200 * HZ)
 #define OSST_LONG_TIMEOUT (1800 * HZ)
 
-#define TAPE_NR(x) (MINOR(x) & ~(128 | ST_MODE_MASK))
-#define TAPE_MODE(x) ((MINOR(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
+#define TAPE_NR(x) (minor(x) & ~(128 | ST_MODE_MASK))
+#define TAPE_MODE(x) ((minor(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
 
 /* Internal ioctl to set both density (uppermost 8 bits) and blocksize (lower
    24 bits) */
@@ -4021,7 +4021,7 @@
 		if (cmd_in == MTOFFL || cmd_in == MTUNLOAD)
 			STp->rew_at_close = 0;
 		else if (cmd_in == MTLOAD) {
-/*      		STp->rew_at_close = (MINOR(inode->i_rdev) & 0x80) == 0;  FIXME */
+/*      		STp->rew_at_close = (minor(inode->i_rdev) & 0x80) == 0;  FIXME */
 			for (i=0; i < ST_NBR_PARTITIONS; i++) {
 			    STp->ps[i].rw = ST_IDLE;
 			    STp->ps[i].last_block_valid = FALSE;/* FIXME - where else is this field maintained? */
@@ -4103,7 +4103,7 @@
 		return (-EBUSY);
 	}
 	STp->in_use       = 1;
-	STp->rew_at_close = (MINOR(inode->i_rdev) & 0x80) == 0;
+	STp->rew_at_close = (minor(inode->i_rdev) & 0x80) == 0;
 
 	if (STp->device->host->hostt->module)
 		 __MOD_INC_USE_COUNT(STp->device->host->hostt->module);
@@ -4124,7 +4124,7 @@
 	flags = filp->f_flags;
 	STp->write_prot = ((flags & O_ACCMODE) == O_RDONLY);
 
-	STp->raw = (MINOR(inode->i_rdev) & 0x40) != 0;
+	STp->raw = (minor(inode->i_rdev) & 0x40) != 0;
 
 	/* Allocate a buffer for this user */
 	need_dma_buffer = STp->restr_dma;
@@ -5407,7 +5407,7 @@
 #endif
 
 	tpnt->device = SDp;
-	tpnt->devt = MKDEV(MAJOR_NR, i);
+	tpnt->devt = mk_kdev(MAJOR_NR, i);
 	tpnt->dirty = 0;
 	tpnt->in_use = 0;
 	tpnt->drv_buffer = 1;  /* Try buffering if no mode sense */

--------------040503070003040404000604--

