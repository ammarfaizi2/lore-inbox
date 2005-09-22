Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbVIVC2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbVIVC2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVIVC2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:28:00 -0400
Received: from eastrmmtao01.cox.net ([68.230.240.38]:52142 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751425AbVIVC2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:28:00 -0400
Message-ID: <433216C2.4020707@industrialstrengthsolutions.com>
Date: Wed, 21 Sep 2005 22:28:18 -0400
From: David R <david@industrialstrengthsolutions.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DMA broken in mainline 2.6.13.2 _AND_ opensuse vendor 2.6.13-15
Content-Type: multipart/mixed;
 boundary="------------060508030709050204040305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508030709050204040305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

DMA is broken in 2.6.13.2 and opensuse 2.6.13-15, for  my  cdrom/dvd 
burner.

My chipset is:

00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)

I have also heard ICH5 has this problem as well.

I can tell you that hdparm -iI /dev/hdb reports the drive in udma4 mode.

This drive is a: LITE-ON DVDRW SOHW-1693S, FwRev=KS09 However I think 
that maybe irrelevant.

On .13 I get this at the end of dmesg:

hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdb: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdb: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec

On .12 I get this but not on .13:

VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio



DMA was working correctly in 2.6.12


Attached is the .12 and .13 dmesg diff.



--------------060508030709050204040305
Content-Type: text/x-patch;
 name="dmesg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.diff"

--- dmesg.12	2005-09-21 22:20:11.000000000 -0400
+++ dmesg.13	2005-09-21 22:10:35.000000000 -0400
@@ -1,4 +1,4 @@
-Linux version 2.6.12-ck5-onemaN (root@blackbox) (gcc version 3.3.4) #2 Sun Aug 14 05:07:28 EDT 2005
+Linux version 2.6.13-ck5-15 (geeko@buildhost) (gcc version 3.3.4) #1 Wed Sep 21 21:21:25 EDT 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
@@ -15,40 +15,20 @@ On node 0 totalpages: 131067
   Normal zone: 126971 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
 DMI 2.3 present.
-ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5e30
-ACPI: RSDT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x1fffb000
-ACPI: FADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x1fffb0b2
-ACPI: BOOT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x1fffb030
-ACPI: MADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x1fffb058
-ACPI: DSDT (v001   ASUS A7V600-X 0x00001000 MSFT 0x0100000b) @ 0x00000000
-ACPI: Local APIC address 0xfee00000
-ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
-Processor #0 6:8 APIC version 16
-ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
-ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
-IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
-ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
-ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
-ACPI: IRQ0 used by override.
-ACPI: IRQ2 used by override.
-ACPI: IRQ9 used by override.
-Enabling APIC mode:  Flat.  Using 1 I/O APICs
-Using ACPI (MADT) for SMP configuration information
 Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
 Built 1 zonelists
 Kernel command line: root=/dev/sda1
-mapped APIC to ffffd000 (fee00000)
-mapped IOAPIC to ffffc000 (fec00000)
+Found and enabled local APIC!
 Initializing CPU#0
 PID hash table entries: 2048 (order: 11, 32768 bytes)
