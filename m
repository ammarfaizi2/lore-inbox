Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTBYBNu>; Mon, 24 Feb 2003 20:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbTBYBNu>; Mon, 24 Feb 2003 20:13:50 -0500
Received: from cliff.cse.wustl.edu ([128.252.166.5]:14735 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP
	id <S262821AbTBYBNB>; Mon, 24 Feb 2003 20:13:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15962.50292.300435.567257@samba.doc.wustl.edu>
Date: Mon, 24 Feb 2003 19:18:44 -0600
From: Krishnakumar B <kitty@cse.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.20, Athlon MP and Promise PDC20276 IDE controller
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just bought 3 identical AMD Athlon 2400+ MP machines with Gigabyte
GA-7DPXDW-P motherboard. This board has a Promise PDC20276 IDE RAID
controller on-board which I have setup to function as a ATA/133 IDE
controller. I have attached both Maxtor ATA/133 disks to this controller
instead of the on-board AMD IDE controller.

Linux doesn't seem to enable DMA on this controller. As you can see from
the boot message below both ide2 and ide3 are in PIO modes. Am I right in
assuming that Linux doesn't enable DMA on this controller ? How do I
determine if DMA is enabled for a ide controller apart from relying on the
boot message ? Also when I try hdparm -tT /dev/hde, I get 57.xx MB/sec.
Does this mean that my disk is capable of doing that much speed and the ide
controller is functioning fine i.e DMA is enabled or is it still possible
that my ide controller is in PIO mode ?

Does anyone know which kernel should I run to get DMA on PDC20276 ? I have
flashed the motherboard BIOS to the latest version available i.e F4. Do I
need to flash the Promise controller also to the latest version ?

Also this machine seems to have problems with SMP mode. From time to time
when booting, the machine reboots just after printing the following line:

BIOS failed to enable PCI standards compliance, fixing this error.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found

Or atleast that's what I can see last. Every time just before this happens,
Linux seems to pause just after printing

Booting processor 1/1 eip 2000

This is reproducible on all three machines. However Linux UP always seems
to succeed. Is this an Linux SMP issue or BIOS/motherboard issue ? Any help
in resolving this is also very much appreciated. Each machine has an
ENERMAX 430W power supply and 4 80mm fans.

I am using the latest RedHat rawhide (2.4.20-2.54) kernel. I chose this
because this kernel or the latest -ac kernel seems likely to have the best
chance of working right on AMD machines; the default RedHat 8.0 kernel
couldn't enable DMA on the on-board IDE controller. I can't try 2.5.x as I
am not going to use these machines. I can try any 2.4.x kernel.

Since I bought this motherboard for the ATA/133 support, it kind of sucks
that it doesn't seem to work well with Linux. Please CC me on any replies
as I am not subscribed to linux-kernel.

Thanks,
kitty.

Linux version 2.4.20-2.54smp (bhcompile@stripples.devel.redhat.com) (gcc version 3.2.2 20030217 (Red Hat Linux 8.0 3.2.2-2)) #1 SMP Sat Feb 22 08:11:49 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4d60
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 2
Kernel command line: ro root=LABEL=/ hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 2000.118 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 1026884k/1048512k available (1435k kernel code, 18044k reserved, 1070k data, 152k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 2400+ stepping 01
per-CPU timeslice cutoff: 731.38 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) MP stepping 01
Total of 2 processors activated (7982.28 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-11, 2-14, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 20.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 0FF 0F  0    0    0   0   0    1    1    39
 02 0FF 0F  0    0    0   0   0    1    1    31
 03 0FF 0F  0    0    0   0   0    1    1    41
 04 0FF 0F  0    0    0   0   0    1    1    49
 05 0FF 0F  0    0    0   0   0    1    1    51
 06 0FF 0F  0    0    0   0   0    1    1    59
 07 0FF 0F  0    0    0   0   0    1    1    61
 08 0FF 0F  0    0    0   0   0    1    1    69
 09 0FF 0F  0    0    0   0   0    1    1    71
 0a 0FF 0F  0    0    0   0   0    1    1    79
 0b 000 00  1    0    0   0   0    0    0    00
 0c 0FF 0F  0    0    0   0   0    1    1    81
 0d 0FF 0F  0    0    0   0   0    1    1    89
 0e 000 00  1    0    0   0   0    0    0    00
 0f 0FF 0F  0    0    0   0   0    1    1    91
 10 0FF 0F  1    1    0   1   0    1    1    99
 11 0FF 0F  1    1    0   1   0    1    1    A1
 12 0FF 0F  1    1    0   1   0    1    1    A9
 13 0FF 0F  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2000.0617 MHz.
..... host bus clock speed is 266.6745 MHz.
cpu: 0, clocks: 2666745, slice: 888915
CPU0<T0:2666736,T1:1777808,D:13,S:888915,C:2666745>
cpu: 1, clocks: 2666745, slice: 888915
CPU1<T0:2666736,T1:888896,D:10,S:888915,C:2666745>
checking TSC synchronization across CPUs: passed.
Starting migration thread for cpu 0
smp_num_cpus: 2.
Starting migration thread for cpu 1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfa260, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1022/700c] at 00:00.0
PCI->APIC IRQ transform: (B0,I7,P1) -> 17
PCI->APIC IRQ transform: (B1,I5,P0) -> 17
PCI->APIC IRQ transform: (B2,I0,P3) -> 19
PCI->APIC IRQ transform: (B2,I4,P0) -> 16
PCI->APIC IRQ transform: (B2,I7,P0) -> 16
PCI->APIC IRQ transform: (B2,I8,P0) -> 18
BIOS failed to enable PCI standards compliance, fixing this error.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
PDC20276: IDE controller at PCI slot 02:08.0
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
hdc: JLMS DVD-ROM LTD-166S, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
hde: Maxtor 6E040L0, ATA DISK drive
blk: queue c043aae0, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 6E040L0, ATA DISK drive
blk: queue c043af60, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xac00-0xac07,0xb002 on irq 18
ide3 at 0xb400-0xb407,0xb802 on irq 18
hde: host protected area => 1
hde: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=79656/16/63, UDMA(133)
hdg: host protected area => 1
hdg: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=79656/16/63, UDMA(133)
ide-floppy driver 0.99.newide
Partition check:
 hde: [PTBL] [4998/255/63] hde1 hde2
 hdg: [PTBL] [4998/255/63] hdg1
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 167k freed
VFS: Mounted root (ext2 filesystem).
LVM version 1.0.5+(22/07/2002) module loaded
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 152k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xf885c000, IRQ 19
usb-ohci.c: usb-02:00.0, Advanced Micro Devices [AMD] AMD-768 [Opus] USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,1), internal journal
loop: loaded (max 8 devices)
Adding Swap: 2097144k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-48246S        Rev: SS09
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
ip_tables: (C) 2000-2002 Netfilter core team
Intel(R) PRO/100 Network Driver - version 2.1.29-k2
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
divert: allocating divert_blk for eth0
e100: eth0: Intel(R) PRO/100+ Server Adapter
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: eth0 NIC Link is Up 100 Mbps Full duplex
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 128M @ 0xe8000000
Intel 810 + AC97 Audio, version 0.24, 08:22:01 Feb 22 2003
i810: AMD 768 found at IO 0xd400 and 0xd000, MEM 0x0000 and 0x0000, IRQ 17
i810_audio: Audio Controller supports 2 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7600 (SigmaTel STAC????)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 244x/48x writer cd/rw xa/form2 cdda tray
cdrom: This disc doesn't have any tracks I recognize!

