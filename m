Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312986AbSDLAzx>; Thu, 11 Apr 2002 20:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313132AbSDLAzw>; Thu, 11 Apr 2002 20:55:52 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:54481 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312986AbSDLAzu>; Thu, 11 Apr 2002 20:55:50 -0400
Message-Id: <5.1.0.14.2.20020412014716.01f7aec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 12 Apr 2002 01:56:10 +0100
To: martin@dalecki.de
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: VIA and 2.5.8-pre kernels doesn't boot!
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20020412001029.GA1172@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For me 2.5.8-pre2 and -pre3 (-pre1 not tested) both fail to boot on my VIA 
chipset box. 2.5.7 works fine.

Best regards,

         Anton

2.5.8-pre3 prints on serial console and then it just dies:
----snip----
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
VIA Technologies, Inc. Bus Master IDE: IDE controller on PCI slot 00:07.1
VIA Technologies, Inc. Bus Master IDE: chipset revision 6
VIA Technologies, Inc. Bus Master IDE: not 100% native mode: will probe 
irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVER07-0, ATA DISK drive
----snip----

2.5.7 works fine and this is the relevant part from the boot sequence output:
----snip----
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
VIA Technologies, Inc. Bus Master IDE: IDE controller on PCI slot 00:07.1
VIA Technologies, Inc. Bus Master IDE: chipset revision 6
VIA Technologies, Inc. Bus Master IDE: not 100% native mode: will probe 
irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVER07-0, ATA DISK drive
hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive
hdd: Maxtor 90288D2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c04984cc, I/O limit 4095Mb (mask 0xffffffff)
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
blk: queue c0498d20, I/O limit 4095Mb (mask 0xffffffff)
hdd: 5627664 sectors (2881 MB) w/256KiB Cache, CHS=5583/16/63, UDMA(33)
Partition check:
  hda: [PTBL] [5005/255/63] hda1 hda2 < hda5 hda6 hda7 >
  hdd: [PTBL] [697/128/63] hdd1 hdd2 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: LITE-ON   Model: LTR-12102B        Rev: NS1D
   Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
----snip----

/proc/ide/via shows on 2.5.7:
----snip----
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
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA      UDMA
Address Setup:       30ns     120ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      30ns
Cycle Time:          20ns     600ns     120ns      60ns
Transfer Rate:   99.9MB/s   3.3MB/s  16.6MB/s  33.3MB/s
---snip---

and lspci -xvv output on 2.5.7:
---snip---

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 8
         Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: <available only to root>
00: 06 11 05 03 06 00 10 22 03 00 00 06 00 08 00 00
10: 08 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 
[Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: d2000000-d4ffffff
         Prefetchable memory behind bridge: d0000000-d1ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: <available only to root>
00: 06 11 05 83 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 00 d2 f0 d4 00 d0 f0 d1 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
         Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: <available only to root>
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 
06) (prog-if 8a [Master SecP PriP])
         Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at d000 [size=16]
         Capabilities: <available only to root>
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) 
(prog-if 00 [UHCI])
         Subsystem: Unknown device 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 5
         Region 4: I/O ports at d400 [size=32]
         Capabilities: <available only to root>
00: 06 11 38 30 07 00 10 02 16 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 04 00 00

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) 
(prog-if 00 [UHCI])
         Subsystem: Unknown device 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 5
         Region 4: I/O ports at d800 [size=32]
         Capabilities: <available only to root>
00: 06 11 38 30 07 00 10 02 16 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 04 00 00

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
         Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9
         Capabilities: <available only to root>
00: 06 11 57 30 00 00 90 02 40 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 57 30
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
[Apollo Super AC97/Audio] (rev 50)
         Subsystem: VIA Technologies, Inc.: Unknown device 4511
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 12
         Region 0: I/O ports at dc00 [size=256]
         Region 1: I/O ports at e000 [size=4]
         Region 2: I/O ports at e400 [size=4]
         Capabilities: <available only to root>
00: 06 11 58 30 01 00 10 02 50 00 01 04 00 00 00 00
10: 01 dc 00 00 01 e0 00 00 01 e4 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 11 45
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0c 03 00 00

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] 
(rev 78)
         Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC 
Management NIC
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at e800 [size=128]
         Region 1: Memory at d6100000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: <available only to root>
00: b7 10 00 92 07 00 10 02 78 00 00 02 08 20 00 00
10: 01 e8 00 00 00 00 10 d6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 0a 0a

00:0b.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus 
DVD Decoder (rev 02)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=1M]
         Capabilities: <available only to root>
00: 05 11 00 83 06 00 10 02 02 00 80 04 00 20 00 00
10: 00 00 00 d6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
04) (prog-if 00 [VGA])
         Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (4000ns min, 8000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=32M]
         Region 1: Memory at d2000000 (32-bit, non-prefetchable) [size=16K]
         Region 2: Memory at d3000000 (32-bit, non-prefetchable) [size=8M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: <available only to root>
00: 2b 10 25 05 07 00 90 02 04 00 00 03 08 20 00 00
10: 08 00 00 d0 00 00 00 d2 00 00 00 d3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 79 21
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 10 20


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

