Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWF0SaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWF0SaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWF0SaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:30:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15683 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030269AbWF0SaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:30:12 -0400
Date: Tue, 27 Jun 2006 20:31:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git broke suspend!
Message-ID: <20060627183146.GC32115@suse.de>
References: <20060627181045.GA32115@suse.de> <20060627182014.GB7914@redhat.com> <20060627182646.GB32115@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627182646.GB32115@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2006, Jens Axboe wrote:
> I'll boot the older kernel and do a dmesg diff as well...

New ACPI, perhaps that is it?

--- old-dmesg	2006-06-27 20:26:52.000000000 +0200
+++ new-dmesg	2006-06-27 20:23:14.000000000 +0200
@@ -1,5 +1,4 @@
- BIOS-e820: 000000005fee0000 - 000000005fef5000 (ACPI data)
- BIOS-e820: 000000005fef5000 - 000000005ff00000 (ACPI NVS)
+00000005fef5000 - 000000005ff00000 (ACPI NVS)
  BIOS-e820: 000000005ff00000 - 0000000060000000 (reserved)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
@@ -38,24 +37,23 @@
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
 Using ACPI (MADT) for SMP configuration information
 Allocating PCI resources starting at 68000000 (gap: 60000000:80000000)
-Built 1 zonelists
-Kernel command line: root=/dev/sda1 vga=0x342 libata.atapi_enabled=1 libata.bridge_limits=0 resume=/dev/sda7
+Detected 798.110 MHz processor.
+Built 1 zonelists.  Total pages: 392928
+Kernel command line: root=/dev/sda1 vga=0x342 libata.atapi_enabled=1 libata.bridge_limits=0 resume=/dev/sda7 fcache.disable=1
 Unknown boot option `libata.bridge_limits=0': ignoring
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Initializing CPU#0
-CPU 0 irqstacks, hard=78375000 soft=78374000
+CPU 0 irqstacks, hard=78380000 soft=7837f000
 PID hash table entries: 4096 (order: 12, 16384 bytes)
-Detected 798.213 MHz processor.
-Using pmtmr for high-res timesource
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
 Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
-Memory: 1554664k/1571712k available (1708k kernel code, 16580k reserved, 646k data, 132k init, 0k highmem)
+Memory: 1554624k/1571712k available (1740k kernel code, 16620k reserved, 658k data, 132k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 1597.95 BogoMIPS (lpj=798975)
+Calibrating delay using timer specific routine.. 1597.30 BogoMIPS (lpj=798654)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
 CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
@@ -66,13 +64,13 @@
 Checking 'hlt' instruction... OK.
 SMP alternatives: switching to UP code
 Freeing SMP alternatives: 0k freed
+ACPI: Core revision 20060608
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: Using MMCONFIG
 Setting up standard PCI resources
-ACPI: Subsystem revision 20060127
 ACPI: Found ECDT
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
@@ -101,6 +99,7 @@
 Linux Plug and Play Support v0.97 (c) Adam Belay
 pnp: PnP ACPI init
 pnp: PnP ACPI: found 12 devices
+Intel 82802 RNG detected
 SCSI subsystem initialized
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
@@ -145,18 +144,15 @@
 Initializing Cryptographic API
 io scheduler noop registered
 io scheduler cfq registered (default)
-ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
 PCI: Setting latency timer of device 0000:00:01.0 to 64
 assign_interrupt_mode Found MSI capability
 Allocate Port Service[0000:00:01.0:pcie00]
 Allocate Port Service[0000:00:01.0:pcie03]
-ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 17
 PCI: Setting latency timer of device 0000:00:1c.0 to 64
 assign_interrupt_mode Found MSI capability
 Allocate Port Service[0000:00:1c.0:pcie00]
 Allocate Port Service[0000:00:1c.0:pcie02]
 Allocate Port Service[0000:00:1c.0:pcie03]
-ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 18
 PCI: Setting latency timer of device 0000:00:1c.2 to 64
 assign_interrupt_mode Found MSI capability
 Allocate Port Service[0000:00:1c.2:pcie00]
@@ -165,15 +161,16 @@
 vesafb: framebuffer at 0xc0000000, mapped to 0xd8880000, using 5742k, total 65472k
 vesafb: mode is 1400x1050x16, linelength=2800, pages=21
 vesafb: protected mode interface info at c000:5b55
+vesafb: pmi: set display start = 780c5bc3, set palette = 780c5bfd
+vesafb: pmi: ports = 3010 3016 3054 3038 303c 305c 3000 3004 30b0 30b2 30b4 
 vesafb: scrolling: redraw
 vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
 Console: switching to colour frame buffer device 175x65
 fb0: VESA VGA frame buffer device
 Real Time Clock Driver v1.12ac
-hw_random hardware driver 1.0.0 loaded
 Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
-pnp: Device 00:09 activated.
-00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
+pnp: Unable to assign resources to device 00:09.
+serial: probe of 00:09 failed with error -16
 ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 23 (level, low) -> IRQ 19
 libata version 1.30 loaded.
 ata_piix 0000:00:1f.2: version 1.10
@@ -208,93 +202,97 @@
 TCP bic registered
 NET: Registered protocol family 1
 NET: Registered protocol family 17
-ieee80211: 802.11 data/management/control stack, git-1.1.7
+ieee80211: 802.11 data/management/control stack, git-1.1.13
 ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
 ieee80211_crypt: registered algorithm 'NULL'
 ieee80211_crypt: registered algorithm 'WEP'
 Using IPI Shortcut mode
-ACPI wakeup devices: 
- LID SLPB UART EXP0 EXP1 EXP2 EXP3 PCI1 USB0 USB1 USB3 USB7 AC9M 
-ACPI: (supports S0 S3 S4 S5)
+ACPI: (supports<6>Time: tsc clocksource has been installed.
+ S0 S3 S4 S5)
 input: AT Translated Set 2 keyboard as /class/input/input0
+EXT3-fs: INFO: recovery required on readonly filesystem.
+EXT3-fs: write access will be enabled during recovery.
 kjournald starting.  Commit interval 5 seconds
+EXT3-fs: sda1: orphan cleanup on readonly fs
+ext3_orphan_cleanup: deleting unreferenced inode 883340
+EXT3-fs: sda1: 1 orphan inode deleted
+EXT3-fs: recovery complete.
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 132k freed
 IBM TrackPoint firmware: 0x0e, buttons: 3/3
 input: TPPS/2 IBM TrackPoint as /class/input/input1
 EXT3 FS on sda1, internal journal
-sd 0:0:0:0: Attached scsi generic sg0 type 0
+Yenta: CardBus bridge found at 0000:04:00.0 [1014:056c]
 Linux agpgart interface v0.101 (c) Dave Jones
 agpgart: Detected an Intel 915GM Chipset.
 agpgart: AGP aperture is 256M @ 0x0
-ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 20
-PCI: Setting latency timer of device 0000:00:1d.7 to 64
-ehci_hcd 0000:00:1d.7: EHCI Host Controller
-ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
-ehci_hcd 0000:00:1d.7: debug port 1
-PCI: cache line size of 32 is not supported by device 0000:00:1d.7
-ehci_hcd 0000:00:1d.7: irq 20, io mem 0xa8000000
-ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
-usb usb1: configuration #1 chosen from 1 choice
-hub 1-0:1.0: USB hub found
-hub 1-0:1.0: 8 ports detected
-ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.1.1
+ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2k
 ipw2200: Copyright(c) 2003-2006 Intel Corporation
+Yenta: ISA IRQ mask 0x04b8, PCI irq 16
+Socket status: 30000006
 USB Universal Host Controller Interface driver v3.0
-tg3.c:v3.59 (June 8, 2006)
+pcmcia: parent PCI bridge I/O window: 0x5000 - 0x8fff
+pcmcia: parent PCI bridge Memory window: 0xa8400000 - 0xb7ffffff
+pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd7ffffff
+ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 20
+ipw2200: Detected Intel PRO/Wireless 2915ABG Network Connection
+sd 0:0:0:0: Attached scsi generic sg0 type 0
+ipw2200: Detected geography ZZE (13 802.11bg channels, 19 802.11a channels)
+tg3.c:v3.60 (June 17, 2006)
 ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
 PCI: Setting latency timer of device 0000:02:00.0 to 64
-eth0: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:10:c6:dd:56:af
-eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
-eth0: dma_rwctrl[76180000] dma_mask[64-bit]
-ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 21
-ipw2200: Detected Intel PRO/Wireless 2915ABG Network Connection
+eth1: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:10:c6:dd:56:af
+eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
+eth1: dma_rwctrl[76180000] dma_mask[64-bit]
 ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
 PCI: Setting latency timer of device 0000:00:1d.0 to 64
 uhci_hcd 0000:00:1d.0: UHCI Host Controller
-uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
+uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
 uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001800
+usb usb1: configuration #1 chosen from 1 choice
+hub 1-0:1.0: USB hub found
+hub 1-0:1.0: 2 ports detected
+ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
+PCI: Setting latency timer of device 0000:00:1d.1 to 64
+uhci_hcd 0000:00:1d.1: UHCI Host Controller
+uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
+uhci_hcd 0000:00:1d.1: irq 21, io base 0x00001820
 usb usb2: configuration #1 chosen from 1 choice
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 22
-PCI: Setting latency timer of device 0000:00:1d.1 to 64
-uhci_hcd 0000:00:1d.1: UHCI Host Controller
-uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
-uhci_hcd 0000:00:1d.1: irq 22, io base 0x00001820
+ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
+PCI: Setting latency timer of device 0000:00:1d.2 to 64
+uhci_hcd 0000:00:1d.2: UHCI Host Controller
+uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
+uhci_hcd 0000:00:1d.2: irq 22, io base 0x00001840
 usb usb3: configuration #1 chosen from 1 choice
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 23
-PCI: Setting latency timer of device 0000:00:1d.2 to 64
-uhci_hcd 0000:00:1d.2: UHCI Host Controller
-uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
-uhci_hcd 0000:00:1d.2: irq 23, io base 0x00001840
+ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
+PCI: Setting latency timer of device 0000:00:1d.3 to 64
+uhci_hcd 0000:00:1d.3: UHCI Host Controller
+uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
+uhci_hcd 0000:00:1d.3: irq 23, io base 0x00001860
 usb usb4: configuration #1 chosen from 1 choice
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 20
-PCI: Setting latency timer of device 0000:00:1d.3 to 64
-uhci_hcd 0000:00:1d.3: UHCI Host Controller
-uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
-uhci_hcd 0000:00:1d.3: irq 20, io base 0x00001860
+ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
+PCI: Setting latency timer of device 0000:00:1d.7 to 64
+ehci_hcd 0000:00:1d.7: EHCI Host Controller
+ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
+ehci_hcd 0000:00:1d.7: debug port 1
+PCI: cache line size of 32 is not supported by device 0000:00:1d.7
+ehci_hcd 0000:00:1d.7: irq 23, io mem 0xa8000000
+ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
 usb usb5: configuration #1 chosen from 1 choice
 hub 5-0:1.0: USB hub found
-hub 5-0:1.0: 2 ports detected
-usb 4-2: new full speed USB device using uhci_hcd and address 2
-ipw2200: Detected geography ZZE (13 802.11bg channels, 19 802.11a channels)
-ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
-Yenta: CardBus bridge found at 0000:04:00.0 [1014:056c]
-usb 4-2: configuration #1 chosen from 1 choice
-Yenta: ISA IRQ mask 0x04b8, PCI irq 16
-Socket status: 30000006
-pcmcia: parent PCI bridge I/O window: 0x5000 - 0x8fff
-pcmcia: parent PCI bridge Memory window: 0xa8400000 - 0xb7ffffff
-pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd7ffffff
+hub 5-0:1.0: 8 ports detected
 ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 22 (level, low) -> IRQ 18
 PCI: Setting latency timer of device 0000:00:1e.2 to 64
-intel8x0_measure_ac97_clock: measured 50401 usecs
+usb 3-2: new full speed USB device using uhci_hcd and address 3
+usb 3-2: configuration #1 chosen from 1 choice
+intel8x0_measure_ac97_clock: measured 50410 usecs
 intel8x0: clocking to 48000
 loop: loaded (max 8 devices)
 kjournald starting.  Commit interval 5 seconds
@@ -309,10 +307,12 @@
 ACPI: Sleep Button (CM) [SLPB]
 ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
 ACPI: Processor [CPU] (supports 8 throttling states)
-ACPI: Thermal Zone [THM0] (47 C)
+Time: acpi_pm clocksource has been installed.
+ACPI: Thermal Zone [THM0] (46 C)
 ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
 ibm_acpi: http://ibm-acpi.sf.net/
 ibm_acpi: bay device not present
+PM: Writing back config space on device 0000:02:00.0 at offset c (was fcff0000, writing 0)
 NET: Registered protocol family 10
 ADDRCONF(NETDEV_UP): eth0: link is not ready
 IPv6 over IPv4 tunneling driver

-- 
Jens Axboe

