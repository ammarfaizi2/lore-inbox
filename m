Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbRGOXrw>; Sun, 15 Jul 2001 19:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbRGOXrm>; Sun, 15 Jul 2001 19:47:42 -0400
Received: from flodhest.stud.ntnu.no ([129.241.56.24]:3011 "EHLO
	flodhest.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S267127AbRGOXr3>; Sun, 15 Jul 2001 19:47:29 -0400
Date: Mon, 16 Jul 2001 01:47:31 +0200
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make SCSI-system aware of type 12-devices
Message-ID: <20010716014731.A26451@flodhest.stud.ntnu.no>
Reply-To: tlan@stud.ntnu.no
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch doesn't display "Unkown" when a type 12 device is found,
when scanning for scsi-devices on a scsi-chain. I also included the 
declaration of TYPE_PRINTER which wasn't there. All theese types are
described in ftp://ftp.t10.org/t10/drafts/spc/spc-r11a.pdf page 51, 
table 21.

-- 
-Thomas

diff -urN -X dontdiff linux-2.4.7-pre6/drivers/scsi/scsi.c linux-2.4.7-pre6_patched/drivers/scsi/scsi.c
--- linux-2.4.7-pre6/drivers/scsi/scsi.c        Tue Jun 12 20:06:54 2001
+++ linux-2.4.7-pre6_patched/drivers/scsi/scsi.c        Mon Jul 16 00:37:59 2001
@@ -130,7 +130,7 @@
        "Communications   ",
        "Unknown          ",
        "Unknown          ",
-       "Unknown          ",
+       "Storage Array    ",
        "Enclosure        ",
 };
 
diff -urN -X dontdiff linux-2.4.7-pre6/include/scsi/scsi.h linux-2.4.7-pre6_patched/include/scsi/scsi.h
--- linux-2.4.7-pre6/include/scsi/scsi.h        Fri Apr 27 22:59:19 2001
+++ linux-2.4.7-pre6_patched/include/scsi/scsi.h        Mon Jul 16 00:34:45 2001
@@ -130,6 +130,7 @@
 
 #define TYPE_DISK           0x00
 #define TYPE_TAPE           0x01
+#define TYPE_PRINTER        0x02
 #define TYPE_PROCESSOR      0x03    /* HP scanners use this */
 #define TYPE_WORM           0x04    /* Treated as ROM by our system */
 #define TYPE_ROM            0x05
@@ -138,6 +139,7 @@
                                     * - treated as TYPE_DISK */
 #define TYPE_MEDIUM_CHANGER 0x08
 #define TYPE_COMM           0x09    /* Communications device */
+#define TYPE_SACD           0x0c    /* Storage Array Controller Device, e.g. RAID */
 #define TYPE_ENCLOSURE      0x0d    /* Enclosure Services Device */
 #define TYPE_NO_LUN         0x7f
