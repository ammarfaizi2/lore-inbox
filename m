Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTESTJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTESTJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:09:09 -0400
Received: from ip-66-80-37-197.chi.megapath.net ([66.80.37.197]:10756 "HELO
	srvr1.mousebusiness.com") by vger.kernel.org with SMTP
	id S262856AbTESTGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:06:54 -0400
Message-ID: <20030519191814.3000.qmail@srvr1.mousebusiness.com>
From: "kernel" <kernel@mousebusiness.com>
To: linux-kernel@vger.kernel.org
Subject: Promise SX6000 No handler for event
Date: Mon, 19 May 2003 14:18:14 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for the length of this message. From reading prior posts 
related to this problem, it appears that it might be a good idea that I 
include all the below info.
What am I doing wrong? Where should I look for more info to solve this? How 
did others solve this? I think I've tried the same setup others have tried, 
but still I run into problems. 

Any help greatly appreciated. 

Artur 

Running RedHat 9.0 on dual Athlon MP Tyan S2466 mobo. 

It appears that having SMP kernel complicates things even further, so right 
now I am running kernel compiled withot SMP support. 

Using kernel 2.4.20 with i2o modules:
# I2O device support
CONFIG_I2O=y
CONFIG_I2O_PCI=y
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=y 

Grub configured to not probe Promise controllers:
title Red Hat Linux (2.4.20I20_f)
       root (hd0,0)
       kernel /boot/vmlinuz-2.4.20I20_f ro root=/dev/hda1 noapic nousb 
hdc=ide-scsi ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe 
ide6=noprobe ide7=noprobe
       initrd /boot/initrd-2.4.20I20_f.img 

[root@production raid]# lsmod
Module                  Size  Used by    Not tainted
nfs                    57364   1  (autoclean)
lockd                  44848   1  (autoclean) [nfs]
sunrpc                 81628   1  (autoclean) [nfs lockd]
i2o_block              38848   1
3c59x                  29232   1
af_packet              11400   0  (autoclean)
ide-scsi               10480   0
scsi_mod               98964   1  [ide-scsi]
rtc                     8444   0  (autoclean)
unix                   17800  10  (autoclean) 

Mounted the array in the filesystem:
/dev/i2o/hda1 on /mnt/raid type ext3 (rw) 

I am getting the following in /var/log/messages:
May 19 13:03:39 production kernel: I2O Block Storage OSM v0.9
May 19 13:03:39 production kernel:    (c) Copyright 1999-2001 Red Hat 
Software. May 19 13:03:39 production kernel: i2o_block: registered device at 
major 80
May 19 13:03:39 production kernel: i2o_block: Checking for Boot device...
May 19 13:03:39 production kernel: i2o_block: Checking for I2O Block 
devices... May 19 13:03:39 production kernel: i2ob: Installing tid 11 device 
at unit 0
May 19 13:03:39 production kernel: i2o/hda: Max segments 28, queue depth 8, 
byte limit 49152.
May 19 13:03:39 production kernel: i2o/hda: Type 130: 621795MB, 512 byte 
sectors.
May 19 13:03:39 production kernel: i2o/hda: Maximum sectors/read set to 96.
May 19 13:03:39 production kernel:  i2o/hda: i2o/hda1
May 19 13:04:12 production kernel: kjournald starting.  Commit interval 5 
seconds
May 19 13:04:12 production kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
i2o_block(80,1), internal journal
May 19 13:04:12 production kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
May 19 13:05:59 production kernel: i2o/iop0: No handler for event 
(0x00000020)
May 19 13:05:59 production kernel: i2o/iop0: No handler for event 
(0x00000020)
May 19 13:06:04 production kernel: i2o/iop0: Hardware Failure: Unknown Error
May 19 13:06:09 production kernel: i2o/iop0: No handler for event 
(0x00000020)
May 19 13:06:09 production last message repeated 8 times
May 19 13:06:09 production kernel: i2o/iop0: Hardware Failure: Unknown Error
May 19 13:06:43 production last message repeated 12 times
and so on.... 

[root@production raid]# lspci -v
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller (rev 11)
       Flags: bus master, 66Mhz, medium devsel, latency 64
       Memory at f6000000 (32-bit, prefetchable) [size=32M]
       Memory at f4400000 (32-bit, prefetchable) [size=4K]
       I/O ports at 1010 [disabled] [size=4]
       Capabilities: [a0] AGP version 2.0 

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP 
Bridge (prog-if 00 [Normal decode])
       Flags: bus master, 66Mhz, medium devsel, latency 99
       Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
       I/O behind bridge: 00002000-00002fff
       Memory behind bridge: f4000000-f40fffff
       Prefetchable memory behind bridge: f8000000-fbffffff 

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
       Flags: bus master, 66Mhz, medium devsel, latency 0 

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 
04) (prog-if 8a [Master SecP PriP])
       Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
       Flags: bus master, medium devsel, latency 0
       I/O ports at f000 [size=16] 

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
       Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
       Flags: medium devsel 

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) 
(prog-if 00 [Normal decode])
       Flags: bus master, 66Mhz, medium devsel, latency 64
       Bus: primary=00, secondary=02, subordinate=03, sec-latency=168
       I/O behind bridge: 00003000-00003fff
       Memory behind bridge: f4100000-f41fffff
       Prefetchable memory behind bridge: fc000000-fc3fffff 

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 
4x TMDS (prog-if 00 [VGA])
       Subsystem: PC Partner Limited: Unknown device 7106
       Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, 
