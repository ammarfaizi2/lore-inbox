Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVGKWDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVGKWDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVGKWBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:01:31 -0400
Received: from totor.bouissou.net ([82.67.27.165]:18915 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S262734AbVGKWBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:01:20 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [NOT solved] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Tue, 12 Jul 2005 00:01:16 +0200
User-Agent: KMail/1.7.2
Cc: "Alan Stern" <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C4A@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C4A@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507120001.16803@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 11 Juillet 2005 23:25, Protasevich, Natalie a écrit :
> When you get chance, maybe you could boot the OS that used to work for you
> (you mentioned 2.4) and provide the boot trace and /proc/interrupts for
> comparison.

Here it goes. Kernel is a somewhat custom ;-) 2.4.28:

# uname -r
2.4.28-0.rc1.1.1MiBevmsmdkc5

# cat /proc/interrupts
           CPU0
  0:      32095    IO-APIC-edge  timer
  1:        968    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  4:        890    IO-APIC-edge  serial
  7:          2    IO-APIC-edge  parport0
  8:          1    IO-APIC-edge  rtc
 14:         10    IO-APIC-edge  ide4
 15:         42    IO-APIC-edge  ide5
 18:       1714   IO-APIC-level  eth0, eth1
 19:      13108   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd
 21:        751   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
 22:          0   IO-APIC-level  VIA8233
NMI:          0
LOC:      32049
ERR:          0
MIS:         33


And what should be relevant to USB in the boot log...:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 11:23:26 Jan  2 2005
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xcc00, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
ehci_hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 00:10.3: irq 19, pci mem f8b32000
usb.c: new USB bus registered, assigned bus number 4
ehci_hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usbdevfs: remount parameter error
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
[...]
hub.c: connect-debounce failed, port 1 disabled
[...]
hub.c: new USB device 00:10.2-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x5d8/0x4002) is not claimed by any active 
driver.
hub.c: new USB device 00:10.0-1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb1:2.0
usb.c: registered new driver usbscanner
scanner.c: USB scanner device (0x05d8/0x4002) now attached to scanner0
scanner.c: 0.4.16:USB Scanner Driver
usb.c: registered new driver usbmouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver

Hope this may help...?

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