lspci -vv

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at fc000000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at e000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-768 [Opus] Audio (rev 03)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at d000 [size=256]
	Region 1: I/O ports at d400 [size=64]

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: fa000000-fbffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QH [Radeon 8500] (rev 80) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc FireGL 8700
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at f9000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at fb025000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
	Subsystem: Creative Labs: Unknown device 8065
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at a000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
	Subsystem: Intel Corp. EtherExpress PRO/100 Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fb024000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at a800 [size=64]
	Region 2: Memory at fb000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:08.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01) (prog-if 85)
	Subsystem: Giga-byte Technology: Unknown device b001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at ac00 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at b400 [size=8]
	Region 3: I/O ports at b800 [size=4]
	Region 4: I/O ports at bc00 [size=16]
	Region 5: Memory at fb020000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

ver_linux

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux a129164.n1.vanderbilt.edu 2.4.20-2.54smp #1 SMP Sat Feb 22 08:11:49 EST 2003 i686 athlon i386 GNU/Linux
 
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.22
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         sr_mod i810_audio ac97_codec soundcore agpgart autofs e100 iptable_filter ip_tables ide-scsi scsi_mod ide-cd cdrom loop keybdev mousedev hid input usb-ohci usbcore ext3 jbd lvm-mod

.config


#

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_SMP is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_HOTPLUG=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_NR_CPUS=8
CONFIG_MAX_USER_RT_PRIO=100
CONFIG_MAX_RT_PRIO=0

#
# Busses
#

# CONFIG_MCA is not set
CONFIG_PCI=y
CONFIG_PCI_NAMES=y
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_H2999 is not set
CONFIG_HIGHIO=y

#
# PCMCIA/CardBus support
#
CONFIG_CARDBUS=y
CONFIG_I82365=y
CONFIG_I82092=y
CONFIG_TCIC=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
CONFIG_AMD_PM768=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_SERIAL=m
CONFIG_TIPAR=m

#
# Plug and Play configuration
#
# CONFIG_PNPBIOS is not set


#
# Block devices
#
CONFIG_BLK_STATS=y
CONFIG_BLK_DEV_FD=y
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m
CONFIG_PARIDE_BPCK6=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_PARIDE_EPATC8=y
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_UMEM=m


