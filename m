Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277554AbRJKANk>; Wed, 10 Oct 2001 20:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277552AbRJKAN2>; Wed, 10 Oct 2001 20:13:28 -0400
Received: from r220-1.rz.RWTH-Aachen.DE ([134.130.3.31]:54485 "EHLO
	r220-1.rz.RWTH-Aachen.DE") by vger.kernel.org with ESMTP
	id <S277551AbRJKANW>; Wed, 10 Oct 2001 20:13:22 -0400
To: mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB Support for recent Casio Digital Still Cameras, linux-2.4.11 
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: Harald Schreiber <harald@harald-schreiber.de>
Date: 11 Oct 2001 02:11:56 +0200
Message-ID: <m3elobqblf.fsf@harald-schreiber.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recent Casio QV digital still cameras (for example the QV 4000)
show up as 
VendorID: 0x07cf  ProductID: 0x1001  Revision: 10.00

So the following patch is necessary to make these devices working
with the USB storage driver. The patch is against linux-2.4.11,
but it should work with any kernel since 2.4.8-pre3.



diff -Naur linux-2.4.11/drivers/usb/storage/unusual_devs.h linux/drivers/usb/storage/unusual_devs.h
--- linux-2.4.11/drivers/usb/storage/unusual_devs.h	Tue Sep 25 16:35:39 2001
+++ linux/drivers/usb/storage/unusual_devs.h	Thu Oct 11 00:28:22 2001
@@ -376,14 +376,15 @@
 		US_FL_MODE_XLATE | US_FL_START_STOP ),
 #endif
 
-/* Casio QV 2x00/3x00/8000 digital still cameras are not conformant
- * to the USB storage specification in two ways:
+/* Casio QV 3 / QV 2x00 / QV 3x00 / QV 4000 / QV 8000 digital still cameras
+ * are not conformant  to the USB storage specification in two ways:
  * - They tell us they are using transport protocol CBI. In reality they
  *   are using transport protocol CB.
  * - They don't like the INQUIRY command. So we must handle this command
  *   of the SCSI layer ourselves.
+ * Submitted by Harald Schreiber <harald@harald-schreiber.de>.
  */
-UNUSUAL_DEV( 0x07cf, 0x1001, 0x9009, 0x9009,
+UNUSUAL_DEV( 0x07cf, 0x1001, 0x1000, 0x9009,
                 "Casio",
                 "QV DigitalCamera",
                 US_SC_8070, US_PR_CB, NULL,


-- 
--------------------------------------------------------------------
Dipl.-Math. Harald Schreiber, Nizzaallee 26, D-52072 Aachen, Germany
Phone/Fax: +49-241-9108015/6       mailto:harald@harald-schreiber.de
--------------------------------------------------------------------