-Detected 1467.420 MHz processor.
+Detected 1467.174 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 515152k/524268k available (2333k kernel code, 8508k reserved, 927k data, 168k init, 0k highmem)
+Memory: 514924k/524268k available (2533k kernel code, 8740k reserved, 975k data, 156k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay loop... 2883.58 BogoMIPS (lpj=1441792)
+Calibrating delay using timer specific routine.. 2937.06 BogoMIPS (lpj=1468532)
 Security Framework v1.0.0 initialized
 SELinux:  Initializing.
 SELinux:  Starting in permissive mode
@@ -60,82 +40,62 @@ CPU: L2 Cache: 256K (64 bytes/line)
 CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
+mtrr: v2.0 (20020519)
 CPU: AMD Athlon(TM) XP 1700+ stepping 01
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
-ENABLING IO-APIC IRQs
-..TIMER: vector=0x31 pin1=2 pin2=-1
 NET: Registered protocol family 16
 PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1
 PCI: Using configuration type 1
-mtrr: v2.0 (20020519)
-ACPI: Subsystem revision 20050309
-ACPI: Interpreter enabled
-ACPI: Using IOAPIC for interrupt routing
-ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
-ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
-ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
-ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
-ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12)
-ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
-ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12)
-ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *15, disabled.
-ACPI: PCI Root Bridge [PCI0] (0000:00)
-PCI: Probing PCI hardware (bus 00)
-Boot video device is 0000:01:00.0
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
-Linux Plug and Play Support v0.97 (c) Adam Belay
 SCSI subsystem initialized
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
-PCI: Using ACPI for IRQ routing
-PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
-Simple Boot Flag at 0x3a set to 0x1
+PCI: Probing PCI hardware
+PCI: Probing PCI hardware (bus 00)
+Boot video device is 0000:01:00.0
+PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
+PCI: IRQ 0 for device 0000:00:0e.0 doesn't match PIRQ mask - try pci=usepirqmask
+spurious 8259A interrupt: IRQ7.
+PCI: Bridge: 0000:00:01.0
+  IO window: disabled.
+  MEM window: ee000000-efefffff
+  PREFETCH window: eff00000-f7ffffff
+PCI: Setting latency timer of device 0000:00:01.0 to 64
 Machine check exception polling timer started.
 Initializing Cryptographic API
 Real Time Clock Driver v1.12
 Linux agpgart interface v0.101 (c) Dave Jones
 [drm] Initialized drm 1.0.0 20040925
-PNP: No PS/2 controller found. Probing ports directly.
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 io scheduler noop registered
 io scheduler cfq registered
 via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
-ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 23
-PCI: Via IRQ fixup for 0000:00:12.0, from 0 to 7
-eth0: VIA Rhine II at 0xed000000, 00:11:d8:4e:bf:d3, IRQ 23.
+PCI: setting IRQ 3 as level-triggered
+PCI: Assigned IRQ 3 for device 0000:00:12.0
+IRQ routing conflict for 0000:00:0f.1, have irq 14, want irq 3
+PCI: Sharing IRQ 3 with 0000:00:10.0
+PCI: Sharing IRQ 3 with 0000:00:10.1
+eth0: VIA Rhine II at 0xed000000, 00:11:d8:4e:bf:d3, IRQ 3.
 eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
-VP_IDE: IDE controller at PCI slot 0000:00:0f.1
-ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
-PCI: Via IRQ fixup for 0000:00:0f.1, from 14 to 4
-VP_IDE: chipset revision 6
-VP_IDE: not 100% native mode: will probe irqs later
-VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
-    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:pio, hdb:DMA
-    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
 Probing IDE interface ide0...
 hdb: LITE-ON DVDRW SOHW-1693S, ATAPI CD/DVD-ROM drive
-ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
-Probing IDE interface ide1...
 Probing IDE interface ide1...
-Probing IDE interface ide2...
-Probing IDE interface ide3...
-Probing IDE interface ide4...
-Probing IDE interface ide5...
+ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hdb: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
 Uniform CD-ROM driver Revision: 3.20
-libata version 1.11 loaded.
+libata version 1.12 loaded.
 sata_via version 1.1
-ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
-PCI: Via IRQ fixup for 0000:00:0f.0, from 0 to 4
-sata_via(0000:00:0f.0): routed to hard irq line 4
-ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xB802 bmdma 0xA800 irq 20
-ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 20
+PCI: setting IRQ 9 as level-triggered
+PCI: Assigned IRQ 9 for device 0000:00:0f.0
+PCI: Sharing IRQ 9 with 0000:00:10.2
+PCI: Sharing IRQ 9 with 0000:00:10.3
+sata_via(0000:00:0f.0): routed to hard irq line 9
+ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xB802 bmdma 0xA800 irq 9
+ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 9
 ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
 ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
 ata1: dev 0 configured for UDMA/133