#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m
CONFIG_LVM_PROC_FS=m
CONFIG_BLK_DEV_DM=m


#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_TUX=m
CONFIG_TUX_EXTCGI=y
# CONFIG_TUX_EXTENDED_LOG is not set
# CONFIG_TUX_DEBUG is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_BNEP_MC_FILTER=y
CONFIG_BNEP_PROTO_FILTER=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y   
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
CONFIG_NETCONSOLE=m


#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_LOCAL=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m


#
#   IP_VS: IP Virtual Services support
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set

CONFIG_IP_VS_TAB_BITS=16

CONFIG_IP_VS_LC=m
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_FTP=m

CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPV6=m
CONFIG_IPV6_EUI64=y
CONFIG_IPV6_NO_PB=y           
# CONFIG_KHTTPD is not set

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m

CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IP6_NF_TARGET_LOG=m


CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_PPPOATM=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_BR2684=m
CONFIG_ATM_BR2684_IPFILTER=y

CONFIG_VLAN_8021Q=m

#
#  
#
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DECNET=m
CONFIG_DECNET_SIOCGIFCONF=y
CONFIG_DECNET_ROUTER=y
CONFIG_DECNET_ROUTE_FWMARK=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_NF=y
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
CONFIG_NET_DIVERT=y
# CONFIG_ECONET is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y


#
# Telephony Support
#
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m
CONFIG_PHONE_IXJ_PCMCIA=m

#
# ATA/IDE/MFM/RLL support
#

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_IDE=y
CONFIG_IDE_KNOWS=y
CONFIG_HAZARD_READ=y
# CONFIG_BLK_DEV_IDECD_BAILOUT is not set
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECD=m
#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_HPT=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_SII=m
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
CONFIG_BLK_DEV_IDETAPE=m


#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_SERVICE is not set
# CONFIG_PKT_TASK_IOCTL is not set
# CONFIG_IDE_TASK_IOCTL_DEBUG is not set
# CONFIG_IDE_TASKFILE_IO is not set

# CONFIG_WDC_ALI15X3 is not set
# CONFIG_AMD7409_OVERRIDE is not set
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_CENATEK=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_NFORCE=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_TRIFLEX=y

# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_CMD680=y
CONFIG_BLK_DEV_ADMA100=y

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CISS_SCSI_TAPE=y
CONFIG_CHR_DEV_OSST=m
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y

#
# SCSI low-level drivers
#
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
# CONFIG_AIC7XXX_PROC_STATS is not set
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_OLD_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_OLD_CMDS_PER_DEVICE=32
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=253
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_ENABLE_RD_STRM=y
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_SCSI_MEGARAID=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
CONFIG_SCSI_EATA_MAX_TAGS=16
# CONFIG_SCSI_GENERIC_NCR53C400 is not set
CONFIG_SCSI_G_NCR5380_PORT=y
# CONFIG_SCSI_G_NCR5380_MEM is not set
CONFIG_SCSI_IPS=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C7xx_sync is not set
CONFIG_SCSI_NCR53C7xx_FAST=y
CONFIG_SCSI_NCR53C7xx_DISCONNECT=y
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
CONFIG_SCSI_NCR53C8XX_SYNC=40
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLOGIC_QLA2100=m
CONFIG_FC_QLA2200=m
CONFIG_FC_QLA2300=m
# CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
CONFIG_SCSI_NEWISP=m
CONFIG_SCSI_SEAGATE=m
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=m
CONFIG_SCSI_ISCSI=m
CONFIG_SCSI_NSP32=m

#
# PCMCIA SCSI adapter support
#
CONFIG_SCSI_PCMCIA=y
CONFIG_PCMCIA_QLOGIC=m

#
# Fusion MPT device support
#
# CONFIG_FUSION_BOOT is not set

#
# (ability to boot linux kernel from Fusion device is DISABLED!)
#
# CONFIG_FUSION_ISENSE is not set
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m
CONFIG_FUSION_MAX_SGE=40

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394_PCILYNX is not set
# CONFIG_IEEE1394_PCILYNX_LOCALRAM is not set
CONFIG_IEEE1394_PCILYNX_PORTS=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y



#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m
CONFIG_SCSI_DPT_I2O=m


