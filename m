Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVHaPiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVHaPiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVHaPiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:38:16 -0400
Received: from mx01.qsc.de ([213.148.129.14]:40652 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S964840AbVHaPiP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:38:15 -0400
From: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Organization: ExactCode
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] wrong ide disk sector size (2.6.12.1)
Date: Wed, 31 Aug 2005 17:37:03 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508311737.04045.rene@exactcode.de>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I experience a rather strange bug that the same kernel (binary) sometimes does 
recognize the disk correctly and sometimes not.

When loaded via Grub from CD it works fine:

hda: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(33)

after installation of this kernel binary and the add-on stuff it does not 
anymore:

hda: 16514064 sectors (8455 MB), CHS=16383/16/63, UDMA(33)

Here Grub is the boot loader again. The kernel is fully modular and the ide 
modules loaded via initramfs.

The diff of the two dmesgs:

--- d   2005-08-31 15:24:41.000000000 +0200
+++ d2  2005-08-31 15:33:30.000000000 +0200
@@ -36,17 +36,17 @@
 Using ACPI (MADT) for SMP configuration information
 Allocating PCI resources starting at 0f800000 (gap: 0f800000:ef400000)
 Built 1 zonelists
-Kernel command line:
+Kernel command line: root=/dev/hda1 ro
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
 Initializing CPU#0
 PID hash table entries: 1024 (order: 10, 16384 bytes)
-Detected 1997.054 MHz processor.
+Detected 1997.045 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
 Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
-Memory: 244168k/253888k available (2470k kernel code, 9116k reserved, 663k 
data, 208k init, 0k highmem)
+Memory: 243912k/253888k available (2470k kernel code, 9328k reserved, 663k 
data, 208k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
 Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
 Mount-cache hash table entries: 512
@@ -66,14 +66,14 @@
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 pin1=2 pin2=-1
 checking if image is initramfs... it is
-Freeing initrd memory: 3297k freed
+Freeing initrd memory: 3510k freed
 NET: Registered protocol family 16
 PCI: PCI BIOS revision 2.10 entry at 0xfa140, last bus=1
 PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
 ACPI: Subsystem revision 20050309
     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK9] in namespace, 
AE_NOT_FOUND
-search_node c123fd80 start_node c123fd80 return_node 00000000
+search_node cf46ad80 start_node cf46ad80 return_node 00000000
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (0000:00)
@@ -102,7 +102,7 @@
 pnp: 00:0a: ioport range 0x400-0x4bf could not be reserved
 Machine check exception polling timer started.
 audit: initializing netlink socket (disabled)
-audit(1125493473.364:0): initialized
+audit(1125494975.878:0): initialized
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
 Squashfs 2.2 (released 2005/07/03) (C) 2002-2005 Phillip Lougher
@@ -110,7 +110,7 @@
 Initializing Cryptographic API
 ACPI: Power Button (FF) [PWRF]
 ACPI: Fan [FAN] (on)
-ACPI: Thermal Zone [THRM] (41 C)
+ACPI: Thermal Zone [THRM] (40 C)
 isapnp: Scanning for PnP cards...
 isapnp: No Plug & Play device found
 lp: driver loaded but no devices found
@@ -228,7 +228,7 @@
 ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000a9d0000050aed]
 sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
 hda: max request size: 128KiB
-hda: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(33)
+hda: 16514064 sectors (8455 MB), CHS=16383/16/63, UDMA(33)
 hda: cache flushes supported
  hda: hda1 hda2 hda3 hda4
 hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
@@ -237,8 +237,13 @@
 NTFS driver 2.1.22 [Flags: R/O MODULE].
 SGI XFS with large block numbers, no debug enabled
 Registering unionfs 1.0.13
-ISO 9660 Extensions: Microsoft Joliet Level 3
-ISO 9660 Extensions: RRIP_1991A
+EXT3-fs: mounted filesystem with ordered data mode.
+kjournald starting.  Commit interval 5 seconds
+EXT3 FS on hda1, internal journal
+kjournald starting.  Commit interval 5 seconds
+EXT3 FS on hda4, internal journal
+EXT3-fs: mounted filesystem with ordered data mode.
+Adding 1048816k swap on /dev/hda3.  Priority:-1 extents:1
 intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G 
