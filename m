Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbUKBMxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUKBMxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbUKBMvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:51:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30955 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261561AbUKBMsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:48:06 -0500
Message-ID: <418781EF.7020100@pobox.com>
Date: Tue, 02 Nov 2004 07:47:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Netdev <netdev@oss.sgi.com>
CC: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: IPv6 dead in -bk11
Content-Type: multipart/mixed;
 boundary="------------090906050700040108000402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090906050700040108000402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


IPv6 works 100% for my workstations in 2.6.10-rc2-bk2, but fails in 
2.6.10-rc2-bk11:

	[jgarzik@sata g]$ ping6 www.kame.net
	connect: Network is unreachable

100% reproducible on multiple machines (x86, x86-64).  Fedora Core 2 
userland.  The only difference is the kernel, no configuration 
differences account for this.  dmesg and config are attached, but IMO 
are unlikely to be helpful.

Did someone break the IPv6 routing code or something, perhaps?

I'll narrow down which -bk snapshot broke IPv6 later on today...

	Jeff




--------------090906050700040108000402
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.10-rc1-bk11 (jgarzik@sata.yyz.us) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 SMP Tue Nov 2 07:35:27 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f8d90
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000e9e10
ACPI: RSDT (v001 COMPAQ CPQ0063  0x20031217  0x00000000) @ 0x000e5640
ACPI: FADT (v001 COMPAQ CANTERW  0x00000001  0x00000000) @ 0x000e56ec
ACPI: SSDT (v001 COMPAQ  PROJECT 0x00000001 MSFT 0x0100000e) @ 0x000e6579
ACPI: MADT (v001 COMPAQ CANTERW  0x00000001  0x00000000) @ 0x000e5760
ACPI: ASF! (v016 COMPAQ CANTERW  0x00000001  0x00000000) @ 0x000e57c8
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1 already used, trying 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: ro root=LABEL=/ nogui
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2395.070 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 904796k/917504k available (2535k kernel code, 12164k reserved, 804k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4734.97 BogoMIPS (lpj=2367488)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1462.31 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 4784.12 BogoMIPS (lpj=2392064)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (9519.10 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1:
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 137k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 20 (level, low) -> IRQ 209
ACPI: PCI interrupt 0000:05:02.0[A] -> GSI 17 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:05:0a.0[A] -> GSI 21 (level, low) -> IRQ 217
Machine check exception polling timer started.
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 256M @ 0xe0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x24c0-0x24c7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x24c8-0x24cf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST CD-ROM GCR-8480B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 193
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 193, pci mem 0xf0500000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
hub 1-0:1.0: over-current change on port 7
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 169, io base 0x2440
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 177
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 177, io base 0x2460
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 185, io base 0x2480
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 26
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
PCI0  HUB COM1 COM2 USB1 USB2 USB3 USB4 EUSB PBTN 
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
libata version 1.02 loaded.
ata_piix version 1.02
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x24F0 ctl 0x280A bmdma 0x24D0 irq 185
ata2: SATA max UDMA/133 cmd 0x24F8 ctl 0x280E bmdma 0x24D8 irq 185
ata1: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:203f
ata1: dev 0 ATA, max UDMA/100, 160836480 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: HDS722580VLSA80   Rev: V32O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
sata_sil version 0.54
ACPI: PCI interrupt 0000:05:0a.0[A] -> GSI 21 (level, low) -> IRQ 217
ata3: SATA max UDMA/100 cmd 0xF8848080 ctl 0xF884808A bmdma 0xF8848000 irq 217
ata4: SATA max UDMA/100 cmd 0xF88480C0 ctl 0xF88480CA bmdma 0xF8848008 irq 217
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:407f
ata3: dev 0 ATA, max UDMA/133, 488281250 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 488281250 512-byte hdwr sectors (250000 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 192k freed
EXT3 FS on hda5, internal journal
Adding 1020592k swap on /dev/hda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
Disabled Privacy Extensions on device c03f5880(lo)
tg3.c:v3.11 (October 20, 2004)
ACPI: PCI interrupt 0000:05:02.0[A] -> GSI 17 (level, low) -> IRQ 201
eth0: Tigon3 [partno(BCM95700A6) rev 3002 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:30:6e:4c:04:ac
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
ip_tables: (C) 2000-2002 Netfilter core team
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
Intel 810 + AC97 Audio, version 1.01, 07:31:33 Nov  2 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH5 found at IO 0x2400 and 0x2000, MEM 0xf0500400 and 0xf0500600, IRQ 201
i810: Intel ICH5 mmio at 0xf8852400 and 0xf8860600
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2

--------------090906050700040108000402
Content-Type: application/x-bzip2;
 name="config.txt.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.txt.bz2"

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
IiA=
--------------090906050700040108000402--
