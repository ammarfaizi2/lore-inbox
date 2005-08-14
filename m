Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVHNHMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVHNHMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 03:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVHNHMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 03:12:14 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:59561 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932229AbVHNHMO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 03:12:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: usb camera failing in 2.6.13-rc6
Date: Sun, 14 Aug 2005 17:12:06 +1000
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508141712.07196.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A digital camera which was working fine in 2.6.11/12 now fails on 2.6.13-rc6 
(not sure when it started failing).

All the messages seem to indicate that it's working but the digikam 
application now says it fails to initialise the camera.

The relevant info from dmesg says:
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: usbfs: interface 0 claimed by usbfs while 'digikamcameracl' sets 
config #1
usb 3-1: USB disconnect, address 2


the only difference from previously is this:
-usb 3-1: usbfs: interface 0 claimed while 'digikamcameracl' sets config #1
+usb 3-1: usbfs: interface 0 claimed by usbfs while 'digikamcameracl' sets 
config #1


dmesg difference does not show any significant difference either apart from 
this:
+usbmon: debugs is not available
-drivers/usb/input/hid-core.c: v2.0:USB HID core driver
+drivers/usb/input/hid-core.c: v2.01:USB HID core driver


lsusb -v shows no difference, here is the relevant section:
Bus 003 Device 003: ID 04a9:3077 Canon, Inc. PowerShot S50
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        32
  idVendor           0x04a9 Canon, Inc.
  idProduct          0x3077 PowerShot S50
  bcdDevice            0.01
  iManufacturer           1 Canon Inc.
  iProduct                2 Canon Digital Camera
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         6 Imaging
      bInterfaceSubClass      1 Still Image Capture
      bInterfaceProtocol      1 Picture Transfer Protocol (PIMA 15470)
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              96


relevant dmesg of 2.6.13-rc6 follows:
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
USB Universal Host Controller Interface driver v2.3
uhci_hcd 0000:00:1d.0: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI 
Controller
usb 1-1: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on 
usb-0000:00:1d.0-1
usb 1-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: new full speed USB device using uhci_hcd and address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 
proto 2 vid 0x03F0 pid 0x8104
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
usb 1-1: USB disconnect, address 2
usb 1-2: USB disconnect, address 3
usb 2-2: USB disconnect, address 2
hub 4-0:1.0: USB hub found
usb 1-1: new low speed USB device using uhci_hcd and address 4
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on 
usb-0000:00:1d.0-1
usb 1-2: new full speed USB device using uhci_hcd and address 5
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 5 if 0 alt 0 
proto 2 vid 0x03F0 pid 0x8104
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: USB disconnect, address 2


Relevant lspci output:
00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB 
UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB 
UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at d400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB 
UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at d000 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI 
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Flags: bus master, medium devsel, latency 0, IRQ 20
        Memory at d4800000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>


Cheers,
Con