#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
CONFIG_APPLETALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_LTPC=m
CONFIG_COPS=m
CONFIG_COPS_DAYNA=y
CONFIG_COPS_TANGENT=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_SB1000=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_EWRK3=m
CONFIG_3C359=m
CONFIG_3C515=m
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
CONFIG_BC90X=m
CONFIG_LANCE=m
CONFIG_AMD8111_ETH=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
CONFIG_ULTRA=m
CONFIG_ULTRA32=m
CONFIG_SMC9194=m
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=m
CONFIG_NI52=m
CONFIG_NI65=m
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_NET_ISA=y
CONFIG_E2100=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_SK_G16=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PM is not set
CONFIG_LNE390=m
CONFIG_LP486E=m
CONFIG_FEALNX=m
CONFIG_E100=m
CONFIG_NATSEMI=m
# CONFIG_NATSEMI_CABLE_MAGIC is not set
CONFIG_NE2K_PCI=m
CONFIG_NE3210=m
CONFIG_ES3210=m
CONFIG_8139TOO=m
CONFIG_R8169=m
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_8139CP=m
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_NEW_RX_RESET is not set
# CONFIG_8139TOO_PIO is not set
CONFIG_RTL8129=m
CONFIG_SIS900=m
CONFIG_SIS900_OLD=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_SUNDANCE_MMIO=y
CONFIG_SUNGEM=m
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_WINBOND_840=m
CONFIG_HAPPYMEAL=m
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m
# CONFIG_LAN_SAA9730 is not set
CONFIG_TC35815=m


#
# Ethernet (1000 Mbit)
#
CONFIG_E1000=m
CONFIG_ACENIC=m
CONFIG_TIGON3=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_HAMACHI=m
CONFIG_NS83820=m
CONFIG_YELLOWFIN=m
CONFIG_NET_BROADCOM=m
CONFIG_DL2K=m
CONFIG_SK98LIN=m
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
# CONFIG_SYNCLINKMP is not set
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Wireless LAN (non-hamradio)
#
CONFIG_CIPE=m
CONFIG_NET_RADIO=y
CONFIG_STRIP=m
CONFIG_WAVELAN=m
CONFIG_ARLAN=m
CONFIG_AIRONET4500=m
CONFIG_AIRONET4500_NONCS=m
CONFIG_AIRONET4500_PNP=y
CONFIG_AIRONET4500_PCI=y
CONFIG_AIRONET4500_ISA=y
CONFIG_AIRONET4500_I365=y
CONFIG_AIRONET4500_PROC=m
CONFIG_AIRO=m
CONFIG_AIRO_CS=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_PCI_HERMES=m


#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_TMSISA=m
CONFIG_ABYSS=m
CONFIG_SMCTR=m
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
CONFIG_RCPCI=m
CONFIG_SHAPER=m

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_HOSTESS_SV11=m
CONFIG_COSA=m
CONFIG_FARSYNC=m
CONFIG_ATI_XX20=m
CONFIG_SYNCLINK_CS=m
# CONFIG_COMX is not set
# CONFIG_LANMEDIA is not set
CONFIG_SEALEVEL_4021=m
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_HDLC is not set
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
CONFIG_WAN_ROUTER_DRIVERS=y
CONFIG_VENDOR_SANGOMA=m
CONFIG_WANPIPE_CARDS=4
CONFIG_WANPIPE_CHDLC=y
CONFIG_WANPIPE_PPP=y
CONFIG_WANPIPE_FR=y
CONFIG_WANPIPE_X25=y
CONFIG_WANPIPE_MULTPPP=y
CONFIG_CYCLADES_SYNC=m
CONFIG_CYCLOMX_X25=y
# CONFIG_LAPBETHER is not set
# CONFIG_X25_ASY is not set
CONFIG_SBNI=m
CONFIG_SBNI_MULTILINE=y

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m
# CONFIG_ARCNET_COM20020_CS is not set
CONFIG_PCMCIA_IBMTR=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_NETWAVE=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_PCMCIA_WVLAN=m
CONFIG_PCMCIA_HERMES=m
CONFIG_PCMCIA_HERMES_OLD=m
CONFIG_AIRONET4500_CS=m
# CONFIG_AIRONET4800_CS is not set

#
# ATM drivers
#
CONFIG_ATM_TCP=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_ZATM_EXACT_TS=y
CONFIG_ATM_NICSTAR=m
CONFIG_ATM_NICSTAR_USE_SUNI=y
CONFIG_ATM_NICSTAR_USE_IDT77105=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_FORE200E=m
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set


#
# Amateur Radio support
#
CONFIG_HAMRADIO=m

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_OPTIONS=y

#
#   IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# FIR device drivers
#
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_MCP2120_DONGLE=m
CONFIG_ACT200L_DONGLE=m
CONFIG_MA600_DONGLE=m
CONFIG_TOSHIBA_OLD=m

#
# ISDN subsystem
#
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=m
# CONFIG_ISDN_DIVERSION is not set

#
# low-level hardware drivers
#

#
# Passive ISDN cards
#
CONFIG_ISDN_DRV_HISAX=m
CONFIG_HISAX_DEBUG=y
CONFIG_HISAX_ENTERNOW_PCI=m
#
#   D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_NI1=y

