Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUIZSFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUIZSFg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 14:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUIZSFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 14:05:36 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:40003 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261426AbUIZSFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 14:05:17 -0400
Message-ID: <416f0858040926110562b430fb@mail.gmail.com>
Date: Sun, 26 Sep 2004 21:05:16 +0300
From: =?UTF-8?B?0JrQuNGA0LjQuyDQmdC+0LLRh9C10LI=?= <jovchev@gmail.com>
Reply-To: =?UTF-8?B?0JrQuNGA0LjQuyDQmdC+0LLRh9C10LI=?= <jovchev@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Patch for Creative WebCam Go mini
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have Creative WebCam Go mini.
(http://www.qbik.ch/usb/devices/showdev.php?id=2868)
This camera has inside STV0680B chip and I have modified one of the
kernel drivers (drivers/usb/media/stv680)

So I have made this camera supported.

Here are the patches for files stv680.h and stv680.c

//----------------------------------------------------------

--- stv680.h.orig.2.6.8 2004-09-26 20:31:23.000000000 +0300
+++ stv680.h    2004-09-26 20:50:40.000000000 +0300
@@ -39,14 +39,20 @@
 /* number of decoding errors before kicking the camera */
 #define STV680_MAX_ERRORS      100

+
 #define USB_PENCAM_VENDOR_ID   0x0553
 #define USB_PENCAM_PRODUCT_ID  0x0202
+
+#define USB_CREATIVEGOMINI_VENDOR_ID   0x041e
+#define USB_CREATIVEGOMINI_PRODUCT_ID  0x4007
+
 #define PENCAM_TIMEOUT          1000
 /* fmt 4 */
 #define STV_VIDEO_PALETTE       VIDEO_PALETTE_RGB24

 static struct usb_device_id device_table[] = {
        {USB_DEVICE (USB_PENCAM_VENDOR_ID, USB_PENCAM_PRODUCT_ID)},
+       {USB_DEVICE (USB_CREATIVEGOMINI_VENDOR_ID,
USB_CREATIVEGOMINI_PRODUCT_ID)},
        {}
 };
 MODULE_DEVICE_TABLE (usb, device_table);

//----------------------------------------------------------

--- stv680.c.orig.2.6.8 2004-09-26 20:34:00.000000000 +0300
+++ stv680.c    2004-09-26 20:42:34.000000000 +0300
@@ -1,4 +1,7 @@
 /*
+ *  Creative WebCam Go Mini Driver, modified by Kiril Jovchev
+ *  (jovchev@gmail.com)
+ *
  *  STV0680 USB Camera Driver, by Kevin Sisson (kjsisson@bellsouth.net)
  *
  * Thanks to STMicroelectronics for information on the usb commands, and
@@ -56,6 +59,13 @@
  *                        to set to a non-supported size. This allowed
  *                        gnomemeeting to work.
  *                        Fixed proc entry removal bug.
+ *
+ * ver 0.26 Sep, 2004 (kjv)
+ *                         Added support for Creative WebCam Go mini.
+ *                         Camera is based on same chip.
+ *
+ *
+ *
  */

 #include <linux/config.h>
@@ -1395,9 +1405,12 @@
        if ((dev->descriptor.idVendor == USB_PENCAM_VENDOR_ID) &&
(dev->descriptor.idProduct == USB_PENCAM_PRODUCT_ID)) {
                camera_name = "STV0680";
                PDEBUG (0, "STV(i): STV0680 camera found.");
+       } else if ((dev->descriptor.idVendor ==
USB_CREATIVEGOMINI_VENDOR_ID) && (dev->descriptor.idProduct ==
USB_CREATIVEGOMINI_PRODUCT_ID)) {
+               camera_name = "Creative WebCam Go Mini";
+               PDEBUG (0, "STV(i): Creative WebCam Go Mini found.");
        } else {
-               PDEBUG (0, "STV(e): Vendor/Product ID do not match
STV0680 values.");
-               PDEBUG (0, "STV(e): Check that the STV0680 camera is
connected to the computer.");
+               PDEBUG (0, "STV(e): Vendor/Product ID do not match
STV0680 or Creative WebCam Go Mini values.");
+               PDEBUG (0, "STV(e): Check that the STV0680 or Creative
WebCam Go Mini camera is connected to the computer.");
                retval = -ENODEV;
                goto error;
        }


//----------------------------------------------------------

Best Regards
Kiril Jovchev
