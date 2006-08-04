Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbWHDOer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbWHDOer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWHDOer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:34:47 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:47570 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1161221AbWHDOeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:34:46 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Message-ID: <44D35AF1.2040200@cam.ac.uk>
Date: Fri, 04 Aug 2006 15:34:25 +0100
From: Jonathan Davies <jjd27@cam.ac.uk>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ftdi_sio driver - new PIDs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have come across some USB Serial FTDI-based devices which are not automatically detected by ftdi_sio, as of Linux 2.6.17, because their Product IDs are not recognised by the driver.

The devices are:

1. AlphaMicro Components AMC-232USB01 (serial to USB converter cable)
   - http://www.alphamicro.net/components/product~line~4~id~224.asp
   - vendor ID 0x0403
   - product ID 0xff00

2. Lawicel CANUSB (CAN bus to USB converter dongle)
   - http://www.canusb.com/
   - vendor ID 0x0403
   - product ID 0xffa8

Below is the patch for drivers/usb/serial/ftdi_sio.{c,h} against Linux 2.6.17 which includes these Product IDs.

Signed-off-by: Jonathan Davies <jjd27@cam.ac.uk>


diff -uprN -X dontdiff linux-vanilla/drivers/usb/serial/ftdi_sio.c linux-2.6.17/drivers/usb/serial/ftdi_sio.c
--- linux-vanilla/drivers/usb/serial/ftdi_sio.c 2006-08-04 15:12:02.000000000 +0100
+++ linux-2.6.17/drivers/usb/serial/ftdi_sio.c  2006-08-04 15:07:43.000000000 +0100
@@ -17,6 +17,9 @@
   * See http://ftdi-usb-sio.sourceforge.net for upto date testing info
   * and extra documentation
   *
+ * (04/Aug/2006) Jonathan Davies
+ *      Added PIDs for AMC232 and Lawicel CANUSB.
+ *
   * (21/Jul/2004) Ian Abbott
   *      Incorporated Steven Turner's code to add support for the FT2232C chip.
   *      The prelimilary port to the 2.6 kernel was by Rus V. Brushkoff.  I have
@@ -307,6 +310,8 @@ static struct ftdi_sio_quirk ftdi_HE_TIR


  static struct usb_device_id id_table_combined [] = {
+   { USB_DEVICE(FTDI_VID, FTDI_AMC232_PID) },
+   { USB_DEVICE(FTDI_VID, FTDI_CANUSB_PID) },
     { USB_DEVICE(FTDI_VID, FTDI_ACTZWAVE_PID) },
     { USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
     { USB_DEVICE(FTDI_VID, FTDI_IPLUS_PID) },
diff -uprN -X dontdiff linux-vanilla/drivers/usb/serial/ftdi_sio.h linux-2.6.17/drivers/usb/serial/ftdi_sio.h
--- linux-vanilla/drivers/usb/serial/ftdi_sio.h 2006-08-04 15:12:02.000000000 +0100
+++ linux-2.6.17/drivers/usb/serial/ftdi_sio.h  2006-08-04 15:08:39.000000000 +0100
@@ -31,6 +31,8 @@
  #define FTDI_NF_RIC_VID    0x0DCD  /* Vendor Id */
  #define FTDI_NF_RIC_PID    0x0001  /* Product Id */

+#define FTDI_CANUSB_PID 0xFFA8 /* Lawicel CANUSB Product Id */
+#define FTDI_AMC232_PID 0xFF00 /* AlphaMicro Components AMC-232USB01 Product Id */

  /* ACT Solutions HomePro ZWave interface (http://www.act-solutions.com/HomePro.htm) */
  #define FTDI_ACTZWAVE_PID  0xF2D0


