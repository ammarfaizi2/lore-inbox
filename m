Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288743AbSADUHc>; Fri, 4 Jan 2002 15:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288735AbSADUHX>; Fri, 4 Jan 2002 15:07:23 -0500
Received: from [212.204.115.10] ([212.204.115.10]:5594 "EHLO hugo.fen-net.de")
	by vger.kernel.org with ESMTP id <S288744AbSADUHM>;
	Fri, 4 Jan 2002 15:07:12 -0500
Message-ID: <3C360B6C.F4D1661A@wieseckel.de>
Date: Fri, 04 Jan 2002 21:07:08 +0100
From: Stefan Wieseckel <s@wieseckel.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] missing SCSI device type (2.4.17)
Content-Type: multipart/mixed;
 boundary="------------B9CF19857E269519A974D36B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B9CF19857E269519A974D36B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

the attached patch adds one more SCSI device type to 2.4.17 (according
to the
SCSI standard).

Bye...
    Stef'
--------------B9CF19857E269519A974D36B
Content-Type: text/plain; charset=us-ascii;
 name="missing_scsi_device.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="missing_scsi_device.diff"

--- ./linux-2.4.17/include/scsi/scsi.h.orig	Sun Dec 23 15:27:07 2001
+++ ./linux-2.4.17/include/scsi/scsi.h	Sun Dec 23 15:31:16 2001
@@ -130,6 +130,7 @@
 
 #define TYPE_DISK           0x00
 #define TYPE_TAPE           0x01
+#define TYPE_PRINTER        0x02
 #define TYPE_PROCESSOR      0x03    /* HP scanners use this */
 #define TYPE_WORM           0x04    /* Treated as ROM by our system */
 #define TYPE_ROM            0x05
--- ./linux-2.4.17/drivers/scsi/scsi_dma.c.orig	Sun Dec 23 20:15:39 2001
+++ ./linux-2.4.17/drivers/scsi/scsi_dma.c	Sun Dec 23 20:16:52 2001
@@ -259,6 +259,7 @@
 				if (SDpnt->type == TYPE_WORM || SDpnt->type == TYPE_ROM)
 					new_dma_sectors += (2048 >> 9) * SDpnt->queue_depth;
 			} else if (SDpnt->type == TYPE_SCANNER ||
+				   SDpnt->type == TYPE_PRINTER ||
 				   SDpnt->type == TYPE_PROCESSOR ||
 				   SDpnt->type == TYPE_COMM ||
 				   SDpnt->type == TYPE_MEDIUM_CHANGER ||
--- ./linux-2.4.17/drivers/scsi/scsi_scan.c.orig	Fri Jan  4 20:54:25 2002
+++ ./linux-2.4.17/drivers/scsi/scsi_scan.c	Fri Jan  4 20:55:20 2002
@@ -634,6 +634,7 @@
 	switch (type = (scsi_result[0] & 0x1f)) {
 	case TYPE_TAPE:
 	case TYPE_DISK:
+	case TYPE_PRINTER:
 	case TYPE_MOD:
 	case TYPE_PROCESSOR:
 	case TYPE_SCANNER:

--------------B9CF19857E269519A974D36B--