@@ -162,43 +122,49 @@ SCSI device sdb: drive cache: write back
 Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
 Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
 Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
-usbmon: debugs is not available
-ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
-PCI: Via IRQ fixup for 0000:00:10.4, from 0 to 5
+usbmon: debugfs is not available
+PCI: Found IRQ 11 for device 0000:00:10.4
+PCI: Sharing IRQ 11 with 0000:00:11.5
 ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
 ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
-ehci_hcd 0000:00:10.4: irq 21, io mem 0xed800000
+ehci_hcd 0000:00:10.4: irq 11, io mem 0xed800000
 ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 8 ports detected
-ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
-USB Universal Host Controller Interface driver v2.2
-ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
-PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 5
+ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
+USB Universal Host Controller Interface driver v2.3
+PCI: Assigned IRQ 3 for device 0000:00:10.0
+IRQ routing conflict for 0000:00:0f.1, have irq 14, want irq 3
+PCI: Sharing IRQ 3 with 0000:00:10.1
+PCI: Sharing IRQ 3 with 0000:00:12.0
 uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
 uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
-uhci_hcd 0000:00:10.0: irq 21, io base 0x00009800
+uhci_hcd 0000:00:10.0: irq 3, io base 0x00009800
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
-PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 5
+PCI: Assigned IRQ 3 for device 0000:00:10.1
+IRQ routing conflict for 0000:00:0f.1, have irq 14, want irq 3
+PCI: Sharing IRQ 3 with 0000:00:10.0
+PCI: Sharing IRQ 3 with 0000:00:12.0
 uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
 uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
-uhci_hcd 0000:00:10.1: irq 21, io base 0x00009400
+uhci_hcd 0000:00:10.1: irq 3, io base 0x00009400
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
-PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 5
+PCI: Assigned IRQ 9 for device 0000:00:10.2
+PCI: Sharing IRQ 9 with 0000:00:0f.0
+PCI: Sharing IRQ 9 with 0000:00:10.3
 uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
 uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
-uhci_hcd 0000:00:10.2: irq 21, io base 0x00009000
+uhci_hcd 0000:00:10.2: irq 9, io base 0x00009000
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
-PCI: Via IRQ fixup for 0000:00:10.3, from 0 to 5
+PCI: Assigned IRQ 9 for device 0000:00:10.3
+PCI: Sharing IRQ 9 with 0000:00:0f.0
+PCI: Sharing IRQ 9 with 0000:00:10.2
 uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
 uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
-uhci_hcd 0000:00:10.3: irq 21, io base 0x00008800
+uhci_hcd 0000:00:10.3: irq 9, io base 0x00008800
 hub 5-0:1.0: USB hub found
 hub 5-0:1.0: 2 ports detected
 usb 1-4: new high speed USB device using ehci_hcd and address 4