latency 66, IRQ 11
       Memory at f8000000 (32-bit, prefetchable) [size=64M]
       I/O ports at 2000 [size=256]
       Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
       Expansion ROM at <unassigned> [disabled] [size=128K]
       Capabilities: [50] AGP version 2.0
       Capabilities: [5c] Power Management version 2 

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 
07) (prog-if 10 [OHCI])
       Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
       Flags: bus master, medium devsel, latency 64, IRQ 10
       Memory at f4100000 (32-bit, non-prefetchable) [size=4K] 

02:04.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 02) (prog-if 00 
[Normal decode])
       Flags: bus master, medium devsel, latency 64
       Bus: primary=02, secondary=03, subordinate=03, sec-latency=64 

02:04.1 I2O: Intel Corp. 80960RM [i960RM Microprocessor] (rev 02) (prog-if 
01)
       Subsystem: Promise Technology, Inc. SuperTrak SX6000 I2O CPU
       Flags: bus master, medium devsel, latency 64, IRQ 5
       Memory at fc000000 (32-bit, prefetchable) [size=4M]
       Expansion ROM at <unassigned> [disabled] [size=64K] 

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
78)         Subsystem: Tyan Computer: Unknown device 2466
       Flags: bus master, medium devsel, latency 80, IRQ 10
       I/O ports at 3000 [size=128]
       Memory at f4101000 (32-bit, non-prefetchable) [size=128]
       Expansion ROM at <unassigned> [disabled] [size=128K]
       Capabilities: [dc] Power Management version 2
03:00.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01) 
(prog-if 85)
       Subsystem: Promise Technology, Inc. SuperTrak SX6000 IDE
       Flags: bus master, 66Mhz, slow devsel, latency 128, IRQ 14
       I/O ports at <ignored> [size=8]
       I/O ports at <ignored> [size=4]
       I/O ports at <ignored> [size=8]
       I/O ports at <ignored> [size=4]
       I/O ports at <ignored> [size=16]
       Memory at <ignored> (32-bit, non-prefetchable) [size=16K]
       Capabilities: [60] Power Management version 1 