#
#   HiSax supported cards
#
CONFIG_HISAX_16_0=y
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_AVM_A1=y
CONFIG_HISAX_AVM_A1_CS=m
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_FRITZ_PCIPNP=m
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_ELSA_CS=m
CONFIG_HISAX_IX1MICROR2=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_ASUSCOM=y
CONFIG_HISAX_TELEINT=y
CONFIG_HISAX_HFCS=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_SEDLBAUER_CS=m
CONFIG_HISAX_SPORTSTER=y
CONFIG_HISAX_MIC=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_ISURF=y
CONFIG_HISAX_HSTSAPHIR=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_ST5481=y
CONFIG_HISAX_MAX_CARDS=8

#
# Active ISDN cards
#
CONFIG_ISDN_DRV_ICN=m
CONFIG_ISDN_DRV_PCBIT=m
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
CONFIG_ISDN_DRV_EICON=m
CONFIG_ISDN_DRV_EICON_DIVAS=m
# CONFIG_ISDN_DRV_EICON_OLD is not set
CONFIG_ISDN_DRV_EICON_PCI=m
# CONFIG_ISDN_DRV_EICON_ISA is not set
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_ISDN_CAPI_CAPIDRV=m
CONFIG_ISDN_DRV_AVMB1_B1ISA=m
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=m
CONFIG_ISDN_DRV_AVMB1_T1ISA=m
CONFIG_ISDN_DRV_AVMB1_AVM_CS=m
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_ISDN_DRV_TPAM=m

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_GAMEPORT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_STINGER=m
CONFIG_INPUT_CS461X=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_ANALOG=m
CONFIG_INPUT_INTERACT=m
CONFIG_INPUT_WARRIOR=m 
CONFIG_INPUT_EMU10K1=m
CONFIG_INPUT_SERIO=m

#
# Character devices
#
# CONFIG_CD_NO_IDESCSI is not set
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_ECC=m
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
CONFIG_SERIAL_MULTIPORT=y
# CONFIG_HUB6 is not set
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_DIGI=m
CONFIG_ESPSERIAL=m
# CONFIG_DSCC4 is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_SYNCLINK=m
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
CONFIG_SPECIALIX_RTSCTS=y
CONFIG_SX=m
# CONFIG_RIO is not set
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_MWAVE=m
CONFIG_SONYPI=m
CONFIG_CRYPTO=m
CONFIG_CRYPTO_AEP=m
CONFIG_BATTERY_GERICOM=m
CONFIG_CIPHERS=m
CONFIG_CRYPTODEV=m
CONFIG_CIPHER_AES=m
CONFIG_CIPHER_IDENTITY=m
CONFIG_CRYPTOLOOP=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_MAINBOARD=y
CONFIG_I2C_AMD756=m
CONFIG_I2C_I801=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_ALI1535=m
# CONFIG_I2C_TSUNAMI is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_ISA=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Hardware sensors support
#
CONFIG_SENSORS=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_OTHER=y
CONFIG_SENSORS_BT869=m
CONFIG_SENSORS_DDCMON=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_LTC1710=m
CONFIG_SENSORS_MATORB=m
CONFIG_SENSORS_ADM1024=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCPOS=m
CONFIG_SENSORS_FSCSCY=m
CONFIG_SENSORS_MAXILIFE=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_MTP008=m

#
# Mice
#
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_MK712_MOUSE=m


#
# Joysticks
#
CONFIG_INPUT_NS558=m
CONFIG_INPUT_LIGHTNING=m
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_A3D=m
CONFIG_INPUT_ADI=m
CONFIG_INPUT_COBRA=m
CONFIG_INPUT_GF2K=m 
CONFIG_INPUT_GRIP=m
CONFIG_INPUT_TMDC=m
CONFIG_INPUT_SIDEWINDER=m
CONFIG_INPUT_SERPORT=m
CONFIG_INPUT_SPACEORB=m
CONFIG_INPUT_MAGELLAN=m
CONFIG_INPUT_SPACEBALL=m
CONFIG_INPUT_IFORCE_232=m
CONFIG_INPUT_IFORCE_USB=m
CONFIG_INPUT_DB9=m
CONFIG_INPUT_GAMECON=m
CONFIG_INPUT_TURBOGRAFX=m


#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDT=m
CONFIG_WDTPCI=m
CONFIG_ADVANTECH_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_PCWATCHDOG=m
CONFIG_W83877F_WDT=m
CONFIG_ACQUIRE_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_SC520_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_WAFER_WDT=m
CONFIG_SC1200_WDT=m
CONFIG_ALIM1535_WDT=m
# CONFIG_60XX_WDT is not set
# CONFIG_MIXCOMWD is not set
CONFIG_I810_TCO=m
CONFIG_AMD7XX_TCO=m
CONFIG_INTEL_RNG=m
CONFIG_AMD_RNG=m
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

#
#   The compressor will be built as a module only!
#
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
# CONFIG_FT_PROC_FS is not set
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0

CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_AMD_8151=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_I810=m
# CONFIG_DRM_I810_XFREE_41 is not set
CONFIG_DRM_I830=m
CONFIG_DRM_MGA=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_SIS=m
# CONFIG_DRM41_SIS is not set
CONFIG_PCMCIA_SERIAL=m

