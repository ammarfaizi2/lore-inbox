Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265345AbUBEQDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbUBEQDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:03:54 -0500
Received: from sccimhc02.asp.att.net ([63.240.76.164]:56289 "EHLO
	sccimhc02.asp.att.net") by vger.kernel.org with ESMTP
	id S265345AbUBEQC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:02:57 -0500
From: Steve Snyder <lkml0205.20.swsnyder@spamgourmet.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Can't do HD DMA on CMD643 chipset.  Help!
Date: Thu, 5 Feb 2004 11:02:29 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402051102.29015.lkml0205.20.swsnyder@spamgourmet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About once a year I get a bug up my butt about the the inability of Linux to 
do DMA on my CMD643 IDE chipset.  Now it's that magical time of year again.  

I've got a system on which the hard disk cannot be set to use DMA.  When I 
attempt to enable DMA ("hdparm -d1 /dev/hda") on this drive, there is a long 
time-out period, after which displaying the settings shows that DMA is still 
not set.  

This is totally inexplicable to me because a) the manufacturer offered a 
Win95 driver for this machine that allegedly enabled DMA for HD I/O, and b) 
I used this same hard disk in another machine and was able to run it with 
DMA I/O.  So if the chipset can handle DMA and the HD can handle DMA, then 
what is the $#%@^!  problem here?  