03:01.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01) 
(prog-if 85)
       Subsystem: Promise Technology, Inc. SuperTrak SX6000 IDE
       Flags: bus master, 66Mhz, slow devsel, latency 128, IRQ 14
       I/O ports at <ignored> [size=8]
       I/O ports at <ignored> [size=4]
       I/O ports at <ignored> [size=8]
       I/O ports at <ignored> [size=4]
       I/O ports at <ignored> [size=16]
       Memory at <ignored> (32-bit, non-prefetchable) [size=16K]
       Capabilities: [60] Power Management version 1 

03:02.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01) 
(prog-if 85)
       Subsystem: Promise Technology, Inc. SuperTrak SX6000 IDE
       Flags: bus master, 66Mhz, slow devsel, latency 128, IRQ 14
       I/O ports at <ignored> [size=8]
       I/O ports at <ignored> [size=4]
       I/O ports at <ignored> [size=8]
       I/O ports at <ignored> [size=4]
       I/O ports at <ignored> [size=16]
       Memory at <ignored> (32-bit, non-prefetchable) [size=16K]
       Capabilities: [60] Power Management version 1 

[root@production raid]# lspci -t
 -[00]-+-00.0
     +-01.0-[01]----05.0
     +-07.0
     +-07.1
     +-07.3
     \-10.0-[02-03]--+-00.0
                     +-04.0-[03]--+-00.0
                     |            +-01.0
                     |            \-02.0
                     +-04.1
                     \-08.0 

[root@production raid]# dmesg
Linux version 2.4.20I20_f (root@production) (gcc version 3.2.2 20030222 (Red 
Hat Linux 3.2.2-5)) #2 Wed May 7 10:44:12 CDT 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000003ff80000 (usable)
BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
BIOS-e820: 00000000fec00000 - 00000000fec04000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262016
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32640 pages.
Kernel command line: ro root=/dev/hda1 noapic nousb hdc=ide-scsi 
ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe ide6=noprobe 
ide7=noprobe
ide_setup: hdc=ide-scsi
ide_setup: ide2=noprobe
ide_setup: ide3=noprobe
ide_setup: ide4=noprobe
ide_setup: ide5=noprobe
ide_setup: ide6=noprobe
ide_setup: ide7=noprobe
Initializing CPU#0
Detected 1666.767 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3329.22 BogoMIPS
Memory: 1033472k/1048064k available (1128k kernel code, 14200k reserved, 
444k data, 80k init, 130560k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) MP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd7e0, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
PCI: Cannot allocate resource region 0 of device 03:00.0
PCI: Cannot allocate resource region 1 of device 03:00.0
PCI: Cannot allocate resource region 2 of device 03:00.0
PCI: Cannot allocate resource region 3 of device 03:00.0
PCI: Cannot allocate resource region 4 of device 03:00.0
PCI: Cannot allocate resource region 5 of device 03:00.0
PCI: Cannot allocate resource region 0 of device 03:01.0
PCI: Cannot allocate resource region 1 of device 03:01.0
PCI: Cannot allocate resource region 2 of device 03:01.0
PCI: Cannot allocate resource region 3 of device 03:01.0
PCI: Cannot allocate resource region 4 of device 03:01.0
PCI: Cannot allocate resource region 5 of device 03:01.0
PCI: Cannot allocate resource region 0 of device 03:02.0
PCI: Cannot allocate resource region 1 of device 03:02.0
PCI: Cannot allocate resource region 2 of device 03:02.0
PCI: Cannot allocate resource region 3 of device 03:02.0
PCI: Cannot allocate resource region 4 of device 03:02.0
PCI: Cannot allocate resource region 5 of device 03:02.0
PCI: Failed to allocate resource 0(0-7) for 03:00.0
PCI: Failed to allocate resource 1(0-3) for 03:00.0
PCI: Failed to allocate resource 2(0-7) for 03:00.0
PCI: Failed to allocate resource 3(0-3) for 03:00.0
PCI: Failed to allocate resource 4(0-f) for 03:00.0
PCI: Failed to allocate resource 5(0-3fff) for 03:00.0
PCI: Failed to allocate resource 0(0-7) for 03:01.0
PCI: Failed to allocate resource 1(0-3) for 03:01.0
PCI: Failed to allocate resource 2(0-7) for 03:01.0
PCI: Failed to allocate resource 3(0-3) for 03:01.0
PCI: Failed to allocate resource 4(0-f) for 03:01.0
PCI: Failed to allocate resource 5(0-3fff) for 03:01.0
PCI: Failed to allocate resource 0(0-7) for 03:02.0
PCI: Failed to allocate resource 1(0-3) for 03:02.0
PCI: Failed to allocate resource 2(0-7) for 03:02.0
PCI: Failed to allocate resource 3(0-3) for 03:02.0
PCI: Failed to allocate resource 4(0-f) for 03:02.0
PCI: Failed to allocate resource 5(0-3fff) for 03:02.0
BIOS failed to enable PCI standards compliance, fixing this error.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: detected chipset, but driver not compiled in!
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
   ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
   ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
