Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278081AbRKHULx>; Thu, 8 Nov 2001 15:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278050AbRKHULf>; Thu, 8 Nov 2001 15:11:35 -0500
Received: from [202.73.165.5] ([202.73.165.5]:384 "EHLO maravillo.q-linux.com")
	by vger.kernel.org with ESMTP id <S278085AbRKHUL0>;
	Thu, 8 Nov 2001 15:11:26 -0500
Date: Fri, 9 Nov 2001 04:11:12 +0800
From: Mike Maravillo <mike.maravillo@q-linux.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac8 vs. 2.4.15-pre1 VIA IDE tests
Message-ID: <20011109041112.A1914@maravillo.q-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Q Linux Solutions, Inc.
X-Accepted-File-Formats: ASCII .rtf .ps - *NO* MS Office files please
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disk reads on my box have always hovered around ~5.x MB/sec with
kernels <= 2.4.13-ac8.  I'm curious what resulted to the big
difference in hdparm results below.  Both kernels were compiled
with the same configs.

2.4.13-ac8:

 Timing buffer-cache reads:   128 MB in  2.62 seconds = 48.85 MB/sec
 Timing buffered disk reads:  64 MB in 11.73 seconds =  5.46 MB/sec

 Timing buffer-cache reads:   128 MB in  2.65 seconds = 48.30 MB/sec
 Timing buffered disk reads:  64 MB in 11.75 seconds =  5.45 MB/sec

2.4.15-pre1:

 Timing buffer-cache reads:   128 MB in  2.49 seconds = 51.41 MB/sec
 Timing buffered disk reads:  64 MB in  4.70 seconds = 13.62 MB/sec

 Timing buffer-cache reads:   128 MB in  2.53 seconds = 50.59 MB/sec
 Timing buffered disk reads:  64 MB in  4.84 seconds = 13.22 MB/sec

# lspci -vvvxxx
[...]
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 10 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00
40: 03 e2 08 3a 6c 13 c0 00 20 20 a8 20 30 00 20 20
50: 0f 07 0b e0 04 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00

80: 00 20 5f 01 00 00 00 00 00 00 00 00 00 00 00 00 <<== 2.4.13-ac8

80: 00 c0 73 0f 00 00 00 00 00 00 00 00 00 00 00 00 <<== 2.4.15-pre1

90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 10 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# hdparm /dev/hda
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2434/255/63, sectors = 39102336, start = 0

# hdparm -i /dev/hda
 Model=ST320413A, FwRev=3.39, SerialNo=7ED05MNS
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=39102336
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4

# cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xd000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       DMA       DMA       DMA
Address Setup:       30ns     120ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      30ns
Cycle Time:          30ns     600ns     120ns     120ns
Transfer Rate:   66.0MB/s   3.3MB/s  16.5MB/s  16.5MB/s

-- 
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/
