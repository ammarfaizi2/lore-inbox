Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317485AbSFIAYt>; Sat, 8 Jun 2002 20:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317486AbSFIAYs>; Sat, 8 Jun 2002 20:24:48 -0400
Received: from 54.61.26.24.cfl.rr.com ([24.26.61.54]:40965 "HELO
	potatoho.dyndns.org") by vger.kernel.org with SMTP
	id <S317485AbSFIAYs>; Sat, 8 Jun 2002 20:24:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Chris Faherty <rallymonkey@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Logitech Mouseman Dual Optical defaults to 400cpi
Date: Sat, 8 Jun 2002 20:25:24 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020608165243Z317422-22020+923@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020609002448Z317485-22020+1014@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 June 2002 12:53 pm, Chris Faherty wrote:

> I can't find any information on how to switch it into 800cpi mode.

Well, I managed to figure it out today.  Sending the special code to the 
MouseMan Dual Optical turns it into 800cpi mode.. much better!  Anyhow, I 
just put a test for this particular mouse in the hid_probe() and wrote the 
codes to the mouse.  Not sure if that's the best place.

This is for 2.2.20:

--- hid.c-orig  Sun Mar 25 11:37:37 2001
+++ hid.c       Sat Jun  8 17:55:02 2002
@@ -1523,6 +1523,19 @@

        printk(" on usb%d:%d.%d\n", dev->bus->busnum, dev->devnum, ifnum);

+#define USB_VENDOR_ID_LOGITECH          0x046d
+#define USB_DEVICE_ID_LOGITECH_DOPTICAL 0xc012
+    if ((hid->dev->descriptor.idVendor == USB_VENDOR_ID_LOGITECH) &&
+        (hid->dev->descriptor.idProduct == 
USB_DEVICE_ID_LOGITECH_DOPTICAL)) {
+        printk("Setting Logitech MouseMan Dual Optical for 800cpi\n");
+        usb_control_msg(hid->dev, usb_sndctrlpipe(hid->dev, 0),
+            0x0a, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT,
+            0x0000, 0x0000, NULL, 0, HZ);
+        usb_control_msg(hid->dev, usb_sndctrlpipe(hid->dev, 0),
+            0x02, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT,
+            0x000e, 0x0004, NULL, 0, HZ);
+    }
+
        return hid;
 }

-- 
/* Chris Faherty <rallymonkey@bellsouth.net> */
