Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUIWR1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUIWR1C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUIWR0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:26:15 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:58702 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268177AbUIWRXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:23:13 -0400
Message-ID: <7f800d9f040923102315e8d400@mail.gmail.com>
Date: Thu, 23 Sep 2004 10:23:10 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: USB (OHCI) not working without pci=routeirq
Cc: bjorn.helgaas@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn, Linux kernel devs,

when booting with a recent kernel (2.6.9-rc2-mm2), usb_ohci fails to
initialize the USB bus and no USB device will work at that point.
Adding pci=routeirq fixed the problem.

I believe this has been working with earlier kernels, but I don't use
USB often enough to remember.

The PC is an Compaq (HP) Presario 2100Z notebook.

Here's a diff of the dmesg output of two boots with and without pci=routeirq:

--- acpiirq/dmesg	2004-09-23 10:09:57.615512000 -0700
+++ pcirouteirq/dmesg	2004-09-23 10:07:34.000000000 -0700
@@ -22,10 +22,10 @@
 ACPI: DSDT (v001    ATI U1_M1535 0x06040000 MSFT 0x0100000d) @ 0x00000000
 Built 1 zonelists
 Initializing CPU#0
-Kernel command line: BOOT_IMAGE=Gentoo ro root=305 elevator=cfq
+Kernel command line: BOOT_IMAGE=Gentoo ro root=305 elevator=cfq pci=routeirq
 CPU 0 irqstacks, hard=c04df000 soft=c04de000
 PID hash table entries: 2048 (order: 11, 32768 bytes)
-Detected 1788.828 MHz processor.
+Detected 1789.260 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
@@ -72,18 +72,28 @@
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 PCI: Using ACPI for IRQ routing
-** PCI interrupts are no longer routed automatically.  If this
-** causes a device to stop working, it is probably because the
-** driver failed to call pci_enable_device().  As a temporary
-** workaround, the "pci=routeirq" argument restores the old
-** behavior.  If this argument makes the device work again,
+** Routing PCI interrupts for all devices because "pci=routeirq"
+** was specified.  If this was required to make a driver work,
 ** please email the output of "lspci" to bjorn.helgaas@hp.com
 ** so I can fix the driver.
+ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 10
+ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
+ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
+ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
+ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 3
+ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 3 (level, low) -> IRQ 3
+ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
+ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
+ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
+ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
+ACPI: PCI interrupt 0000:00:10.0[A]: no GSI
+ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
+ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
+ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 (level, low) -> IRQ 10
 Simple Boot Flag at 0x36 set to 0x1
 Machine check exception polling timer started.
 ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
 Activating ISA DMA hang workarounds.
-ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
 ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 (level, low) -> IRQ 10
 radeonfb: Retreived PLL infos from BIOS
 radeonfb: Reference=191.86 MHz (RefDiv=426) Memory=160.00 Mhz,
System=133.00 MHz
@@ -114,7 +124,6 @@
 serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
-ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 3
 ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 3 (level, low) -> IRQ 3
 ttyS1 at I/O 0x8828 (irq = 3) is a 8250
 ttyS2 at I/O 0x8840 (irq = 3) is a 8250
@@ -128,7 +137,6 @@
   originally by Donald Becker <becker@scyld.com>
   http://www.scyld.com/network/natsemi.html
   2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
-ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
 ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
 natsemi eth0: NatSemi DP8381[56] at 0xdc838000 (0000:00:12.0),
00:0d:9d:5a:41:46, IRQ 11, port TP.
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
@@ -162,17 +170,12 @@
 hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
 Uniform CD-ROM driver Revision: 3.20
 ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
-ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 10
 ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
 ohci_hcd 0000:00:02.0: ALi Corporation USB 1.1 Controller
 ohci_hcd 0000:00:02.0: irq 10, pci mem 0xd0004000
 ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
-ohci_hcd 0000:00:02.0: init err (00002edf 2a2f)
-ohci_hcd 0000:00:02.0: can't start
-ohci_hcd 0000:00:02.0: init error -75
-ohci_hcd 0000:00:02.0: remove, state 0
-ohci_hcd 0000:00:02.0: USB bus 1 deregistered
-ohci_hcd: probe of 0000:00:02.0 failed with error -75
+hub 1-0:1.0: USB hub found
+hub 1-0:1.0: 4 ports detected
 Initializing USB Mass Storage driver...
 usbcore: registered new driver usb-storage
 USB Mass Storage support registered.
@@ -180,6 +183,8 @@
 drivers/usb/input/hid-core.c: v2.0:USB HID core driver
 mice: PS/2 mouse device common for all mice
 input: AT Translated Set 2 keyboard on isa0060/serio0
+usb 1-2: new low speed USB device using address 2
+input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:02.0-2
 Synaptics Touchpad, model: 1
  Firmware: 5.9
  Sensor: 35
@@ -189,7 +194,6 @@
  -> palm detection
 input: SynPS/2 Synaptics TouchPad on isa0060/serio1
 Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15
07:17:53 2004 UTC).
-ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
 ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
 ALSA device list:
   #0: ALI 5451 at 0x8400, irq 5
@@ -216,10 +220,9 @@
 Adding 1004052k swap on /dev/hda3.  Priority:-1 extents:1
 Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
-ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
 ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
 Yenta: CardBus bridge found at 0000:00:0a.0 [0000:0000]
-Yenta: ISA IRQ mask 0x0498, PCI irq 11
+Yenta: ISA IRQ mask 0x0098, PCI irq 11
 Socket status: 30000007
 eth0: DSPCFG accepted after 0 usec.
 eth0: link up.


lspci:
0000:00:00.0 Host bridge: ATI Technologies Inc AGP Bridge [IGP 320M] (rev 13)
0000:00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 320M] (rev 01)
0000:00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 02)
0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
0000:00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller
0000:00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
0000:00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
IEEE-1394a-2000 Controller (PHY/Link)
0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
0000:00:12.0 Ethernet controller: National Semiconductor Corporation
DP83815 (MacPhyter) Ethernet Controller
0000:01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1


Let me know if you require any additional information.

Cheers,
    Andre