#
# PCMCIA character device support
#
CONFIG_PCMCIA_SERIAL_CS=m
CONFIG_PCMCIA_SERIAL_CB=m

#
# Multimedia devices
#

#
# Video For Linux
#
CONFIG_I2C_PARPORT=m


#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_W9966=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_BUZ=m
CONFIG_VIDEO_ZORAN_DC10=m
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_BUZ=m
CONFIG_VIDEO_ZR36120=m
CONFIG_VIDEO_W9966=m
# CONFIG_VIDEO_MARGI is not set
# CONFIG_VIDEO_LS220 is not set

#
# Radio Adapters
#
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=m
CONFIG_RADIO_RTRACK2=m
CONFIG_RADIO_AZTECH=m
CONFIG_RADIO_GEMTEK=m
CONFIG_RADIO_GEMTEK_PCI=m
CONFIG_RADIO_MAESTRO=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MIROPCM20=m
CONFIG_RADIO_MIROPCM20_RDS=m
CONFIG_RADIO_SF16FMI=m
CONFIG_RADIO_SF16FMR2=m
CONFIG_RADIO_TERRATEC=m
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
CONFIG_RADIO_TYPHOON_PROC_FS=y
CONFIG_RADIO_ZOLTRIX=m


#
# File systems
#
CONFIG_FS_POSIX_ACL=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y

# CONFIG_QIFACE_COMPAT is not set
CONFIG_AFS_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_BFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_SWAPFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=y
CONFIG_ZISOFS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_JFS_FS=m
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_CMS_FS=m
CONFIG_EXT3_FS=m
CONFIG_EXT3_INDEX=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_XATTR_SHARING=y
CONFIG_EXT3_FS_XATTR_USER=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_BUFFER_DEBUG is not set
# CONFIG_SYSV_FS_WRITE is not set
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_SIMICSFS is not set
# CONFIG_DDFS is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_DIRECTIO=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_TCP is not set
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_VXFS_FS=m
CONFIG_SMB_FS=m
CONFIG_MORE_UNNAMED_MAJORS=y
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_INTERMEZZO_FS=m


#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y   
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_LDM_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_UTF8=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_KOI8_U=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_VIDEO_IGNORE_BAD_MODE is not set
CONFIG_MDA_CONSOLE=m

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_E1355 is not set
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_PM2_PCI=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=m
CONFIG_FB_HGA=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_G100A=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_MULTIHEAD=y
# CONFIG_FB_MATROX_PROC is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_ATY_GX=y 
CONFIG_FB_ATY_CT=y 
CONFIG_FB_ATY_CT_VAIO_LCD=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_RADEON=m
CONFIG_FB_VOODOO1=m
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_HGA=m
CONFIG_FB_PM3=m
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m
CONFIG_SOUND_CMPCI=m
CONFIG_SOUND_CMPCI_SPDIFLOOP=y
CONFIG_SOUND_CMPCI_4CH=y
CONFIG_SOUND_CMPCI_REAR=y
CONFIG_SOUND_CMPCI_FM=y
CONFIG_SOUND_CMPCI_MIDI=y
CONFIG_SOUND_CMPCI_JOYSTICK=y
CONFIG_SOUND_CMPCI_CM8738=y
CONFIG_SOUND_CMPCI_MPUIO=330
CONFIG_SOUND_CMPCI_SPEAKERS=2
# CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_SOUND_AUDIGY=m
CONFIG_MIDI_EMU10K1=m
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_FORTE=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_MSNDCLAS=m
# CONFIG_MSNDCLAS_HAVE_BOOT is not set
CONFIG_MSNDCLAS_INIT_FILE="/etc/sound/msndinit.bin"
CONFIG_MSNDCLAS_PERM_FILE="/etc/sound/msndperm.bin"
CONFIG_SOUND_MSNDPIN=m
# CONFIG_MSNDPIN_HAVE_BOOT is not set
CONFIG_MSNDPIN_INIT_FILE="/etc/sound/pndspini.bin"
CONFIG_MSNDPIN_PERM_FILE="/etc/sound/pndsperm.bin"
CONFIG_SOUND_VIA82CXXX=m
# CONFIG_SOUND_VIA82CXXX_PROCFS is not set
CONFIG_MIDI_VIA82CXXX=y
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_AD1889=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_ALI5455=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_ICH=m
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
CONFIG_MAD16_OLDCARD=y
CONFIG_SOUND_PAS=m
# CONFIG_PAS_JOYSTICK is not set
CONFIG_SOUND_PSS=m
# CONFIG_PSS_MIXER is not set
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_SOUND_YMFPCI_LEGACY=y
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
CONFIG_SC6600=y
CONFIG_SC6600_JOY=y
CONFIG_SC6600_CDROM=4
CONFIG_SC6600_CDROMBASE=0
CONFIG_AEDSP16_SBPRO=y
CONFIG_AEDSP16_MPU401=y
CONFIG_SOUND_TVMIXER=m
CONFIG_SOUND_RME96XX=m


