Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbREIUeI>; Wed, 9 May 2001 16:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbREIUd5>; Wed, 9 May 2001 16:33:57 -0400
Received: from Sarah.SomeSites.com ([208.44.57.7]:55557 "HELO
	MoveAlong.SomeSites.com") by vger.kernel.org with SMTP
	id <S131563AbREIUdm>; Wed, 9 May 2001 16:33:42 -0400
Message-ID: <000b01c0d8c7$57495890$0100a8c0@SomeSites.com>
From: "James Turinsky (LKML)" <lkml@SomeSites.com>
To: <linux-kernel@vger.kernel.org>
Subject: Unable to re-enable DMA after DMA timeout (why?)
Date: Wed, 9 May 2001 16:33:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is what happens after several days running with either the kernel
activating DMA or activating it manually (hdparm -d1 /dev/hda) in at
least
2.4.2 through 2.4.5-ac5:

hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x80 { Busy }
hda: DMA disabled
ide0: reset: success

Issuing hdparm -d1 /dev/hda at this point causes a short period of
system unresponsiveness which ends with the following:

hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
ide0: reset: success

Here is the drive info:

hdparm -iI /dev/hda

/dev/hda:

 Model=IBM-DTTA-371010, FwRev=T77OA73A, SerialNo=WL0WLF36394
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=465kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=19746720
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3
ATA-4


 Model=BI-MTDAT3-1710 0                        , FwRev=7TO77AA3,
SerialNo=
  W 0LLW3F3649
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=465kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=19746720
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 udma0 udma1 udma2
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3
ATA-4

Here is the controller info:

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20262
(rev 01)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at f4f0 [size=8]
        Region 1: I/O ports at fc88 [size=4]
        Region 2: I/O ports at f4f8 [size=8]
        Region 3: I/O ports at fc8c [size=4]
        Region 4: I/O ports at fcc0 [size=64]
        Region 5: Memory at fcfe0000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

I also see this on the onboard controller

00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX]
(rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II] (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at fc90 [size=16]

I distinctly remember being able to re-enable DMA after the DMA timeout
in 2.2.x. What gives?



