Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267150AbSLQV6g>; Tue, 17 Dec 2002 16:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267151AbSLQV6g>; Tue, 17 Dec 2002 16:58:36 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:48844 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267150AbSLQV6d> convert rfc822-to-8bit; Tue, 17 Dec 2002 16:58:33 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Markus1108Wagner@t-online.de (Markus Wagner)
To: linux-kernel@vger.kernel.org
Subject: No booting with a Silicon Image 3112 SATA-Controller
Date: Tue, 17 Dec 2002 23:07:44 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212172307.44339.520087183254-0001@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got a PCI SATA-Controller with the SiI 3112 Chipset. I tried to get it 
running with 

2.4.19-ac4-ide ( from linux-ide.org )
2.4.20-ac1 and -ac2.

The support for the controller is compiled directly into the kernel.

Since I dont have a SATA-HDD, I am using a SATA to PATA dongle with an IBM 
DTLA 307030 HDD.

When booting the 2.4.20-ac1/-ac2 kernel, the boot process stops at 

VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed

with no further action.

With Kernel 2.4.19-ac4-ide the system booted and crashed shortly after.

I tried the "ide=reveresed" kernel option with all kernels used.

Some info about my system:
MoBo: ECS Elitegroup K7S5A with AMD Athlon C 1400 ( SiS 735 Chipset )
The HDD ( IBM DTLA-307030 ) works without failure when using the onboard 
Controller.

I tried to remove the network and the sound card to get a unique interrupt for 
the controller but that didn't change things.

This is the Screen-Output when booting 2.4.20-ac2:
...
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS735    ATA 100 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
SiI3112 Serial ATA: IDE controller at PCI slot 00:0b.0
PCI: Found IRQ 5 for device 00:0b.0
PCI: Sharing IRQ 5 with 00:11.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA at 0xe280ee00-0xe280ee07, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xe280ee08-0xe280ee0f, BIOS settings: hdg:pio, hdh:pio
hdc: CREATIVECD-RW RW121032E, ATAPI CD/DVD-ROM drive
hdd: CREATIVE CD5233E, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307030, ATA DISK drive
hde: DMA disabled
hdg: no response (status = 0xfe)
    ide2 at 0xe280ee80-0xe280ee87, 0xe280ee8a on IRQ 5
hde: host protected area => 1
hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed

Output of scripts/ver_linux:

Linux jupiter 2.4.20-ac2 #2 Die Dez 17 21:08:28 EST 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
e2fsprogs              1.27
reiserfsprogs          3.x.0j
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sr_mod emu10k1 ac97_codec sound soundcore agpgart 
nvidia natsemi ide-scsi scsi_mod ide-cd cdrom

cat /proc/pci ( with HDD on oboard IDE) :
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 1).
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (rev 0).
      Master Capable.  Latency=64.  Min Gnt=10.
  Bus  0, device   2, function  0:
    ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 0).
  Bus  0, device   2, function  5:
    IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).
      Master Capable.  Latency=128.
      I/O at 0xff00 [0xff0f].
  Bus  0, device  11, function  0:
    Unknown mass storage controller: PCI device 1095:3112 (CMD Technology Inc) 
(rev 1).
      IRQ 5.
      Master Capable.  Latency=64.
      I/O at 0xd800 [0xd807].
      I/O at 0xd400 [0xd403].
      I/O at 0xd000 [0xd007].
      I/O at 0xcc00 [0xcc03].
      I/O at 0xc800 [0xc80f].
      Non-prefetchable 32 bit memory at 0xcffffe00 [0xcfffffff].
  Bus  0, device  15, function  0:
    Ethernet controller: National Semiconductor Corporation DP83815 
(MacPhyter) Ethernet Controller (rev 0).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=11.Max Lat=52.
      I/O at 0xc400 [0xc4ff].
      Non-prefetchable 32 bit memory at 0xcfffe000 [0xcfffefff].
  Bus  0, device  17, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 8).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=20.
      I/O at 0xc000 [0xc01f].
  Bus  0, device  17, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 8).
      Master Capable.  Latency=64.
      I/O at 0xdc00 [0xdc07].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev 
161).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xce000000 [0xceffffff].
      Prefetchable 32 bit memory at 0xc0000000 [0xc7ffffff].

Hope you can make use of this

best regards,

Markus Wagner

