Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264308AbRFDPHN>; Mon, 4 Jun 2001 11:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264304AbRFDOz1>; Mon, 4 Jun 2001 10:55:27 -0400
Received: from tangens.hometree.net ([212.34.181.34]:42471 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S263733AbRFDOzP>; Mon, 4 Jun 2001 10:55:15 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: IDE Driver 05042001 / 2.2.19  /proc display problems?
Date: Mon, 4 Jun 2001 14:55:13 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9fg7gh$avm$1@forge.intermeta.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 991666513 31023 212.34.181.4 (4 Jun 2001 14:55:13 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 4 Jun 2001 14:55:13 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a P200MMX System based on the VIA 82Cxxxx Chipset. The box
works fine and stable.

I run a custom built 2.2.19 kernel which contains the ide.05042001 driver
with the following settings (only the IMHO relevant):

CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDE_CHIPSETS=y


The system tells me at boot time:

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307060, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: IBM-DTLA-307060, 58644MB w/1916kB Cache, CHS=7943/240/63, UDMA(33)

so the disk is (as far as I can understand) activated in UDMA(33).

The /proc/ide/hda/settings seems to underline this:

name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                7943            0               65535           rw
bios_head               240             0               255             rw
bios_sect               63              0               63              rw
io_32bit                1               0               3               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw

but the VIA driver tells me (/proc/ide/via):

% cat /proc/ide/via 
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c586a
Revision:                           ISA 0x27 IDE 0x6
BM-DMA base:                        0xfcf1
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       30ns      90ns      90ns      90ns
Cmd Active:          90ns      90ns     480ns     480ns
Cmd Recovery:        30ns      30ns     480ns     480ns
Data Active:         90ns     180ns     180ns     180ns
Data Recovery:       30ns     450ns     450ns     450ns
Cycle Time:          60ns     630ns     630ns     630ns
Transfer Rate:   33.0MB/s   3.1MB/s   3.1MB/s   3.1MB/s

Transfer Mode:  PIO ???

The timing and the Transfer Rate seem to suggest, that this is just a
display error. (The disk also 'feels' fast; much faster than with the
stock 2.2.19-6.2.1 kernel from RedHat)

hdparm also suggests DMA:

% hdparm -i /dev/hda
/dev/hda:

 Model=IBM-DTLA-307060, FwRev=TX8OA50C, SerialNo=YQDYQFP3181
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=17475/15/63, CurSects=-78446341, LBA=yes, LBAsects=120103200
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
 Drive Supports : Reserved : ATA-2 ATA-3 ATA-4 ATA-5 
 Kernel Drive Geometry LogicalCHS=7943/240/63 PhysicalCHS=127093/15/63

So is this simply a display bug or do I have to worry?

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
