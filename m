Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315232AbSEaMiX>; Fri, 31 May 2002 08:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315235AbSEaMiW>; Fri, 31 May 2002 08:38:22 -0400
Received: from [194.233.250.58] ([194.233.250.58]:34820 "EHLO
	mail.fillmore-labs.com") by vger.kernel.org with ESMTP
	id <S315232AbSEaMiU> convert rfc822-to-8bit; Fri, 31 May 2002 08:38:20 -0400
Message-ID: <00d901c208a0$0bd9ae00$fa82a8c0@atlantis>
From: "Oliver Eikemeier" <eikemeier@fillmore-labs.com>
To: "\"linux-kernel mailing list\"" <linux-kernel@vger.kernel.org>
Subject: via ide udma & ibm hd freezes kernel
Date: Fri, 31 May 2002 14:38:20 +0200
Organization: Fillmore Labs GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using SuSE Linux 8.0 with a 2.4.18 kernel, and a machine with a VIA vt82c686b southbridge. The system runs very stable with only one (Western Digital) hard disk on ide bus 0, but when I add a second (IBM) hard disk configured as slave, the kernel freezes when I'm accessing the second disk (after *some accesses, i.e. when I can copy 10 small files on it, it freezes on the third). I read the mailing list, lost of people seem to have problems with this configuration, but most advices are to change the cable, which I did.

Symptoms are: the hard disk LED is on, the machine freezes (no blinking cursor on the text console, no remote access) or the caps lock & scroll lock LEDs on the keyboard flash, same lockup.

I had the same problems with FreeBSD:

"UDMA ICRC error writing fsbn 127590847 of 63795392-63795423 (ad1s1 bn 1275908 47; cn 7942 tn 41 sn 34) retrying"

and I could get the system stable by switching to udma33, so I tried the same on linux:

> hdparm -c1 -m16 -X66 -d1 /dev/hda
> hdparm -c1 -m16 -X66 -d1 /dev/hdb

but the kernel still hangs. Maybe someone can point me to a solution, please CC: me personally, because I'm not subscribed to this list.

Thanks
    Oliver

> dmesg

[...]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD200EB-00CSF0, ATA DISK drive
hdb: IC35L080AVVA07-0, ATA DISK drive
hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c033ce24, I/O limit 4095Mb (mask 0xffffffff)
hda: safely enabled flush
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
blk: queue c033cf74, I/O limit 4095Mb (mask 0xffffffff)
hdb: safely enabled flush
hdb: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=10011/255/63, UDMA(100)
hdc: no flushcache support
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
[...]

> cat /proc/ide/via

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.34
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA       PIO       PIO
Address Setup:       30ns      30ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns     330ns
Data Recovery:       30ns      30ns      30ns     270ns
Cycle Time:          60ns      60ns     120ns     600ns
Transfer Rate:   33.3MB/s  33.3MB/s  16.6MB/s   3.3MB/s

> lspci -vvxxx

[...]
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00
40: 0b 02 09 35 1c 1c c0 00 a8 20 20 20 03 00 20 20
50: 03 07 e4 e4 34 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 a0 77 07 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[...]

> hdparm -vi /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2434/255/63, sectors = 39102336, start = 0

 Model=WDC WD200EB-00CSF0, FwRev=04.01B04, SerialNo=WD-WMAAV2466224
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=39102336
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5

> hdparm -vi /dev/hdb

/dev/hdb:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 10011/255/63, sectors = 160836480, start = 0

 Model=IC35L080AVVA07-0, FwRev=VA4OA50K, SerialNo=VNC402A4C6WUPA
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=160836480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5
 Kernel Drive Geometry LogicalCHS=10011/255/63 PhysicalCHS=159560/16/63