#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
CONFIG_USB_LONG_TIMEOUT=y
# CONFIG_USB_LARGE_CONFIG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
CONFIG_USB_EHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_SDDR55=y

CONFIG_USB_HPUSBSCSI=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDDEV=m
CONFIG_USB_HIDINPUT=m

# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_WACOM=m
CONFIG_USB_AIPTEK=m
CONFIG_USB_BRLVGER=m

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HP5300=m
# CONFIG_USB_ID75 is not set


#
# USB Multimedia devices
#
CONFIG_USB_IBMCAM=m
CONFIG_USB_OV511=m
CONFIG_USB_DSBR=m
CONFIG_USB_DABUSB=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m
CONFIG_USB_VICAM=m
# CONFIG_USB_EMI26 is not set
CONFIG_USB_MIDI=m


#
# USB Network adaptors
#
CONFIG_USB_PLUSB=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_KAWETH=m
CONFIG_USB_CATC=m
CONFIG_USB_NET1080=m
CONFIG_USB_USBNET=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_RTL8150=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_KLSI=m
#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m

CONFIG_USB_TIGL=m


#
# USB misc drivers
#
CONFIG_USB_RIO500=m
CONFIG_USB_IRDA=m
CONFIG_USB_LCD=m
CONFIG_USB_POWERMATE=m


#
# USB Bluetooth
#
CONFIG_BLUEZ=m
CONFIG_BLUEZ_L2CAP=m
CONFIG_BLUEZ_HCIUSB=m
CONFIG_BLUEZ_HCIUART=m
CONFIG_BLUEZ_HCIEMU=m
CONFIG_BLUEZ_HCIVHCI=m
CONFIG_BLUEZ_SCO=m
CONFIG_BLUEZ_USB_FW_LOAD=m
CONFIG_BLUEZ_USB_ZERO_PACKET=m
CONFIG_BLUEZ_HCIUART_H4=m
CONFIG_BLUEZ_HCIDTL1=m
CONFIG_BLUEZ_BNEP=m
CONFIG_BLUEZ_HCIBLUECARD=m
CONFIG_BLUEZ_HCIBT3C=m
CONFIG_BLUEZ_RFCOMM=m
CONFIG_BLUEZ_BNEP_MC_FILTER=m
CONFIG_BLUEZ_BNEP_PROTO_FILTER=m
CONFIG_BLUEZ_HCIUART_BCSP=m
CONFIG_BLUEZ_HCIBTUART=m
CONFIG_BLUEZ_RFCOMM_TTY=m
CONFIG_BLUEZ_HCIUART_BCSP_TXCRC=m

#
# Linux ABI
#
CONFIG_ABI=m 
CONFIG_ABI_SVR4=m
CONFIG_ABI_IBCS=m
CONFIG_ABI_IBCS_SCO=y
CONFIG_ABI_IBCS_ISC=y
CONFIG_ABI_IBCS_WYSE=y
# CONFIG_ABI_XENIX is not set
CONFIG_ABI_UW7=m
# CONFIG_ABI_SOLARIS is not set
CONFIG_ABI_ISC=m
CONFIG_ABI_SCO=m
# CONFIG_ABI_SCO_UTSNAME_HACK is not set
# CONFIG_ABI_WYSE is not set

CONFIG_BINFMT_XOUT=m
# CONFIG_BINFMT_XOUT_X286 is not set
# CONFIG_ABI_VERBOSE_ERRORS is not set

#
# Addon drivers
#
CONFIG_MEGARAC=m

#
# Speakup for Section 508 stuff
#
CONFIG_SPEAKUP=m
CONFIG_SPEAKUP_ACNTSA=y
CONFIG_SPEAKUP_ACNTPC=y
CONFIG_SPEAKUP_APOLO=y
CONFIG_SPEAKUP_AUDPTR=y
CONFIG_SPEAKUP_BNS=y
CONFIG_SPEAKUP_DECTLK=y
CONFIG_SPEAKUP_DECEXT=y
CONFIG_SPEAKUP_DTLK=y
CONFIG_SPEAKUP_LTLK=y
CONFIG_SPEAKUP_SPKOUT=y
CONFIG_SPEAKUP_TXPRT=y
CONFIG_SPEAKUP_DEFAULT=none
# CONFIG_SPEAKUP_KEYMAP is not set


