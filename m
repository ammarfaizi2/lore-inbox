Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265428AbSJSAfd>; Fri, 18 Oct 2002 20:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265429AbSJSAfd>; Fri, 18 Oct 2002 20:35:33 -0400
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:46262 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S265428AbSJSAer> convert rfc822-to-8bit; Fri, 18 Oct 2002 20:34:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Jan Dittmer <jan@jandittmer.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Oops on boot with TCQ enabled (VIA KT133A)
Date: Sat, 19 Oct 2002 02:41:49 +0200
User-Agent: KMail/1.4.3
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210190241.49618.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Box runs nevertheless. Disabled tcq at runtime.
Do you need more information? Their seems to be no more fs corruption, as 
reported earlier.

jan


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L060AVVA07-0, ATA DISK drive
hda: DMA disabled
IDE init is ugly:Call Trace:
 [<c02722cf>] ide_do_drive_cmd+0x8f/0x180
 [<c026f4e8>] ide_diag_taskfile+0x88/0xa0
 [<c026f516>] ide_raw_taskfile+0x16/0x20
 [<c027dc17>] ide_tcq_configure+0x77/0xe0
 [<c027dcc6>] ide_enable_queued+0x46/0xb0
 [<c027de28>] __ide_dma_queued_on+0x48/0x50
 [<c026b675>] ide_init_queue+0x75/0x80
 [<c026b936>] init_irq+0x2b6/0x380
 [<c026be56>] hwif_init+0x106/0x220
 [<c026b54c>] probe_hwif_init+0x1c/0x70
 [<c027bded>] ide_setup_pci_device+0x3d/0x70
 [<c026a583>] via_init_one+0x33/0x40
 [<c010508f>] init+0x2f/0x180
 [<c0105060>] init+0x0/0x180
 [<c01054f5>] kernel_thread_helper+0x5/0x10

hda: bad special flag: 0x03
IDE init is ugly:Call Trace:
 [<c02722cf>] ide_do_drive_cmd+0x8f/0x180
 [<c026f4e8>] ide_diag_taskfile+0x88/0xa0
 [<c026f516>] ide_raw_taskfile+0x16/0x20
 [<c027dc46>] ide_tcq_configure+0xa6/0xe0
 [<c027dcc6>] ide_enable_queued+0x46/0xb0
 [<c027de28>] __ide_dma_queued_on+0x48/0x50
 [<c026b675>] ide_init_queue+0x75/0x80
 [<c026b936>] init_irq+0x2b6/0x380
 [<c026be56>] hwif_init+0x106/0x220
 [<c026b54c>] probe_hwif_init+0x1c/0x70
 [<c027bded>] ide_setup_pci_device+0x3d/0x70
 [<c026a583>] via_init_one+0x33/0x40
 [<c010508f>] init+0x2f/0x180
 [<c0105060>] init+0x0/0x180
 [<c01054f5>] kernel_thread_helper+0x5/0x10

hda: tagged command queueing enabled, command queue depth 32
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY CD-RW CRX175E2, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=7476/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p3 p4 < p5 p6 >
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
end_request: I/O error, dev 16:40, sector 0
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices

jdittmer@ds666:~$ lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 
8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 9000 [size=16]
        Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at 9400 [size=32]
        Capabilities: <available only to root>

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at 9800 [size=32]
        Capabilities: <available only to root>

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: <available only to root>

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 50)
        Subsystem: Micro-star International Co Ltd: Unknown device 3300
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 12
        Region 0: I/O ports at 9c00 [size=256]
        Region 1: I/O ports at a000 [size=4]
        Region 2: I/O ports at a400 [size=4]
        Capabilities: <available only to root>

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at ac00 [size=32]
        Capabilities: <available only to root>

00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
08)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at b000 [size=8]
        Capabilities: <available only to root>

00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e3122000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at b400 [size=64]
        Region 2: Memory at e3000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: <available only to root>

00:0e.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at e3120000 (32-bit, prefetchable) [size=4K]

00:0e.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at e3121000 (32-bit, prefetchable) [size=4K]

00:0f.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b800 [size=8]
        Region 1: I/O ports at bc00 [size=4]
        Region 2: I/O ports at c000 [size=8]
        Region 3: I/O ports at c400 [size=4]
        Region 4: I/O ports at c800 [size=64]
        Region 5: Memory at e3100000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev 
a1) (prog-if 00 [VGA])
        Subsystem: Elsa AG: Unknown device 0c60
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

.config:
CONFIG_IDE=y
# IDE, ATA and ATAPI Block devices
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
CONFIG_BLK_DEV_IDEDMA_FORCED=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y

