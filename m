Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130281AbRABGP1>; Tue, 2 Jan 2001 01:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRABGPR>; Tue, 2 Jan 2001 01:15:17 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:7059 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S130281AbRABGPA>; Tue, 2 Jan 2001 01:15:00 -0500
Date: Tue, 2 Jan 2001 06:43:57 +0100
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Makefile fix for ieee1394
Message-ID: <20010102064357.A493@storm.local>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I've had the time to understand the new kernel makefile
structure the patch Kai Germaschewski posted is indeed the correct fix
(move include line up).  Furthermore it builds an .o object in the
static compiled case now.  I don't see any reason to choose the .a
format and most other drivers also do .o.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/


diff -ruN linux-2.4.orig/Makefile linux-2.4/Makefile
--- linux-2.4.orig/Makefile     Tue Jan  2 03:38:50 2001
+++ linux-2.4/Makefile  Tue Jan  2 05:12:36 2001
@@ -145,7 +145,7 @@
 DRIVERS-$(CONFIG_ATM) += drivers/atm/atm.o
 DRIVERS-$(CONFIG_IDE) += drivers/ide/idedriver.o
 DRIVERS-$(CONFIG_SCSI) += drivers/scsi/scsidrv.o
-DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394.a
+DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
 
 ifneq ($(CONFIG_CD_NO_IDESCSI)$(CONFIG_BLK_DEV_IDECD)$(CONFIG_BLK_DEV_SR)$(CONFIG_PARIDE_PCD),)
 DRIVERS-y += drivers/cdrom/driver.o
diff -ruN linux-2.4.orig/drivers/ieee1394/Makefile linux-2.4/drivers/ieee1394/Makefile
--- linux-2.4.orig/drivers/ieee1394/Makefile    Tue Jan  2 03:38:59 2001
+++ linux-2.4/drivers/ieee1394/Makefile Tue Jan  2 05:12:38 2001
@@ -8,7 +8,7 @@
 # Note 2! The CFLAGS definitions are now in the main makefile.
 #
 
-L_TARGET := ieee1394.a
+O_TARGET = ieee1394drv.o
 
 export-objs := ieee1394_syms.o
 
@@ -23,7 +23,7 @@
 obj-$(CONFIG_IEEE1394_VIDEO1394) += video1394.o
 obj-$(CONFIG_IEEE1394_RAWIO) += raw1394.o
 
+include $(TOPDIR)/Rules.make
+
 ieee1394.o: $(ieee1394-objs)
        $(LD) -r -o $@ $(ieee1394-objs)
-
-include $(TOPDIR)/Rules.make
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
