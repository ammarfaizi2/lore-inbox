Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUDHQvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUDHQvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:51:46 -0400
Received: from mailr-2.tiscali.it ([212.123.84.82]:13828 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S262064AbUDHQvZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:51:25 -0400
X-BrightmailFiltered: true
Date: Thu, 8 Apr 2004 18:51:23 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [PATCH] New ID for ftdi_sio
Message-ID: <20040408165123.GA11376@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have an USB contactless reader which uses a FTDI chip. It works well with the
current ftdi_sio driver, it's just a matter of adding an ID:

--- linux-2.6/drivers/usb/serial/ftdi_sio.h.orig	2004-04-08 18:24:22.000000000 +0200
+++ linux-2.6/drivers/usb/serial/ftdi_sio.h	2004-04-08 18:29:26.000000000 +0200
@@ -162,6 +162,9 @@
 #define PROTEGO_SPECIAL_3	0xFC72	/* special/unknown device */
 #define PROTEGO_SPECIAL_4	0xFC73	/* special/unknown device */ 
 
+/* Inside Accesso contactless reader (http://www.insidefr.com) */
+#define INSIDE_ACCESSO         0xFAD0
+
 /* Commands */
 #define FTDI_SIO_RESET 		0 /* Reset the port */
 #define FTDI_SIO_MODEM_CTRL 	1 /* Set the modem control register */
--- linux-2.6/drivers/usb/serial/ftdi_sio.c.orig	2004-04-08 18:23:41.000000000 +0200
+++ linux-2.6/drivers/usb/serial/ftdi_sio.c	2004-04-08 18:27:50.000000000 +0200
@@ -354,6 +354,7 @@
 	{ USB_DEVICE_VER(FTDI_VID, PROTEGO_SPECIAL_3, 0, 0x3ff) },
 	{ USB_DEVICE_VER(FTDI_VID, PROTEGO_SPECIAL_4, 0, 0x3ff) },
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_ELV_UO100_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(FTDI_VID, INSIDE_ACCESSO, 0, 0x3ff) },
 	{ }						/* Terminating entry */
 };
 
@@ -532,6 +533,7 @@
 	{ USB_DEVICE(FTDI_VID, PROTEGO_SPECIAL_3) },
 	{ USB_DEVICE(FTDI_VID, PROTEGO_SPECIAL_4) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ELV_UO100_PID) },
+	{ USB_DEVICE(FTDI_VID, INSIDE_ACCESSO) },
 	{ }						/* Terminating entry */
 };


This is the output of lsusb:

Bus 002 Device 002: ID 0403:fad0 Future Technology Devices International, Ltd 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0403 Future Technology Devices International, Ltd
  idProduct          0xfad0 
  bcdDevice            2.00
  iManufacturer           1 
  iProduct                2 
  iSerial                 3 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              2 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  bytes 64 once
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  bytes 64 once
        bInterval               0

Please apply.
Luca
-- 
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