@@ -217,24 +183,47 @@ input: USB HID v1.10 Mouse [Logitech Log
 usbcore: registered new driver usbhid
 drivers/usb/input/hid-core.c: v2.01:USB HID core driver
 mice: PS/2 mouse device common for all mice
+Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
+via82xx: Assuming DXS channels with 48k fixed sample rate.
+         Please try dxs_support=5 option
+         and report if it works on your machine.
+         For more details, read ALSA-Configuration.txt.
+PCI: Found IRQ 11 for device 0000:00:11.5
+PCI: Sharing IRQ 11 with 0000:00:10.4
+PCI: Setting latency timer of device 0000:00:11.5 to 64
+codec_read: codec 0 is not valid [0xfe0000]
+codec_read: codec 0 is not valid [0xfe0000]
+codec_read: codec 0 is not valid [0xfe0000]
+codec_read: codec 0 is not valid [0xfe0000]
+PCI: Enabling device 0000:00:0e.0 (0004 -> 0005)
+PCI: IRQ 0 for device 0000:00:0e.0 doesn't match PIRQ mask - try pci=usepirqmask
+PCI: setting IRQ 5 as level-triggered
+PCI: Assigned IRQ 5 for device 0000:00:0e.0
+ice1724: Invalid EEPROM version 1
+ALSA device list:
+  #0: VIA 8237 with AD1888 at 0xe000, irq 11
+  #1: Chaintech AV-710 at 0xd800, irq 5
 NET: Registered protocol family 2
-IP: routing cache hash table of 4096 buckets, 32Kbytes
+IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
 TCP established hash table entries: 32768 (order: 6, 262144 bytes)
 TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
 TCP: Hash tables configured (established 32768 bind 32768)
+TCP reno registered
 ip_conntrack version 2.1 (4095 buckets, 32760 max) - 212 bytes per conntrack
 ip_tables: (C) 2000-2002 Netfilter core team
 ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
 arp_tables: (C) 2002 David S. Miller
+TCP bic registered
 NET: Registered protocol family 1
 NET: Registered protocol family 17
+Using IPI Shortcut mode
 ReiserFS: sda1: found reiserfs format "3.6" with standard journal
 ReiserFS: sda1: using ordered data mode
 ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
 ReiserFS: sda1: checking transaction log (sda1)
 ReiserFS: sda1: Using r5 hash to sort names
 VFS: Mounted root (reiserfs filesystem) readonly.
-Freeing unused kernel memory: 168k freed
+Freeing unused kernel memory: 156k freed
 Adding 1502068k swap on /dev/sda3.  Priority:-1 extents:1
 ReiserFS: sda1: switching to writeback data mode
 ReiserFS: sda2: found reiserfs format "3.6" with standard journal
@@ -248,22 +237,12 @@ ReiserFS: sdb1: journal params: device s
 ReiserFS: sdb1: checking transaction log (sdb1)
 ReiserFS: sdb1: Using r5 hash to sort names
 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
-nvidia: module license 'NVIDIA' taints kernel.
-ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
-NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7676  Fri Jul 29 12:58:54 PDT 2005
-via82xx: Assuming DXS channels with 48k fixed sample rate.
-         Please try dxs_support=1 or dxs_support=4 option
-         and report if it works on your machine.
-ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
-PCI: Via IRQ fixup for 0000:00:11.5, from 0 to 6
-PCI: Setting latency timer of device 0000:00:11.5 to 64
-ALSA /home/oneman/olddownloads/alsa-driver-1.0.9b/alsa-kernel/pci/via82xx.c:583: codec_read: codec 0 is not valid [0xfe0000]
-ALSA /home/oneman/olddownloads/alsa-driver-1.0.9b/alsa-kernel/pci/via82xx.c:583: codec_read: codec 0 is not valid [0xfe0000]
-ALSA /home/oneman/olddownloads/alsa-driver-1.0.9b/alsa-kernel/pci/via82xx.c:583: codec_read: codec 0 is not valid [0xfe0000]
-ALSA /home/oneman/olddownloads/alsa-driver-1.0.9b/alsa-kernel/pci/via82xx.c:583: codec_read: codec 0 is not valid [0xfe0000]
-PCI: Enabling device 0000:00:0e.0 (0004 -> 0005)
-ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
-ice1724: Invalid EEPROM version 1
 NET: Registered protocol family 10
 IPv6 over IPv4 tunneling driver
 eth0: no IPv6 routers present
+hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
+hdb: drive_cmd: error=0x04 { AbortedCommand }
+ide: failed opcode was: 0xec
+hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
+hdb: drive_cmd: error=0x04 { AbortedCommand }
+ide: failed opcode was: 0xec

--------------060508030709050204040305--
