Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbRB1TQJ>; Wed, 28 Feb 2001 14:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbRB1TP6>; Wed, 28 Feb 2001 14:15:58 -0500
Received: from ns2.cypress.com ([157.95.67.5]:44485 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S129197AbRB1TPm>;
	Wed, 28 Feb 2001 14:15:42 -0500
Message-ID: <3A9D4E46.C1660841@cypress.com>
Date: Wed, 28 Feb 2001 13:15:18 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-usb-devel@lists.sourceforge.net
Subject: USB oops Linux 2.4.2ac6
In-Reply-To: <E14XuMy-0004ZW-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.2-ac3 was fine.
These are the only USB changes I see since then.

> 2.4.2-ac6
> o       USB hub kmalloc wrong size corruption fix       (Peter Zaitcev)
> 
> 2.4.2-ac5
> o       Fix busy loop in usb storage                    (Arjan van de Ven)
> o       Fix USB thread wakeup scheduling                (Arjan van de Ven)

Tbird-700 on MSI-6167 (Viper based) board.
from dmesg
-------------
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xd3874000, IRQ 11
usb-ohci.c: usb-00:07.4, Advanced Micro Devices [AMD] AMD-756 [Viper]
USB
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c14aabc0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: d3874000
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: TT requires at most 8 FS bit times
hub.c: Port indicators are not supported
hub.c: power on to power good time: 0ms
hub.c: hub controller current requirement: 255mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c14aabc0
usb.c: kusbd: /sbin/hotplug add 1
--------------
If I boot with my mouse plugged in, or plug it in after the system
is up, I get an oops. 
While I was buildong the kernel I got a message from the kernel
--------
Feb 28 10:03:07 tedpc kernel: usb-ohci.c: bogus NDP=242 for OHCI
usb-00:07.4
Feb 28 10:03:07 tedpc kernel: usb-ohci.c: rereads as NDP=4
-----
Every thing continued OK, but I wasn't using the mouse.

I rebooted with the new kernel and got an oops when the init scripts
started looking for usb devices.

In 2.4.2-ac3 booting with the mouse shows this in the old log
-----------------
Feb 20 12:34:05 tedpc kernel: usb.c: registered new driver usbdevfs
Feb 20 12:34:05 tedpc kernel: usb.c: registered new driver hub
Feb 20 12:34:05 tedpc kernel: usb-ohci.c: USB OHCI at membase
0xd3874000, IRQ 11
Feb 20 12:34:05 tedpc kernel: usb-ohci.c: usb-00:07.4, Advanced Micro
Devices [AMD] AMD-756 [Viper] USB
Feb 20 12:34:05 tedpc kernel: usb.c: new USB bus registered, assigned
bus number 1
Feb 20 12:34:05 tedpc kernel: Product: USB OHCI Root Hub
Feb 20 12:34:05 tedpc kernel: SerialNumber: d3874000
Feb 20 12:34:05 tedpc kernel: hub.c: USB hub found
Feb 20 12:34:05 tedpc kernel: hub.c: 4 ports detected
Feb 20 12:34:05 tedpc kernel: hub.c: USB new device connect on bus1/2,
assigned device number 2
Feb 20 12:34:05 tedpc kernel: usb.c: USB device 2 (vend/prod 0x4b4/0x1)
is not claimed by any active driver.
Feb 20 12:34:05 tedpc kernel:   Length              = 18
Feb 20 12:34:05 tedpc kernel:   DescriptorType      = 01
Feb 20 12:34:05 tedpc kernel:   USB version         = 1.00
Feb 20 12:34:05 tedpc kernel:   Vendor:Product      = 04b4:0001
Feb 20 12:34:05 tedpc kernel:   MaxPacketSize0      = 8
Feb 20 12:34:05 tedpc kernel:   NumConfigurations   = 1
Feb 20 12:34:05 tedpc kernel:   Device version      = 0.00
Feb 20 12:34:05 tedpc kernel:   Device Class:SubClass:Protocol =
00:00:00
Feb 20 12:34:05 tedpc kernel:     Per-interface classes
Feb 20 12:34:05 tedpc kernel: Configuration:
Feb 20 12:34:05 tedpc kernel:   bLength             =    9
Feb 20 12:34:05 tedpc kernel:   bDescriptorType     =   02
Feb 20 12:34:05 tedpc kernel:   wTotalLength        = 0022
Feb 20 12:34:05 tedpc kernel:   bNumInterfaces      =   01
Feb 20 12:34:05 tedpc kernel:   bConfigurationValue =   01
Feb 20 12:34:05 tedpc kernel:   iConfiguration      =   00
Feb 20 12:34:06 tedpc kernel:   bmAttributes        =   80
Feb 20 12:34:06 tedpc kernel:   MaxPower            =  100mA
Feb 20 12:34:06 tedpc kernel: 
Feb 20 12:34:06 tedpc kernel:   Interface: 0
Feb 20 12:34:06 tedpc kernel:   Alternate Setting:  0
Feb 20 12:34:06 tedpc kernel:     bLength             =    9
Feb 20 12:34:06 tedpc kernel:     bDescriptorType     =   04
Feb 20 12:34:06 tedpc kernel:     bInterfaceNumber    =   00
Feb 20 12:34:06 tedpc kernel:     bAlternateSetting   =   00
Feb 20 12:34:06 tedpc kernel:     bNumEndpoints       =   01
Feb 20 12:34:06 tedpc kernel:     bInterface Class:SubClass:Protocol =  
03:01:02
Feb 20 12:34:06 tedpc kernel:     iInterface          =   00
Feb 20 12:34:06 tedpc kernel:     Endpoint:
Feb 20 12:34:06 tedpc kernel:       bLength             =    7
Feb 20 12:34:06 tedpc kernel:       bDescriptorType     =   05
Feb 20 12:34:06 tedpc kernel:       bEndpointAddress    =   81 (in)
Feb 20 12:34:06 tedpc kernel:       bmAttributes        =   03
(Interrupt)
Feb 20 12:34:06 tedpc kernel:       wMaxPacketSize      = 0003
Feb 20 12:34:06 tedpc kernel:       bInterval           =   0a
Feb 20 12:34:06 tedpc kernel: usb.c: registered new driver hid
Feb 20 12:34:06 tedpc kernel: input0: USB HID v1.00 Mouse [04b4:0001] on
usb1:2.0
Feb 20 12:34:06 tedpc kernel: mouse0: PS/2 mouse device for input0
Feb 20 12:34:06 tedpc kernel: mice: PS/2 mouse device common for all
mice
-----------------------

I don't have a serial console, so getting the oops takes a while.
I'll send it if needed.
I just loaded the mousedev and input modules. Plugging in
the mouse oopsed again.

The first line of the oops is
----
kernel BUG at slab.c:1398!
----

Any other ideas to try?

	-Thomas
