Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTLUW3A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 17:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTLUW3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 17:29:00 -0500
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:32391 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S264145AbTLUW2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 17:28:51 -0500
Date: Sun, 21 Dec 2003 17:03:23 -0500
From: Raul Miller <moth@magenta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: problem with usb duo mouse and keyboard
Message-ID: <20031221170323.D28449@links.magenta.com>
References: <20031221154331.Z28449@links.magenta.com> <20031221213950.GA14664@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031221213950.GA14664@ucw.cz>; from vojtech@suse.cz on Sun, Dec 21, 2003 at 10:39:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 10:39:50PM +0100, Vojtech Pavlik wrote:
> They do take that into account. It's just that the descriptors are maybe
> too complex. Could you possibly enable DEBUG in hid-core.c and send me
> the output?

I've defined DEBUG in hid-core.c, and booted with the logitech
keyboard/mouse transceiver plugged in using usb (I'm using a different
keyboard and mouse to run the system) but I don't see any new messages.
Do I also need to define DEBUG_DATA?  Or are there some special tests
I need to ruN?

As an aside, I have spotted a few messages which might be relevant 
which I was getting even before I booted with this kernel instance:

Dec 21 16:55:51 localhost input.agent[283]: ... no modules for INPUT product 3/46d/c50b/2100
Dec 21 16:55:51 localhost input.agent[294]: ... no modules for INPUT product 3/46d/c50b/2100
Dec 21 16:55:51 localhost modprobe: FATAL: Module hid already in kernel.
Dec 21 16:55:51 localhost usb.agent[276]: kernel driver usbkbd already loaded
Dec 21 16:55:51 localhost kernel: drivers/usb/core/usb.c: registered new driver
hiddev
Dec 21 16:55:51 localhost kernel: drivers/usb/core/usb.c: registered new driver
hid
Dec 21 16:55:51 localhost kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Dec 21 16:55:51 localhost usb.agent[284]: kernel driver usbmouse already loaded

Hmm...

Ok, I can get messages to show up in syslog if I use lsusb.  Here's what I get:

Dec 21 17:01:45 localhost kernel: usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 2 rqt 128 rq 6 len 63 ret -32
Dec 21 17:01:45 localhost kernel: usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 2 rqt 128 rq 6 len 190 ret -32
Dec 21 17:01:59 localhost kernel: usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 2 rqt 128 rq 6 len 63 ret -32
Dec 21 17:01:59 localhost kernel: usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 2 rqt 128 rq 6 len 190 ret -32
Dec 21 17:02:18 localhost kernel: usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 2 rqt 128 rq 6 len 63 ret -32
Dec 21 17:02:18 localhost kernel: usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 2 rqt 128 rq 6 len 190 ret -32

Also, I'm appending the output of lsusb -vv to the bottom of this message.

Let me know if there's anything else I can do.

Thanks,

-- 
Raul Miller
moth@magenta.com


Bus 003 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.0 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:10.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 002: ID 046d:c50b Logitech, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc50b 
  bcdDevice           21.00
  iManufacturer           1 Logitech
  iProduct                2 USB Receiver
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower               98mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      63
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     190
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              10
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.0 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:10.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.0 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:10.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)
