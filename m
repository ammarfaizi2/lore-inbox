Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUIKVbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUIKVbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268336AbUIKVbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:31:15 -0400
Received: from zork.zork.net ([64.81.246.102]:40844 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S268334AbUIKVam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:30:42 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: 2.6.8-rc1-mm4: allow-i8042-register-location-override-2.patch
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Dmitry Torokhov
	<dtor@mail.ru>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Date: Sat, 11 Sep 2004 22:30:10 +0100
Message-ID: <6uy8jg4hp9.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/broken-out/allow-i8042-register-location-override-2.patch

> Input: Add ACPI-based i8042 keyboard and aux controller enumeration;
> can be disabled by passing i8042.noacpi as a boot parameter.

On a whim I decided to turn on ACPI, only to discover that my keyboard
no longer worked.  Passing i8042.noacpi=1 makes it work again.
Attached please find boot messages with and without the boot
parameter.  Inlined below is a diff of the two.


--- 269rc1mm4-nokbd	2004-09-11 22:17:35.000000000 +0100
+++ 269rc1mm4-kbd	2004-09-11 22:13:34.000000000 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.9-rc1-mm4 (sneakums@sto-kerrig) (gcc version 3.4.1 (Debian 3.4.1-7)) #243 SMP Sat Sep 11 15:36:38 IST 2004
+Linux version 2.6.9-rc1-mm4 (sneakums@sto-kerrig) (gcc version 3.4.1 (Debian 3.4.1-7)) #246 SMP Sat Sep 11 20:10:54 IST 2004
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -26,11 +26,11 @@
 Using ACPI (MADT) for SMP configuration information
 Built 1 zonelists
 Initializing CPU#0
-Kernel command line: auto BOOT_IMAGE=Linux ro root=801 noirqbalance aic7xxx=global_tag_depth:4
+Kernel command line: auto BOOT_IMAGE=Linux ro root=801 noirqbalance aic7xxx=global_tag_depth:4 i8042.noacpi=1
 Setting Global Tags= 4
 CPU 0 irqstacks, hard=c0514000 soft=c0512000
 PID hash table entries: 4096 (order: 12, 65536 bytes)
-Detected 1129.820 MHz processor.
+Detected 1129.582 MHz processor.
 Using pmtmr for high-res timesource
 Console: colour VGA+ 100x30
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
@@ -107,7 +107,9 @@
 agpgart: Maximum main memory to use for agp memory: 1919M
 agpgart: AGP aperture is 128M @ 0xe0000000
 [drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
-i8042: ACPI  [PS2K] at I/O 0x0, 0x0, irq 1
+i8042: ACPI detection disabled
+serio: i8042 AUX port at 0x60,0x64 irq 12
+serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
@@ -180,17 +182,18 @@
 usbcore: registered new driver usbhid
 drivers/usb/input/hid-core.c: v2.0:USB HID core driver
 mice: PS/2 mouse device common for all mice
+input: AT Translated Set 2 keyboard on isa0060/serio0
 device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
 Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
 ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
 ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 11 (level, low) -> IRQ 11
 PCI: Via IRQ fixup for 0000:00:07.5, from 12 to 11
 usb 1-2: new full speed USB device using address 2
+hub 1-2:1.0: USB hub found
+hub 1-2:1.0: 4 ports detected
 ALSA device list:
   #0: VIA 82C686A/B rev50 at 0xd800, irq 11
 NET: Registered protocol family 2
-hub 1-2:1.0: USB hub found
-hub 1-2:1.0: 4 ports detected
 IP: routing cache hash table of 16384 buckets, 128Kbytes
 TCP: Hash tables configured (established 524288 bind 65536)
 ip_conntrack version 2.1 (8192 buckets, 65536 max) - 368 bytes per conntrack
@@ -201,10 +204,7 @@
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 NET: Registered protocol family 15
-EXT3-fs: INFO: recovery required on readonly filesystem.
-EXT3-fs: write access will be enabled during recovery.
 kjournald starting.  Commit interval 5 seconds
-EXT3-fs: recovery complete.
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 208k freed


--=-=-=
Content-Disposition: attachment; filename=269rc1mm4-nokbd

Linux version 2.6.9-rc1-mm4 (sneakums@sto-kerrig) (gcc version 3.4.1 (Debian 3.4.1-7)) #243 SMP Sat Sep 11 15:36:38 IST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff8000 (ACPI data)
 BIOS-e820: 000000007fff8000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fb110
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:11 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:11 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=Linux ro root=801 noirqbalance aic7xxx=global_tag_depth:4
Setting Global Tags= 4
CPU 0 irqstacks, hard=c0514000 soft=c0512000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1129.820 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 100x30
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2074340k/2097088k available (2928k kernel code, 21912k reserved, 1005k data, 208k init, 1179584k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
per-CPU timeslice cutoff: 1463.46 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c0515000 soft=c0513000
Initializing CPU#1
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
Total of 2 processors activated (4489.21 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
ACPI: Thermal Zone [THRM] (30 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
i8042: ACPI  [PS2K] at I/O 0x0, 0x0, irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
lp0: using parport0 (polling).
parport_pc: Via 686A parallel port: io=0x378
floppy: ACPI  [FDC0] at I/O 0x3f2-0x3f5, 0x3f7 irq 6 dma channel 2
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
e100: eth0: e100_probe: addr 0xdfffe000, irq 18, MAC addr 00:02:B3:28:83:7B
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
e100: eth1: e100_probe: addr 0xdfffc000, irq 17, MAC addr 00:02:B3:28:86:F8
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
r8169 Gigabit Ethernet driver 1.6LK loaded
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 16
r8169: NAPI enabled
eth2: RTL8169 at 0xf8812f00, 00:09:5b:bc:b1:09, IRQ 16
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: PHILIPS CDRWDVD3210, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X DVD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 19160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0xc800
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: irq 10, io base 0xcc00
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 11 (level, low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:07.5, from 12 to 11
usb 1-2: new full speed USB device using address 2
ALSA device list:
  #0: VIA 82C686A/B rev50 at 0xd800, irq 11
NET: Registered protocol family 2
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 368 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
usb 1-2.2: new low speed USB device using address 3
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:07.2-2.2
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
r8169: eth2: link up

--=-=-=
Content-Disposition: attachment; filename=269rc1mm4-kbd

Linux version 2.6.9-rc1-mm4 (sneakums@sto-kerrig) (gcc version 3.4.1 (Debian 3.4.1-7)) #246 SMP Sat Sep 11 20:10:54 IST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff8000 (ACPI data)
 BIOS-e820: 000000007fff8000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fb110
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:11 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:11 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=Linux ro root=801 noirqbalance aic7xxx=global_tag_depth:4 i8042.noacpi=1
Setting Global Tags= 4
CPU 0 irqstacks, hard=c0514000 soft=c0512000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1129.582 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 100x30
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2074340k/2097088k available (2928k kernel code, 21912k reserved, 1005k data, 208k init, 1179584k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
per-CPU timeslice cutoff: 1463.46 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c0515000 soft=c0513000
Initializing CPU#1
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
Total of 2 processors activated (4489.21 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
ACPI: Thermal Zone [THRM] (30 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
i8042: ACPI detection disabled
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
lp0: using parport0 (polling).
parport_pc: Via 686A parallel port: io=0x378
floppy: ACPI  [FDC0] at I/O 0x3f2-0x3f5, 0x3f7 irq 6 dma channel 2
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
e100: eth0: e100_probe: addr 0xdfffe000, irq 18, MAC addr 00:02:B3:28:83:7B
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
e100: eth1: e100_probe: addr 0xdfffc000, irq 17, MAC addr 00:02:B3:28:86:F8
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
r8169 Gigabit Ethernet driver 1.6LK loaded
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 16
r8169: NAPI enabled
eth2: RTL8169 at 0xf8812f00, 00:09:5b:bc:b1:09, IRQ 16
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: PHILIPS CDRWDVD3210, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X DVD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 19160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0xc800
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: irq 10, io base 0xcc00
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 11 (level, low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:07.5, from 12 to 11
usb 1-2: new full speed USB device using address 2
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
ALSA device list:
  #0: VIA 82C686A/B rev50 at 0xd800, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 368 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
usb 1-2.2: new low speed USB device using address 3
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:07.2-2.2
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
r8169: eth2: link up

--=-=-=--
