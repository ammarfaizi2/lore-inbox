Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUFDU7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUFDU7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266002AbUFDU7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:59:34 -0400
Received: from saturn.opentools.org ([66.250.40.202]:30080 "EHLO
	saturn.opentools.org") by vger.kernel.org with ESMTP
	id S266003AbUFDU6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:58:51 -0400
Date: Fri, 4 Jun 2004 17:03:58 -0400 (EDT)
From: Aaron Mulder <ammulder@alumni.princeton.edu>
X-X-Sender: ammulder@saturn.opentools.org
To: linux-kernel@vger.kernel.org
Subject: Re: Dell TrueMobile 1150 PCMCIA/Orinoco/Yenta problem w/ 2.6.4/5
In-Reply-To: <20040604084001.A22925@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0406041635170.3462@saturn.opentools.org>
References: <Pine.LNX.4.58.0406022305580.6314@saturn.opentools.org>
 <20040604084001.A22925@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004, Russell King wrote:
> It'd be useful to see a diff between the dmesg of the two cases, just
> in case there's something the above description missed.

	The diff is below.

> Also have a look in sysfs in /sys/class/pcmcia_socket in both cases.

	There are 3 socket directories there in both cases.  In other 
words, even when /var/lib/pcmcia/stab shows only 2, there are 3 in 
/sys/class/pcmcia_socket.

	Also, while working on this today, it seems that the problem is
intermittent -- on some boots it notices the 3rd socket a little while
later (still during the boot sequence) even when the modules are loaded in
the wrong order, and on some boots it doesn't.  It's about 50/50 this
afternoon.  My recollection from the other night is that I got 5 or 10
straight boots with the problem.  I don't know what the difference is
(though I am on a different network today, as if that should matter).

Thanks,
	Aaron

--- working	2004-06-04 16:23:54.000000000 -0400
+++ not-working	2004-06-04 16:39:25.070661844 -0400
@@ -20,7 +20,7 @@
 Initializing CPU#0
 PID hash table entries: 4096 (order 12: 32768 bytes)
 CKRM Initialized
-Detected 1894.799 MHz processor.
+Detected 1894.802 MHz processor.
 Using tsc for high-res timesource
 Console: colour dummy device 80x25
 Memory: 1034868k/1048456k available (1970k kernel code, 12652k reserved, 677k data, 212k init, 130952k highmem)
@@ -163,6 +163,10 @@
 EXT3-fs: mounted filesystem with ordered data mode.
 subfs 0.9
 Adding 1052248k swap on /dev/hda3.  Priority:42 extents:1
+orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
+Linux Kernel Card Services
+  options:  [pci] [cardbus] [pm]
+orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
 PCI: Found IRQ 11 for device 0000:02:00.0
 PCI: Sharing IRQ 11 with 0000:00:1d.2
 PCI: Sharing IRQ 11 with 0000:00:1f.1
@@ -170,8 +174,6 @@
 0000:02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19
 drivers/usb/core/usb.c: registered new driver usbfs
 drivers/usb/core/usb.c: registered new driver hub
-Linux Kernel Card Services
-  options:  [pci] [cardbus] [pm]
 PCI: Found IRQ 11 for device 0000:02:01.0
 PCI: Sharing IRQ 11 with 0000:02:01.1
 PCI: Sharing IRQ 11 with 0000:02:01.2
@@ -206,29 +208,21 @@
 cs: IO port probe 0x03e0-0x04ff: excluding 0x4d0-0x4d7
 cs: IO port probe 0x0100-0x03af: excluding 0x378-0x37f
 cs: IO port probe 0x0a00-0x0aff: clean.
-cs: memory probe 0xa0000000-0xa0ffffff: clean.
-orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
-orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
-eth1: Station identity 001f:0001:0008:000a
-eth1: Looks like a Lucent/Agere firmware version 8.10
-eth1: Ad-hoc demo mode supported
-eth1: IEEE standard IBSS ad-hoc mode supported
-eth1: WEP supported, 104-bit key
-eth1: MAC address 00:02:2D:6D:A5:BE
-eth1: Station name "HERMES I"
-eth1: ready
-eth1: index 0x01: Vcc 3.3, irq 11, io 0x0100-0x013f
-NET: Registered protocol family 17
-eth1: New link status: Disconnected (0002)
-hw_random hardware driver 1.0.0 loaded
+PCI: Found IRQ 11 for device 0000:00:1f.5
+PCI: Sharing IRQ 11 with 0000:00:1f.6
+PCI: Setting latency timer of device 0000:00:1f.5 to 64
 NET: Registered protocol family 10
 Disabled Privacy Extensions on device c03545c0(lo)
 IPv6 over IPv4 tunneling driver
-Disabled Privacy Extensions on device f753e800(sit0)
+Disabled Privacy Extensions on device f74d8000(sit0)
+intel8x0_measure_ac97_clock: measured 49389 usecs
+intel8x0: clocking to 48000
+hw_random hardware driver 1.0.0 loaded
 USB Universal Host Controller Interface driver v2.2
 PCI: Found IRQ 11 for device 0000:00:1d.0
 PCI: Sharing IRQ 11 with 0000:01:00.0
 uhci_hcd 0000:00:1d.0: UHCI Host Controller
+ieee1394: Initialized config rom entry `ip1394'
 PCI: Setting latency timer of device 0000:00:1d.0 to 64
 uhci_hcd 0000:00:1d.0: irq 11, io base 0000bf80
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
@@ -241,30 +235,24 @@
 PCI: Sharing IRQ 11 with 0000:00:1f.1
 PCI: Sharing IRQ 11 with 0000:02:00.0
 uhci_hcd 0000:00:1d.2: UHCI Host Controller
-Linux agpgart interface v0.100 (c) Dave Jones
 PCI: Setting latency timer of device 0000:00:1d.2 to 64
 uhci_hcd 0000:00:1d.2: irq 11, io base 0000bf20
 uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 2
-ieee1394: Initialized config rom entry `ip1394'
+Linux agpgart interface v0.100 (c) Dave Jones
 usb usb2: Product: UHCI Host Controller
 usb usb2: Manufacturer: Linux 2.6.4-54.5-default uhci_hcd
 usb usb2: SerialNumber: 0000:00:1d.2
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
-agpgart: Detected an Intel i845 Chipset.
-agpgart: Maximum main memory to use for agp memory: 941M
-agpgart: AGP aperture is 64M @ 0xe8000000
 ohci1394: $Rev: 1193 $ Ben Collins <bcollins@debian.org>
 PCI: Found IRQ 11 for device 0000:02:01.2
 PCI: Sharing IRQ 11 with 0000:02:01.0
 PCI: Sharing IRQ 11 with 0000:02:01.1
 PCI: Sharing IRQ 11 with 0000:02:03.0
 ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[f8fff000-f8fff7ff]  Max Packet=[2048]
-PCI: Found IRQ 11 for device 0000:00:1f.5
-PCI: Sharing IRQ 11 with 0000:00:1f.6
-PCI: Setting latency timer of device 0000:00:1f.5 to 64
-intel8x0_measure_ac97_clock: measured 78127 usecs
-intel8x0: clocking to 48000
+agpgart: Detected an Intel i845 Chipset.
+agpgart: Maximum main memory to use for agp memory: 941M
+agpgart: AGP aperture is 64M @ 0xe8000000
 ieee1394: Host added: ID:BUS[0-00:1023]  GUID[354fc00017cae021]
 parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
 parport0: irq 7 detected
@@ -273,10 +261,10 @@
 drivers/usb/core/usb.c: registered new driver usbserial
 drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
 Non-volatile memory driver v1.2
-eth1: no IPv6 routers present
 hdb: ATAPI 24X DVD-ROM drive, 512kB Cache
 Uniform CD-ROM driver Revision: 3.20
 hdc: ATAPI 24X CD-ROM CD-R/RW drive, 2048kB Cache
 SCSI subsystem initialized
 st: Version 20040318, fixed bufsize 32768, s/g segs 256
 BIOS EDD facility v0.13 2004-Mar-09, 1 devices found
+end_request: I/O error, dev fd0, sector 0