chipsets
 intelfb: Version 0.9.2
 ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
@@ -251,7 +256,7 @@
 hw_random: RNG not detected
 ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
 PCI: Setting latency timer of device 0000:00:1f.5 to 64
-intel8x0_measure_ac97_clock: measured 49571 usecs
+intel8x0_measure_ac97_clock: measured 49623 usecs
 intel8x0: clocking to 48000
 e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
 e100: Copyright(c) 1999-2005 Intel Corporation
@@ -265,11 +270,5 @@
 ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
 [drm] Initialized i915 1.1.0 20040405 on minor 0:
 mtrr: base(0xf0020000) is not aligned on a size(0x180000) boundary
-eth0: no IPv6 routers present
 e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
-kjournald starting.  Commit interval 5 seconds
-EXT3 FS on hda1, internal journal
-EXT3-fs: mounted filesystem with ordered data mode.
-kjournald starting.  Commit interval 5 seconds
-EXT3 FS on hda4, internal journal
-EXT3-fs: mounted filesystem with ordered data mode.
+eth0: no IPv6 routers present

The full dmesg of the defect case:

Linux version 2.6.12.1-dist (root@localhost) (gcc version 3.4.3) #1 Tue Aug 9 
23:48:17 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
 BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
 BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
247MB LOWMEM available.
found SMP MP-table at 000f4f90
On node 0 totalpages: 63472
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59376 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f8790
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0f7f3040
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0f7f30c0
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0f7f6f00
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 0f800000 (gap: 0f800000:ef400000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1997.045 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 243912k/253888k available (2470k kernel code, 9328k reserved, 663k 
data, 208k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 
00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Celeron(R) CPU 2.00GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 3510k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfa140, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK9] in namespace, 
AE_NOT_FOUND
search_node cf46ad80 start_node cf46ad80 return_node 00000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0a: ioport range 0x400-0x4bf could not be reserved
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1125494975.878:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Squashfs 2.2 (released 2005/07/03) (C) 2002-2005 Phillip Lougher
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf8580000
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000e000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e100
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e200
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000e300
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack version 2.1 (1983 buckets, 15864 max) - 212 bytes per conntrack
input: AT Translated Set 2 keyboard on isa0060/serio0
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
PCI0 HUB0 UAR1 UAR2 USB0 USB1 USB2 USB3 USBE MODM
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 208k freed
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
hda: TOSHIBA MK8026GAX, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-ROM SCR-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[f8400000-f84007ff]  
Max Packet=[2048]
ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 18 (level, low) -> IRQ 18
ahc_pci:1:6:0: Host Adapter Bios disabled.  Using default SCSI device 
parameters
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000a9d0000050aed]
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB), CHS=16383/16/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
JFS: nTxBlock = 1936, nTxLock = 15493
NTFS driver 2.1.22 [Flags: R/O MODULE].
SGI XFS with large block numbers, no debug enabled
Registering unionfs 1.0.13
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048816k swap on /dev/hda3.  Priority:-1 extents:1
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G 
chipsets
intelfb: Version 0.9.2
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
intelfb: 00:02.0: Intel(R) 865G, aperture size 128MB, stolen memory 8060kB
intelfb: Mode is interlaced.
intelfb: Initial video mode is 1024x768-32@70.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
hw_random: RNG not detected
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49623 usecs
intel8x0: clocking to 48000
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:01:08.0[A] -> GSI 20 (level, low) -> IRQ 20
e100: eth0: e100_probe: addr 0xf8402000, irq 20, MAC addr 00:0A:9D:08:08:8C
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 updated from revision 0x21 to 0x2e, date = 08112004
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized i915 1.1.0 20040405 on minor 0:
mtrr: base(0xf0020000) is not aligned on a size(0x180000) boundary
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
eth0: no IPv6 routers present

Of course this leads to _major_ data corruption on the filesystems. Any idea?

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
