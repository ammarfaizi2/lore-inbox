Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284746AbRLPSrp>; Sun, 16 Dec 2001 13:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284751AbRLPSrh>; Sun, 16 Dec 2001 13:47:37 -0500
Received: from ppp1181-cwdsl-paris.fr.cw.net ([62.210.116.157]:32384 "EHLO
	rafale.worldnet.fr") by vger.kernel.org with ESMTP
	id <S284746AbRLPSrU>; Sun, 16 Dec 2001 13:47:20 -0500
Subject: AIC7XXX never work with a 2940 Ultra2 on my computer
From: Emmanuel =?ISO-8859-1?Q?Fust=E9?= <fuste@worldnet.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 16 Dec 2001 20:00:50 +0100
Message-Id: <1008529250.527.15.camel@rafale>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear kernel hackers, 

During the last six months I tried to get an adaptec 2940U2W to work in
my computer without success. 
I have a 2940UW witch work pretty well, but if I swap it with a 2940U2W
I got : 
Dec 14 22:11:46 rafale kernel: scsi1: PCI error Interrupt at seqaddr =
0x180 
Dec 14 22:11:46 rafale kernel: scsi1: Data Parity Error Detected during
address or write data phase 
and after flooding the console with theses messages in an endless loop,
the kernel lock hard. 

The board work well in all my friends computers. Cables and terminations
are OK, scsi devices are OK. 
I tried with all 2.2 kernels since 2.2.14 and all 2.4 kernels since
2.4.1, -ac and non -ac, UP and SMP, with and witout IOAPIC (UP only). 
The last thing I suspect is a bad interaction between my PCI subsystem
and the AIC driver.PCI operations with the 2940U2W are using PCI
feature/functionality which are not well handled by my mother board... 

My mother board is an ASUS P/I-P65UP5 + c-P55T2D : base board + dual
pentium CPU card and 430HX chipset. 

If Justin and/or a PCI guru could take a look at my probem, it would be
wonderfull. 
Below: lspci -vvx and selected boot mesages. 
I could provide more if needed. 

00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev
03) 
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- 
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR+ <PERR- 
Latency: 32 
00: 86 80 50 12 06 01 00 62 03 00 00 06 00 20 00 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

00:01.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II]
(rev 01) 
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Latency: 0 
00: 86 80 00 70 0f 00 80 02 01 00 01 06 00 00 80 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

00:01.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
(prog-if 80 [Master]) 
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Latency: 32 
Region 4: I/O ports at e800 [size=16] 
00: 86 80 10 70 05 00 80 02 00 80 01 01 00 20 00 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

00:01.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II]
(rev 01) (prog-if 00 [UHCI]) 
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Latency: 32 
Interrupt: pin D routed to IRQ 19 
Region 4: I/O ports at e400 [size=32] 
00: 86 80 20 70 05 00 80 02 01 00 03 0c 00 20 00 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 01 e4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00 

00:09.0 SCSI storage controller: Adaptec AIC-7881U 
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+ 
Latency: 32 (2000ns min, 2000ns max), cache line size 08 
Interrupt: pin A routed to IRQ 19 
Region 0: I/O ports at e000 [disabled] [size=256] 
Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=4K] 
Expansion ROM at <unassigned> [disabled] [size=64K] 
00: 04 90 78 81 16 00 80 82 00 00 00 01 08 20 00 00 
10: 01 e0 00 00 00 00 00 e5 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 08 08 

00:0b.0 SCSI storage controller: Adaptec AHA-2940U2/W 
Subsystem: Adaptec: Unknown device a180 
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Latency: 32 (9750ns min, 6250ns max) 
Interrupt: pin A routed to IRQ 17 
BIST result: 00 
Region 0: I/O ports at d800 [disabled] [size=256] 
Region 1: Memory at e4800000 (64-bit, non-prefetchable) [size=4K] 
Expansion ROM at <unassigned> [disabled] [size=128K] 
Capabilities: [dc] Power Management version 1 
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 
00: 05 90 10 00 16 00 90 02 00 00 00 01 00 20 00 80 
10: 01 d8 00 00 04 00 80 e4 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 80 a1 
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 27 19 

00:0c.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 (rev
01) (prog-if 00 [VGA]) 
Subsystem: Matrox Graphics, Inc. Millennium G200 SD 
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Latency: 32 (4000ns min, 8000ns max), cache line size 08 
Interrupt: pin A routed to IRQ 16 
Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M] 
Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K] 
Region 2: Memory at e3800000 (32-bit, non-prefetchable) [size=8M] 
Expansion ROM at <unassigned> [disabled] [size=64K] 
Capabilities: [dc] Power Management version 1 
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 
00: 2b 10 20 05 07 00 90 02 01 00 00 03 08 20 00 00 
10: 08 00 00 e6 00 00 00 e4 00 00 80 e3 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 03 ff 
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20 

00:0d.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
LANCE] (rev 02) 
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B- 
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+ 
Latency: 0 
Interrupt: pin A routed to IRQ 19 
Region 0: I/O ports at d400 [size=32] 
00: 22 10 00 20 85 00 00 82 02 00 00 02 00 00 00 00 
10: 01 d4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00 

boot message: 


.... 
PCI: PCI BIOS revision 2.10 entry at 0xf0440, last bus=0 
PCI: Using configuration type 1 
PCI: Probing PCI hardware 
PCI: Using IRQ router PIIX [8086/7000] at 00:01.0 
PCI->APIC IRQ transform: (B0,I1,P3) -> 19 
PCI->APIC IRQ transform: (B0,I9,P0) -> 19 
PCI->APIC IRQ transform: (B0,I11,P0) -> 17 
PCI->APIC IRQ transform: (B0,I12,P0) -> 16 
PCI->APIC IRQ transform: (B0,I13,P0) -> 19 
Limiting direct PCI/PCI transfers. 
Activating ISA DMA hang workarounds. 
... 


scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4 
        <Adaptec 2940 Ultra SCSI adapter> 
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs 

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4 
        <Adaptec 2940 Ultra2 SCSI adapter> 
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs 

  Vendor: IBM       Model: DMVS18V           Rev: 02B0 
  Type:   Direct-Access                      ANSI SCSI revision: 03 
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit) 
  Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0d 
  Type:   CD-ROM                             ANSI SCSI revision: 02 
  Vendor: TOSHIBA   Model: CD-ROM XM-3501TA  Rev: 1875 
  Type:   CD-ROM                             ANSI SCSI revision: 02 
(scsi0:A:4): 4.237MB/s transfers (4.237MHz, offset 15) 
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253 
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0 
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB) 
Partition check: 
sda: sda1 sda2 sda3 
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0 
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0 
(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15) 
sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray 
Uniform CD-ROM driver Revision: 3.12 
sr1: scsi-1 drive 

Please CC any answers/comments to my personnal address. 

Thanks. 


