Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbTDPHSN (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 03:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264250AbTDPHSN 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 03:18:13 -0400
Received: from mail.mediaways.net ([193.189.224.113]:24319 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262837AbTDPHSK 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 03:18:10 -0400
Subject: Re: 2.4.21pre6 usb+devfs usbdevfs: USBDEVFS_CONTROL failed dev 2
	rqt 128 rq 6 len 9 ret -6
From: Soeren Sonnenburg <kernel@nn7.de>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030409162147.GA1518@kroah.com>
References: <1049881235.2773.71.camel@fortknox>
	 <20030409162147.GA1518@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050477976.2113.10.camel@fortknox>
Mime-Version: 1.0
Date: 16 Apr 2003 09:26:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 18:21, Greg KH wrote:
> On Wed, Apr 09, 2003 at 11:40:35AM +0200, Soeren Sonnenburg wrote:
> > Last strange message I could not make any sense of. Everything at least
> > pretends to work, but at bootup I get:
> 
> If you rename your usbutils binary to something else, do the messages go
> away?

sorry, I just now had time to check this :-(

Yes, they go away when I rename lsusb and usbmodules. Do I need newer
usbutils or ???

Hmhh, I also observe usb related IRQ routing conflict messages ... (see
below for /proc/interrupts and relevant dmesg output). Not sure whether
these could be the cause / there is something I can do about them.
Anyway 2.4.21pre7 is pretty stable for me (as long as I don't use bttv
in overlay mode).

           CPU0       
  0:      76527          XT-PIC  timer
  1:       2107          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  lirc_serial
  7:      28264          XT-PIC  ide4, ide5, eth0
  8:          4          XT-PIC  rtc
  9:      91535          XT-PIC  acpi, ehci-hcd, usb-uhci, usb-uhci, usb-uhci, eth1, VIA8233, em8300
 10:      28768          XT-PIC  ide2, ide3
 11:      37474          XT-PIC  EMU10K1, nvidia, bttv
 14:      16450          XT-PIC  ide0
 15:         87          XT-PIC  ide1

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 3 for device 00:10.3
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
ehci-hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci-hcd 00:10.3: irq 9, pci mem f8b33000
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:10.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:10.3 PCI cache line size corrected to 64.
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 23:07:54 Apr  9 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 3 for device 00:10.0
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
usb-uhci.c: USB UHCI at I/O 0x7000, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 3 for device 00:10.1
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
usb-uhci.c: USB UHCI at I/O 0x6800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 3 for device 00:10.2
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
usb-uhci.c: USB UHCI at I/O 0x6400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
mice: PS/2 mouse device common for all mice
hub.c: new USB device 00:10.1-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x57c/0x1000) is not claimed by any active driver.
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 9 for device 00:0c.0
PCI: Sharing IRQ 9 with 00:0b.0
eth1: RealTek RTL-8029 found at 0xb400, IRQ 9, 00:00:1C:01:2C:63.
hub.c: new USB device 00:10.1-2, assigned address 3
usb.c: USB device 3 (vend/prod 0x4f9/0xb) is not claimed by any active driver.
hub.c: new USB device 00:10.0-2, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:10.0-2.2, assigned address 3
usb.c: USB device 3 (vend/prod 0xa5c/0x2033) is not claimed by any active driver.
hub.c: new USB device 00:10.0-2.3, assigned address 4
usb.c: USB device 4 (vend/prod 0x4a9/0x220d) is not claimed by any active driver.
hub.c: new USB device 00:10.0-2.4, assigned address 5
usb.c: USB device 5 (vend/prod 0x5fe/0x5) is not claimed by any active driver.
bcm4400: eth0 NIC Link is Up, 100 Mbps full duplex
usb.c: registered new driver usbscanner
scanner.c: USB scanner device (0x04a9/0x220d) now attached to scanner0
scanner.c: 0.4.11:USB Scanner Driver
usb.c: registered new driver hid
input0: USB HID v1.00 Mouse [Cypress Sem. USB Mouse] on usb2:5.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
lirc_serial: auto-detected active high receiver
fcusb2: AVM FRITZ!Card USB v2 driver, revision 0.2
fcusb2: (fcusb2 built on Apr  9 2003 at 23:23:48)
fcusb2: Loading...
kcapi: driver fcusb2 attached
usb.c: registered new driver fcusb2
fcusb2: Driver 'fcusb2' attached to stack
kcapi: Controller 1: fritz-usb attached
fcusb2: Loaded.
usb.c: registered new driver usblp
printer.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04F9 pid 0x000B
printer.c: v0.11: USB Printer Device Class driver
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
fcusb2: Stack version 3.10-02
kcapi: card 1 "fritz-usb" ready.
kcapi: notify up contr 1
capidrv: controller 1 up
capidrv-1: now up (2 B channels)
capidrv-1: D2 trace enabled
capi: controller 1 up
usb.c: USB disconnect on device 00:10.0-2.2 address 3
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 00:0a.0
PCI: Sharing IRQ 11 with 01:00.0
hub.c: new USB device 00:10.0-2.2, assigned address 6
PCI: Found IRQ 4 for device 00:11.5
IRQ routing conflict for 00:11.5, have irq 9, want irq 4
PCI: Setting latency timer of device 00:11.5 to 64
devfs_register(audio): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss.c:223: can't register device seq