PDC20276: IDE controller on PCI bus 03 dev 00
PCI: Device 03:00.0 not available because of resource collisions
PCI: Device 03:00.0 not available because of resource collisions
PDC20276: (ide_setup_pci_device:) Could not enable device.
PDC20276: IDE controller on PCI bus 03 dev 08
PCI: Device 03:01.0 not available because of resource collisions
PCI: Device 03:01.0 not available because of resource collisions
PDC20276: (ide_setup_pci_device:) Could not enable device.
PDC20276: IDE controller on PCI bus 03 dev 10
PCI: Device 03:02.0 not available because of resource collisions
PCI: Device 03:02.0 not available because of resource collisions
PDC20276: (ide_setup_pci_device:) Could not enable device.
hda: MAXTOR 6L080J4, ATA DISK drive
hdc: YAMAHA CRW2200E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63
Partition check:
hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 7
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
AMD756: dev 8086:1962, router pirq : 1 get irq :  5
PCI: Found IRQ 5 for device 02:04.1
i2o: I2O controller on bus 2 at 33.
i2o: PCI I2O controller at 0xFC000000 size=4194304
I2O: Promise workarounds activated.
i2o/iop0: Installed at IRQ5
i2o: 1 I2O controller found and installed.
Activating I2O controllers...
This may take a few minutes if there are many devices
i2o/iop0: Reset rejected, trying to clear
i2o/iop0: LCT has 10 entries.
i2o/iop0: Configuration dialog desired.
I2O configuration manager v 0.04.
 (C) Copyright 1999 Red Hat Software
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 80k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Real Time Clock Driver v1.10e
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
Adding Swap: 1048816k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
 Vendor: YAMAHA    Model: CRW2200E          Rev: 1.0B
 Type:   CD-ROM                             ANSI SCSI revision: 02
AMD756: dev 10b7:9200, router pirq : 4 get irq : 10
PCI: Found IRQ 10 for device 02:08.0
PCI: Sharing IRQ 10 with 02:00.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:08.0: 3Com PCI 3c905C Tornado at 0x3000. Vers LK1.1.16
spurious 8259A interrupt: IRQ7.
I2O Block Storage OSM v0.9
  (c) Copyright 1999-2001 Red Hat Software.
i2o_block: registered device at major 80
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2ob: Installing tid 11 device at unit 0
i2o/hda: Max segments 28, queue depth 8, byte limit 49152.
i2o/hda: Type 130: 621795MB, 512 byte sectors.
i2o/hda: Maximum sectors/read set to 96.
i2o/hda: i2o/hda1
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on i2o_block(80,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: Hardware Failure: Unknown Error
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: No handler for event (0x00000020)
i2o/iop0: Hardware Failure: Unknown Error
i2o/iop0: Hardware Failure: Unknown Error
and so on.... 

