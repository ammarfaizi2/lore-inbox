Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316804AbSFZUIR>; Wed, 26 Jun 2002 16:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSFZUIQ>; Wed, 26 Jun 2002 16:08:16 -0400
Received: from [147.188.32.218] ([147.188.32.218]:37214 "HELO
	pc1.sr.bham.ac.uk") by vger.kernel.org with SMTP id <S316804AbSFZUIO>;
	Wed, 26 Jun 2002 16:08:14 -0400
Date: Wed, 26 Jun 2002 21:08:28 +0100 (BST)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: 2.4.18 + 19pre10 + ac2 gives cdrw ide-scsi data discarded errors
Message-ID: <Pine.LNX.4.44.0206262034140.2365-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On a brand new system (Abit IT7), I've been getting errors writing CDs.
As it's a new machine, I've not successfully written any CDs yet, so it
is potentially a faulty cdrw drive, but I'm also a little suspicious that 
it's a possible issue with the motherboard.

Configuration:

Two hard disks on the highpoint 374, raid-1.
DVD on hda
CDRW on sg0/sr0 (hdc before setting up ide-scsi)

Using xcdroast, gives:

Performing OPC...
cdrecord: Input/output error. send opc: scsi sendcmd: retryable error
CDB:  54 01 00 00 00 00 00 00 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 200.114s timeout 200s
cdrecord: Resource temporarily unavailable. OPC failed.

when trying to write an image.

In syslog:

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-32123S        Rev: XS0X
  Type:   CD-ROM                             ANSI SCSI revision: 02
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 1 of 2 bytes
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 1 of 2 bytes
scsi : aborting command due to timeout : pid 241, scsi0, channel 0, id 0, 
lun 0 UNKNOWN(0x54) 01 00 00 00 00 00 00 00 00 

Google didn't turn up anything recent about discarded data, but I recall 
there being some recent changes to ide-scsi in 2.4.x.

Anyone else seeing this with very recent 2.4.x ?  Any thoughts about how
to proceed ?  It is difficult to try earlier kernels as the highpoint 374
is only very recently supported.

Cheers,

Mark

dmesg:

Linux version 2.4.18-19pre10ac2b (root@pc24.sr.bham.ac.uk) (gcc version 
2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 Wed Jun 26 17:59:22 BST 
2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: initrd=initrd.img root=/dev/md0 BOOT_IMAGE=vmlinuz 
auto
Initializing CPU#0
Detected 2010.002 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4010.80 BogoMIPS
Memory: 514428k/524224k available (1111k kernel code, 9408k reserved, 299k 
data, 296k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: Found IRQ 7 for device 00:1f.1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
block: 992 slots per queue, batch=248
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Found IRQ 7 for device 00:1f.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
HPT374: IDE controller on PCI bus 02 dev 20
PCI: Found IRQ 11 for device 02:04.0
PCI: Sharing IRQ 11 with 02:04.1
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:DMA, hdh:pio
HPT374: IDE controller on PCI bus 02 dev 21
PCI: Found IRQ 11 for device 02:04.1
PCI: Sharing IRQ 11 with 02:04.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xb800-0xb807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xb808-0xb80f, BIOS settings: hdk:pio, hdl:pio
hda: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
hdc: LITE-ON LTR-32123S, ATAPI CD/DVD-ROM drive
hde: ST340016A, ATA DISK drive
hdg: ST340016A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9400-0x9407,0x9802 on irq 11
ide3 at 0x9c00-0x9c07,0xa002 on irq 11
hde: host protected area => 1
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, 
UDMA(100)
hdg: host protected area => 1
hdg: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, 
UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hde: hde1 hde2 hde3 hde4
 hdg: hdg1 hdg2 hdg3 hdg4
Floppy drive(s): fd0 is 1.44M

<snip>

ide-floppy driver 0.99.newide
hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-cd: ignoring drive hdc
hda: DMA disabled
ide-cd: ignoring drive hdc
ide-floppy driver 0.99.newide
hdc: driver not present
ip_conntrack (4095 buckets, 32760 max)
8139too Fast Ethernet driver 0.9.24
PCI: Found IRQ 10 for device 02:06.0
eth1: RealTek RTL8139 Fast Ethernet at 0xe09b6000, 00:50:8d:a8:06:7e, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8139C'
eth1: Media type forced to Full Duplex.
eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability 4181.
cipcb: CIPE driver vers 1.4.5 (c) Olaf Titz 1996-2000, 100 channels, debug=0
Intel 810 + AC97 Audio, version 0.21, 18:15:16 Jun 26 2002
PCI: Found IRQ 3 for device 00:1f.5
PCI: Sharing IRQ 3 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH4 found at IO 0xe400 and 0xe000, IRQ 3
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x414c:0x4720 (ALC650)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 6
ide-cd: ignoring drive hdc
ide-floppy driver 0.99.newide
hdc: driver not present
cdrom: This disc doesn't have any tracks I recognize!
ide-cd: ignoring drive hdc
ide-floppy driver 0.99.newide
hdc: driver not present
ide-cd: ignoring drive hdc
ide-floppy driver 0.99.newide
hdc: driver not present
ide-cd: ignoring drive hdc
ide-floppy driver 0.99.newide
hdc: driver not present
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-32123S        Rev: XS0X
  Type:   CD-ROM                             ANSI SCSI revision: 02
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 1 of 2 bytes
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 1 of 2 bytes
scsi : aborting command due to timeout : pid 241, scsi0, channel 0, id 0, lun 0 UNKNOWN(0x54) 01 00 00 00 00 00 00 00 00 
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }

