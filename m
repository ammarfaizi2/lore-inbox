Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSBHXEG>; Fri, 8 Feb 2002 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287827AbSBHXDz>; Fri, 8 Feb 2002 18:03:55 -0500
Received: from www.formation.com ([209.204.114.130]:5135 "EHLO
	formail.formation.com") by vger.kernel.org with ESMTP
	id <S287817AbSBHXDk>; Fri, 8 Feb 2002 18:03:40 -0500
From: "Steve Snyder" <steves@formation.com>
To: <linux-kernel@vger.kernel.org>
Subject: Why won't my HD do DMA I/O?
Date: Fri, 8 Feb 2002 18:00:50 -0600
Message-ID: <KMEBIOGPEGOACPDOHPEEKEAKCAAA.steves@formation.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a system on which the hard disk cannot be set to use DMA.  When I
attempt to enable DMA ("hdparm -d1 /dev/hda") on this drive, there is a long
time-out period, after which displaying the settings shows that DMA is still
not set.

This is totally inexplicable to me because a) the manufacturer offers a
Win95 driver for this machine that allegedly enables DMA for HD I/O, and b)
I used this same hard disk in another machine and was able to run it with
DMA I/O.  So if the chipset can handle DMA and the HD can handle DMA, then
what is the $#%@^! problem here?

The machine is a Dell Latitude XPi CD P150ST
(http://docs.us.dell.com/docs/systems/ptcd/Specs.htm).  The PCI bus is
running at 30MHz and I have informed the kernel of that fact (see below).

The software is RedHat v7.2 with the v2.4.17 kernel.  The version of hdparm
is 4.1.

So... anyone know what the problem is with Linux and this hardware?

Thanks.

-------------------

# hdparm -i /dev/hda

/dev/hda:

 Model=FUJITSU MHC2040AT, FwRev=0818, SerialNo=01124560
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=7944/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=8
 CurCHS=7944/16/63, CurSects=796917882, LBA=yes, LBAsects=8007552
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3

-------------------

Linux version 2.4.17 (root@mars.snydernet.lan) (gcc version 2.96 20000731
(Red H
at Linux 7.1 2.96-98)) #1 Wed Jan 30 22:56:47 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
On node 0 totalpages: 12288
zone(0): 4096 pages.
zone(1): 8192 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda2 idebus=30
ide_setup: idebus=30
Initializing CPU#0
Detected 150.345 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 299.00 BogoMIPS
Memory: 46536k/49152k available (876k kernel code, 2232k reserved, 191k
data, 19
2k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb83e, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1066/8002] at 00:06.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Starting kswapd
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 30MHz system bus speed for PIO modes
CMD643: IDE controller on PCI bus 00 dev 40
CMD643: chipset revision 0
CMD643: not 100% native mode: will probe irqs later
CMD643: simplex device: DMA forced
    ide0: BM-DMA at 0xfe00-0xfe07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfe08-0xfe0f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MHC2040AT, ATA DISK drive
hdc: CD-ROM CDR-N16D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8007552 sectors (4100 MB), CHS=993/128/63
Partition check:
 hda: hda1 hda2 hda3

--------------------

