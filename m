Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTDWAeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 20:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTDWAeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 20:34:11 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:21732 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263922AbTDWAeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 20:34:07 -0400
Date: Wed, 23 Apr 2003 01:45:08 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Hanno B?ck <hanno@gmx.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: Re: PATCH: some additional unusual_devs-entries for usb-storage-driver, kernel 2.5.68
Message-ID: <20030423004508.GA4158@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, Hanno B?ck <hanno@gmx.de>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	Linux-usb-users@lists.sourceforge.net
References: <20030421214805.7de5e4f3.hanno@gmx.de> <20030422213247.GA5076@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030422213247.GA5076@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 02:32:47PM -0700, Greg KH wrote:
 > On Mon, Apr 21, 2003 at 09:48:05PM +0200, Hanno B?ck wrote:
 > > This patch against 2.5.68 adds support for some digital cameras.
 > > Same patch is already applied to the 2.4-ac-series.
 > > It is taken from the lycoris kernel-source.
 > 
 > Ok, in talking with the usb-storage author, I'll be accepting all
 > unushal_devs.h patches now, as long as they contain the following:
 > 	- a comment above the entry with a email address of someone who
 > 	  has this device that this entry fixes the driver for them.
 > 	  This is to allow us to possibly remove entries at a later time
 > 	  if the core changes, and get a verification that it's ok to do
 > 	  so.
 > 	- a copy of the /proc/bus/usb/devices device entry with the
 > 	  device plugged in and the driver loaded (this should not be in
 > 	  the patch, but in the body of the email.)
 > 	  
 > So, if there are any outstanding drivers/usb/storage/unusual_devs.h
 > entries that people have floating around, sent them on!

I've been carrying these for _moons_. The only reason I've never punted
them on is that the US_FL_SL_IDE_BUG bit is odd (nothing seems to use
it, so at some point, I must have dropped the other half of the diff).

		Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/storage/unusual_devs.h linux-2.5/drivers/usb/storage/unusual_devs.h
--- bk-linus/drivers/usb/storage/unusual_devs.h	2003-04-22 00:40:43.000000000 +0100
+++ linux-2.5/drivers/usb/storage/unusual_devs.h	2003-04-22 01:23:15.000000000 +0100
@@ -137,6 +137,27 @@ UNUSUAL_DEV(  0x04da, 0x0901, 0x0100, 0x
 		"LS-120 Camera",
 		US_SC_UFI, US_PR_CBI, NULL, 0),
 
+/* Reported by Peter Wächtler <pwaechtler@loewe-komp.de> */
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0074, 0x0074,
+		"ScanLogic",
+		"SL11R-IDE 0049SQFP-1.2 A002",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY ),
+
+/* Reported by Leif Sawyer <leif@gci.net> */
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0240, 0x0240,
+		"H45 ScanLogic",
+		"SL11R-IDE 9951SQFP-1.2 K004",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY | US_FL_SL_IDE_BUG ),
+
+/* Reported by Rene Engelhard <mail@rene-engelhard.de> and
+    Dylan Egan <crack_me@bigpond.com.au> */
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0260, 0x0260,
+		"ScanLogic",
+		"SL11R-IDE unknown HW rev",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_SL_IDE_BUG ),
 /* From Yukihiro Nakai, via zaitcev@yahoo.com.
  * This is needed for CB instead of CBI */
 UNUSUAL_DEV(  0x04da, 0x0d05, 0x0000, 0x0000,
@@ -236,6 +257,18 @@ UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x
 		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
 
+UNUSUAL_DEV(  0x54c, 0x0010, 0x0106, 0x0328,
+		"Sony",
+		"DSC-P5",
+		US_SC_SCSI, US_PR_CB, NULL,
+		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
+
+UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0450,
+		"Sony",
+		"DSC-P72",
+		US_SC_SCSI, US_PR_CB, NULL,
+		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
+
 /* Reported by wim@geeks.nl */
 UNUSUAL_DEV(  0x054c, 0x0025, 0x0100, 0x0100, 
 		"Sony",
@@ -582,6 +615,19 @@ UNUSUAL_DEV(  0x0a16, 0x8888, 0x0100, 0x
 		US_SC_SCSI, US_PR_BULK, NULL,
 		US_FL_FIX_INQUIRY ),
 		
+/* This Pentax still camera is not conformant
+ * to the USB storage specification: -
+ * - It does not like the INQUIRY command. So we must handle this command
+ *   of the SCSI layer ourselves.
+ * Tested on Rev. 10.00 (0x1000)
+ * Submitted by James Courtier-Dutton <James@superbug.demon.co.uk>
+ */
+UNUSUAL_DEV( 0x0a17, 0x0004, 0x1000, 0x1000,
+		"ASAHI PENTAX",
+		"PENTAX OPTIO 430",
+		US_SC_8070, US_PR_CBI, NULL,
+		US_FL_FIX_INQUIRY ),
+
 #ifdef CONFIG_USB_STORAGE_ISD200
 UNUSUAL_DEV(  0x0bf6, 0xa001, 0x0100, 0x0110,
 		"ATI",

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/storage/usb.h linux-2.5/drivers/usb/storage/usb.h
--- bk-linus/drivers/usb/storage/usb.h	2003-04-10 06:01:25.000000000 +0100
+++ linux-2.5/drivers/usb/storage/usb.h	2003-02-04 20:12:28.000000000 +0000
@@ -76,6 +76,7 @@ struct us_unusual_dev {
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets	    */
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs fixing   */
 #define US_FL_FIX_CAPACITY    0x00000080 /* READ CAPACITY response too big  */
+#define US_FL_SL_IDE_BUG      0x00000100 /* ScanLogic usb-ide workaround */
 
 #define US_FLIDX_CAN_CANCEL  18  /* 0x00040000  okay to cancel current_urb? */
 #define US_FLIDX_CANCEL_SG   19  /* 0x00080000	okay to cancel current_sg?  */