#
# Kernel hacking
#
# CONFIG_SMALL is not set
CONFIG_KERNEL_DEBUG=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_LOLAT=y
# CONFIG_LOLAT_SYSCTL is not set
# CONFIG_BLK_DEV_ELEVATOR_NOOP is not set
# CONFIG_HIGHMEM_EMULATION is not set
# CONFIG_NET_PKTGEN is not set
# CONFIG_IKCONFIG is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_OPROFILE=m
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_PANIC_MORSE=y
# CONFIG_PROFILING is not set
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MK7=y
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_PGE=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_TOSHIBA=m
CONFIG_I8K=m
CONFIG_MICROCODE=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_SMP is not set
# CONFIG_MXT is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_X86_IO_APIC=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_E820_PROC is not set
# CONFIG_3GB is not set
# CONFIG_2GB is not set
CONFIG_1GB=y
CONFIG_MTRR=y
# CONFIG_MULTIQUAD is not set
# CONFIG_VISWS is not set
CONFIG_SONYPI=m
CONFIG_VIDEO_MEYE=m
CONFIG_X86_MCE=y
CONFIG_NR_CPUS=8
# CONFIG_X86_LONGRUN is not set
# CONFIG_CPU_FREQ_24_API is not set
# CONFIG_SCx200 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_EDD=m
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m
# CONFIG_X86_NUMA is not set
# CONFIG_X86_TSC_DISABLE is not set
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_EISA=y
CONFIG_HZ=100
CONFIG_PCMCIA=m
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_COFF=m
# CONFIG_ACPI is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BUSMGR=m
CONFIG_ACPI_SYS=m
CONFIG_ACPI_CPU=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_EC=m
CONFIG_ACPI_CMBATT=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_RELAXED_AML=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_XD=m
CONFIG_PARIDE=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_TUX=m
CONFIG_NETLINK=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y         
CONFIG_ATM=y
CONFIG_ATM_NICSTAR=m
CONFIG_ATM_IA=m
CONFIG_WAN_ROUTER=m
CONFIG_NET_SCHED=y
CONFIG_DM9102=m
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_ISAPNP=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_AEC62XX_TUNING=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD7409=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_SD=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=4
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_LOGGING=y
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_PCMCIA_APA1480=m
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_AIC7XXX_OLD_PROC_STATS=y
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_IN2000=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_CPQFCTS=m
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_DTC3280=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_DMA=m
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_GENERIC_NCR5380=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_NCR53C7xx=m
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_SYNC=40
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PCI2000=m
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PCI2220I=m
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
CONFIG_SCSI_SIM710=m
CONFIG_SCSI_SYM53C416=m
CONFIG_SCSI_DC390T=m
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
CONFIG_SCSI_DEBUG=m
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_FUSION=m
CONFIG_IEEE1394=m
CONFIG_ISDN=m
CONFIG_ISDN_DRV_EICON=m
CONFIG_ISDN_DRV_EICON_DIVAS=m
# CONFIG_ISDN_DRV_EICON_OLD is not set
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_I2C=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_HYDRA=m
CONFIG_I2C_I810=m
CONFIG_BUSMOUSE=m
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m
CONFIG_JOYSTICK=m
CONFIG_HAMRADIO=m
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
# CONFIG_DMASCC is not set
# CONFIG_SCC is not set
# CONFIG_BAYCOM_SER_FDX is not set
# CONFIG_BAYCOM_SER_HDX is not set
# CONFIG_BAYCOM_PAR is not set
# CONFIG_BAYCOM_EPP is not set
CONFIG_SOUNDMODEM=m
CONFIG_SOUNDMODEM_SBC=y
CONFIG_SOUNDMODEM_WSS=y
CONFIG_SOUNDMODEM_AFSK1200=y
CONFIG_SOUNDMODEM_AFSK2400_7=y
CONFIG_SOUNDMODEM_AFSK2400_8=y
CONFIG_SOUNDMODEM_AFSK2666=y
CONFIG_SOUNDMODEM_HAPN4800=y
CONFIG_SOUNDMODEM_PSK4800=y
CONFIG_SOUNDMODEM_FSK9600=y
# CONFIG_YAM is not set
CONFIG_WATCHDOG=y
# CONFIG_WDT_501 is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_R3964=m
CONFIG_FTAPE=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_PMS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_INPUT_SERIO=m
CONFIG_BATTERY_GERICOM=m
CONFIG_FB_RIVA=m
CONFIG_FB_CLGEN=m
CONFIG_FB_PM2=m
CONFIG_FB_SIS=m
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G450 is not set
CONFIG_FB_ATY=m
CONFIG_FB_ATY128=m
CONFIG_FB_3DFX=m
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
CONFIG_ECC=m
CONFIG_CRYPTO=m
CONFIG_CRYPTO_BROADCOM=m
CONFIG_CRYPTO_AEP=m
CONFIG_MEGARAC=m
CONFIG_X86_POWERNOW_K6=m
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_LONGHAUL_SCALE_VOLTAGE is not set
CONFIG_X86_SPEEDSTEP=m
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_ELAN_CPUFREQ is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_MK7=y
CONFIG_X86_PGE=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
CONFIG_UNIX98_PTY_COUNT=2048
# CONFIG_PROFILING is not set
