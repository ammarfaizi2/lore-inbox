Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271470AbTGQOmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271471AbTGQOmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:42:12 -0400
Received: from mars.tm.informatik.uni-frankfurt.de ([141.2.14.4]:35508 "EHLO
	mars.tm.informatik.uni-frankfurt.de") by vger.kernel.org with ESMTP
	id S271470AbTGQOmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:42:01 -0400
Subject: USB problem case: Kernel vs. BIOS Initialization
From: Michael Lauer <mickey@tm.informatik.uni-frankfurt.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Organization: Institute of Telematics, CS. Dept., Frankfurt University
Message-Id: <1058453732.21425.6.camel@gandalf.tm.informatik.uni-frankfurt.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0-1mdk 
Date: 17 Jul 2003 16:55:32 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with my USB card reader panel. It is an USB 2.0
internal 6-in-1
hub with a card reader featuring a SMCS chipset. It is connected to a
Tyan Thunder i7505 motherboard (Dual Xeon). Right now I'm running kernel
2.4.21.

The problem: The card reader component of the panel is only rarely
usable.

The symptoms: The card reader component doesn't get an USB address
(Error -110).

The following is an excerpt of the boot log:

=================================================
Freeing unused kernel memory: 148k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 16:33:04 Jul  4 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1840, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1860, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0x1880, IRQ 18
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
PCI: Setting latency timer of device 00:1d.7 to 64
ehci-hcd 00:1d.7: Intel Corp. 82801DB USB EHCI Controller
ehci-hcd 00:1d.7: irq 23, pci mem f8931000
usb.c: new USB bus registered, assigned bus number 4
ehci-hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci-hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
usbdevfs: remount parameter error
Adding Swap: 2097136k swap-space (priority -1)
hub.c: connect-debounce failed, port 1 disabled
hub.c: new USB device 00:1d.7-3, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:1d.0-1, assigned address 2
usb-uhci.c: interrupt, status 2, frame# 904
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device 00:1d.0-1, assigned address 3
usb.c: USB device not accepting new address=3 (error=-110)
hub.c: new USB device 00:1d.1-2, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:1d.1-2.2, assigned address 3
usb.c: USB device 3 (vend/prod 0x45e/0x39) is not claimed by any active
driver.
usb.c: registered new driver hiddev
usb.c: registered new driver hid
usb-uhci.c: interrupt, status 3, frame# 1986
input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical]
on usb2:3.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usbmouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
=================================================

The Analysis:

The card reader has two LEDs, one "power" LED and one "active" LED.
On power up, both LEDs are on until the card reader gets initialized.
9 out of 10 times when I power on the system, the "active" LED turns off
during POST. 1 out of 10 times, it keeps lit until the Linux kernel
(right now 2.4.21)
boots and the ehci is loaded. In these rare case, the card reader
component gets initialized
by the linux kernel and it is working pretty good.

So - it seems that the BIOS tries to initialize the reader and it
somehow shuts
the reader component down.

One obvious workaround would be to plug in the AC cord manually while
the kernel is booting.
But frankly... I don't consider this an educated solution.

Rest assured that I've tried pretty everything in the BIOS - disabling
USB legacy support,
turning on/off plug'n'play OS support, etc. I also tried various kernel
command line parameters suggested in earlier posts on similar matters,
e.g. pci=biosirq but these didn't change the situation either.

So my question to the experts. Is my analysis somehow correct and - even
more - is there something
I can do on linux kernel side about the cases, when the reader already
got initialized by the BIOS.

It's a very frustrating situation, because the reader itself is very
nice (if it works...).
I'm out of ideas. Please help me on this, if you can.

Yours sincerely,

Michael 'Mickey' Lauer.
-- 
:M:
--------------------------------------------------------------------------
Dipl.-Inf. Michael 'Mickey' Lauer   mickey@tm.informatik.uni-frankfurt.de 
  Raum 10b - ++49 69 798 28358       Fachbereich Informatik und Biologie  
--------------------------------------------------------------------------

