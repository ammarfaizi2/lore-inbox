Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSG3IkI>; Tue, 30 Jul 2002 04:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSG3IkI>; Tue, 30 Jul 2002 04:40:08 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:17929 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S315277AbSG3IkG> convert rfc822-to-8bit; Tue, 30 Jul 2002 04:40:06 -0400
Date: Tue, 30 Jul 2002 10:43:28 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PCI: No IRQ known for interrupt pin A of device 00:0b.0.
Message-ID: <Pine.LNX.4.44.0207301030270.1534-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am running an older K6-based box with ALI aladdin chipset. When
booting 2.4 kernels, I get the above message ("PCI: No IRQ known for
interrupt pin A of device 00:0b.0."). 2.2 kernels don't print this
(although I do not have a dmesg or similar). An IRQ is assigned for both
IDE channelse (00:0b.0 is the IDE interface). I get that behaviour under
2.4.19-rc3 as well as 2.4.18. I *think* I got it with 2.4.12 too, but I
do not have any proof, as I do not have logfiles that log time back.

When putting "pci=biosirq" on the lilo prompt, I get exactly the same
message, just without the "Please try using pci=biosirq." part.

Why do I get that message, when everything seems to work just fine - is
it a bug? Could it be the BIOS behaving strange? The lspci indicates
that the IDE IRQ is routed to IRQ 0 - is that just a BIOS bug?

Below is lspci -vv, relevant parts of dmesg, /proc/interrupts, and
/proc/ide/ali

Perhaps I should mention, that everything works just fine; I am mostly
worried about what the message means.

/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
To alcohol!
The cause of - and solution to - all of life's problems!
                                        -- Homer Simpson
----------------------------------[ moffe at amagerkollegiet dot dk ] --

-- lspci -vv
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV] (rev b2)
	Subsystem: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev b4)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:04.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 7000 [size=128]
	Region 1: Memory at 05100000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 05120000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:06.0 VGA compatible controller: ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB] (rev 9a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Region 0: Memory at 06000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 7400 [size=256]
	Region 2: Memory at 05101000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 05140000 [disabled] [size=128K]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 7800 [size=16]

-- dmesg
Linux version 2.4.19-rc3 (root@gere) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 man jul 29 10:21:24 CEST 2002
[...]
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
[...]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 58
PCI: No IRQ known for interrupt pin A of device 00:0b.0. Please try using pci=biosirq.
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:pio, hdd:DMA
hda: MAXTOR 6L080J4, ATA DISK drive
hdb: QUANTUM FIREBALL SE2.1A, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: MAXTOR 6L080J4, ATA DISK drive
hdd: CD-ROM 24X/AKOx, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63, (U)DMA
hdb: 4124736 sectors (2112 MB) w/80KiB Cache, CHS=1023/64/63, (U)DMA
hdc: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, (U)DMA
Partition check:
 hda: hda1 hda2
 hdb: [EZD] [remap 0->1] [1023/64/63] hdb1 hdb2
 hdc: [PTBL] [9732/255/63] hdc1 hdc2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:04.0: 3Com PCI 3c905C Tornado at 0x7000. Vers LK1.1.16

-- /proc/interrupts
           CPU0
  0:    5315412          XT-PIC  timer
  1:       2473          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 10:   18463552          XT-PIC  eth0
 14:    2472544          XT-PIC  ide0
 15:    2280840          XT-PIC  ide1
NMI:          0
ERR:          0

-- /proc/ide/ali

                                Ali M15x3 Chipset.
                                ------------------
PCI Clock: 33.
CD_ROM FIFO:No , CD_ROM DMA:Yes
FIFO Status: contains 0 Words, runs.

-------------------primary channel-------------------secondary channel---------

channel status:       Off                               Off
both channels togth:  Yes                               Yes
Channel state:        OK                                OK
Add. Setup Timing:    1T                                1T
Command Act. Count:   3T                                3T
Command Rec. Count:   1T                               1T

----------------drive0-----------drive1------------drive0-----------drive1------

DMA enabled:      Yes              Yes               Yes              Yes
FIFO threshold:   13 Words         13 Words          13 Words         12 Words
FIFO mode:        FIFO On          FIFO On           FIFO On          FIFO Off
Dt RW act. Cnt     3T               3T                3T               3T
Dt RW rec. Cnt     1T               1T                1T               1T

-----------------------------------UDMA Timings--------------------------------

UDMA:             No               No                No               No
UDMA timings:     1.5T             1.5T              1.5T             1.5T