The machine is a Dell Latitude XPi CD P150ST 
(http://support.jp.dell.com/docs/systems/ptcd/Specs.htm).  The PCI bus is 
running at 30MHz and I have informed the kernel of that fact (see below).  

The software is RedHat v7.3 with the v2.4.24 kernel. The version of hdparm
is 4.6.

I see this same behavior with either Red Hat's current (2.4.20-28.7) kernel 
or the plain-vanilla kernel (2.4.24) configured and build myself (see some 
grep'd config excerpts below).

Any advice that might help me get this problem resolved this 
year would be greatly appreciated.

Thanks.

----------

# grep CMD linux-2.4.24/.config
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_CMD64X=y

# grep DMA linux-2.4.24/.config
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set

----------

# hdparm -i /dev/hda

/dev/hda:

 Model=HITACHI_DK23EA-20, FwRev=00K5A0A3, SerialNo=DC3492
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=8
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39070080
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 3 : ATA-2 ATA-3 ATA-4 ATA-5


# hdparm -i /dev/hdc

/dev/hdc:

 Model=CD-ROM CDR-N16D, FwRev=1.40, SerialNo=
 Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:227,w/IORDY:180}, tDMA={min:150,rec:150}
 PIO modes: pio0 pio1 pio2 pio3
 DMA modes: sdma0 sdma1 *sdma2 mdma0 *mdma1
 AdvancedPM=no

----------

A snippet of "lspci -vv" output:

00:08.0 IDE interface: CMD Technology Inc PCI0643 (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 14
        Region 4: I/O ports at fe00 [size=16]

----------
helios syslogd 1.4.1: restart.
helios syslog: syslogd startup succeeded
helios kernel: klogd 1.4.1, log source = /proc/kmsg started.
helios kernel: Linux version 2.4.23 (root@helios.snydernet.lan)(gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)) #1 Tue Dec 2 01:21:12 PST 2003
helios kernel: BIOS-provided physical RAM map:
helios kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
helios kernel:  BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
helios kernel: 48MB LOWMEM available.
helios kernel: On node 0 totalpages: 12288
helios kernel: zone(0): 4096 pages.
helios kernel: zone(1): 8192 pages.
helios kernel: zone(2): 0 pages.
helios kernel: DMI not present.
helios kernel: Kernel command line: ro root=/dev/hda1 idebus=30
helios syslog: klogd startup succeeded
helios kernel: ide_setup: idebus=30
helios kernel: Initializing CPU#0
helios kernel: Detected 150.346 MHz processor.
helios kernel: Console: colour VGA+ 80x25
helios kernel: Calibrating delay loop... 299.00 BogoMIPS
helios kernel: Memory: 46528k/49152k available (1042k kernel code, 2240k reserved, 389k data, 72k init, 0k highmem)
helios kernel: Dentry cache hash table entries: 8192 (order: 4,65536 bytes)
helios kernel: Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
helios kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
helios kernel: Buffer cache hash table entries: 1024 (order: 0,4096 bytes)
helios kernel: Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
helios kernel: Intel Pentium with F0 0F bug - workaround enabled.
helios kernel: CPU: Intel Pentium 75 - 200 stepping 0c
helios kernel: Checking 'hlt' instruction... OK.
helios kernel: POSIX conformance testing by UNIFIX
helios kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb83e, last bus=0
helios kernel: PCI: Using configuration type 1
helios kernel: PCI: Probing PCI hardware
helios kernel: PCI: Probing PCI hardware (bus 00)
helios kernel: PCI: Using IRQ router default [1066/8002] at 00:06.0
helios kernel: Linux NET4.0 for Linux 2.4
helios kernel: Based upon Swansea University Computer Society NET3.039
helios kernel: Initializing RT netlink socket
helios kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version1.16)
helios kernel: Starting kswapd
helios kernel: Journalled Block Device driver loaded
helios kernel: pty: 256 Unix98 ptys configured
helios kernel: Real Time Clock Driver v1.10e
helios kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
helios kernel: ide: Assuming 30MHz system bus speed for PIO modes
helios kernel: CMD643: IDE controller at PCI slot 00:08.0
helios kernel: CMD643: chipset revision 0
helios kernel: CMD643: not 100%% native mode: will probe irqs later
helios kernel: CMD643: simplex device: DMA forced
helios kernel:     ide0: BM-DMA at 0xfe00-0xfe07, BIOS settings:hda:pio, hdb:pio
helios kernel:     ide1: BM-DMA at 0xfe08-0xfe0f, BIOS settings:hdc:pio, hdd:pio
helios kernel: hda: HITACHI_DK23EA-20, ATA DISK drive
helios kernel: hdc: CD-ROM CDR-N16D, ATAPI CD/DVD-ROM drive
helios kernel: hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
helios kernel: hdc: set_drive_speed_status: error=0x04
helios kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
helios kernel: ide1 at 0x170-0x177,0x376 on irq 15
helios kernel: hda: attached ide-disk driver.
helios kernel: hda: host protected area => 1
helios kernel: hda: 39070080 sectors (20004 MB) w/2048KiB Cache,CHS=2432/255/63
helios kernel: Partition check:
helios kernel:  hda: hda1 hda2 hda3
helios kernel: Linux Kernel Card Services 3.1.22
helios kernel:   options:  [pci] [cardbus] [pm]
helios kernel: PCI: No IRQ known for interrupt pin A of device 00:09.0. Please try using pci=biosirq.
helios kernel: PCI: No IRQ known for interrupt pin B of device 00:09.1. Please try using pci=biosirq.
helios kernel: Intel ISA PCIC probe: not found.
helios kernel: NET4: Linux TCP/IP 1.0 for NET4.0
helios kernel: IP Protocols: ICMP, UDP, TCP
helios kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
helios kernel: TCP: Hash tables configured (established 4096 bind 8192)
helios kernel: ip_conntrack version 2.1 (384 buckets, 3072 max)- 292 bytes per conntrack
helios kernel: ip_tables: (C) 2000-2002 Netfilter core team
helios kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
helios kernel: Yenta IRQ list 0ed8, PCI irq0
helios kernel: Socket status: 30000010
helios kernel: Yenta IRQ list 0ed8, PCI irq0
helios kernel: Socket status: 30000010
helios kernel: kjournald starting.  Commit interval 5 seconds
helios kernel: EXT3-fs: mounted filesystem with ordered data mode.
helios kernel: VFS: Mounted root (ext3 filesystem) readonly.
helios kernel: Freeing unused kernel memory: 72k freed
helios kernel: Adding Swap: 80316k swap-space (priority -1)
helios kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1),internal journal
helios kernel: kjournald starting.  Commit interval 5 seconds
helios keytable: Loading keymap:  succeeded
helios kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3),internal journal
helios kernel: EXT3-fs: mounted filesystem with ordered data mode.
helios kernel: hdc: attached ide-cdrom driver.
helios kernel: hdc: ATAPI 6X CD-ROM drive, 32768kB Cache
helios kernel: Uniform CD-ROM driver Revision: 3.12
helios kernel: hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
helios kernel: hdc: set_drive_speed_status: error=0x04
helios kernel: hdc: DMA disabled
helios keytable: Loading system font:  succeeded
helios random: Initializing random number generator:  succeeded
helios pcmcia: Starting PCMCIA services:
helios pcmcia:  cardmgr.
helios cardmgr[613]: starting, version is 3.1.22
helios rc: Starting pcmcia:  succeeded
helios cardmgr[613]: config error, file './config.opts' line 8:no function bindings
helios cardmgr[613]: watching 2 sockets
helios kernel: cs: IO port probe 0x0c00-0x0cff: clean.
helios kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x230-0x23f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x3f8-0x3ff
helios kernel: cs: IO port probe 0x0a00-0x0aff: clean.
helios cardmgr[613]: initializing socket 0
helios kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
helios cardmgr[613]: socket 0: 3Com 572/574 Fast Ethernet
helios kernel: eth0: 3C574-TX Fast EtherLink PC Card at io 0x300, irq 3, hw_addr 00:60:08:B6:3D:FC.
helios kernel:   ASIC rev 1, 64K FIFO split 1:1 Rx:Tx, autoselect MII interface.
helios cardmgr[613]: executing: './network start eth0'
helios /etc/hotplug/net.agent: invoke ifup eth0
helios cardmgr[613]: initializing socket 1
helios cardmgr[613]: socket 1: 3Com 3c562/3c563 Ethernet/Modem
helios cardmgr[613]: executing: './network start eth1'
helios kernel: eth1: 3Com 3c562, io 0x320, irq 9, hw_addr 00:60:97:ED:E8:72
helios kernel:   8K FIFO split 5:3 Rx:Tx, auto xcvr
helios netfs: Mounting other filesystems:  succeeded

