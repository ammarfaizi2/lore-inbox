Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266359AbTAPMu7>; Thu, 16 Jan 2003 07:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTAPMu7>; Thu, 16 Jan 2003 07:50:59 -0500
Received: from services.cam.org ([198.73.180.252]:27978 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S266359AbTAPMu5> convert rfc822-to-8bit;
	Thu, 16 Jan 2003 07:50:57 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: 2.5.58bk pdc20267 ide problems
Date: Thu, 16 Jan 2003 07:59:37 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Message-Id: <200301160759.37156.tomlins@cam.org>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This morning my logs showed me (hand coppied):

hde: dma_timer_expiry: dma_status -- 0x21
hde: timeout waiting for dma
PDC202XX: Primary channel reset.
PDC202XX: Seconday channel reset.
hde: set drive_speed_status: status=0x00 { }
hde: timeout waiting for dma
hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hde: read_intr: error=0x03 { DriveStatusError }

last two are repeated my times and followed by

PDC202XX: Primary channel reset.
PDC202XX: Seconday channel reset.
hde: DMA disabled
ide2: reset: master: error (0x00?)
hde: dma_timer_expiry: dma_status -- 0x20
hde: timeout waiting for dma
PDC202XX: Primary channel reset.
PDC202XX: Seconday channel reset.
hde: DMA disabled
ide2: reset: master: error (0x00?)
hde: dma_timer_expiry: dma_status -- 0x20
hde: timeout waiting for dma

followed by fs errors and another reset and finally

hde: lost interrupt

repeated many times

it also ends up tring to reset the drive one hdg

The controller is a PDC20267 PCI card and has been working without problems
since the IDE revamp early this fall.  dmesg shows the following:

Jan 15 23:09:08 oscar kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan 15 23:09:08 oscar kernel: ide: Assuming 33MHz system bus speed for PIO modes
Jan 15 23:09:08 oscar kernel: VP_IDE: IDE controller at PCI slot 00:07.1
Jan 15 23:09:08 oscar kernel: VP_IDE: chipset revision 6
Jan 15 23:09:08 oscar kernel: VP_IDE: not 100%% native mode: will probe irqs later
Jan 15 23:09:08 oscar kernel: VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
Jan 15 23:09:08 oscar kernel:     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
Jan 15 23:09:08 oscar kernel:     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
Jan 15 23:09:08 oscar kernel: hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
Jan 15 23:09:08 oscar kernel: hda: DMA disabled
Jan 15 23:09:08 oscar kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 15 23:09:08 oscar kernel: hdc: AOPEN 16XDVD-ROM/AMH 20020328, ATAPI CD/DVD-ROM drive
Jan 15 23:09:08 oscar kernel: hdd: HP COLORADO 20GB, ATAPI TAPE drive
Jan 15 23:09:08 oscar kernel: hdc: DMA disabled
Jan 15 23:09:08 oscar kernel: hdd: DMA disabled
Jan 15 23:09:08 oscar kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan 15 23:09:08 oscar kernel: PDC20267: IDE controller at PCI slot 00:09.0
Jan 15 23:09:08 oscar kernel: PCI: Found IRQ 12 for device 00:09.0
Jan 15 23:09:08 oscar kernel: PDC20267: chipset revision 2
Jan 15 23:09:08 oscar kernel: PDC20267: not 100%% native mode: will probe irqs later
Jan 15 23:09:08 oscar kernel: PDC20267: ROM enabled at 0xeb000000
Jan 15 23:09:08 oscar kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
Jan 15 23:09:08 oscar kernel:     ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
Jan 15 23:09:08 oscar kernel:     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:DMA
Jan 15 23:09:08 oscar kernel: hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
Jan 15 23:09:08 oscar kernel: ide2 at 0xac00-0xac07,0xb002 on irq 12
Jan 15 23:09:08 oscar kernel: hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
Jan 15 23:09:08 oscar kernel: ide3 at 0xb400-0xb407,0xb802 on irq 12
Jan 15 23:09:08 oscar kernel: hda: host protected area => 1
Jan 15 23:09:08 oscar kernel: hda: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63, UDMA(33)
Jan 15 23:09:08 oscar kernel:  hda: hda1 hda2 hda3 hda4 < hda5 >
Jan 15 23:09:08 oscar kernel: hde: host protected area => 1
Jan 15 23:09:08 oscar kernel: hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
Jan 15 23:09:08 oscar kernel:  hde: hde1 hde2 hde3 hde4 < hde5 >
Jan 15 23:09:08 oscar kernel: hdg: host protected area => 1
Jan 15 23:09:08 oscar kernel: hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
Jan 15 23:09:08 oscar kernel:  hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 >

lspci -vv
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at ac00 [size=8]
        Region 1: I/O ports at b000 [size=4]
        Region 2: I/O ports at b400 [size=8]
        Region 3: I/O ports at b800 [size=4]
        Region 4: I/O ports at bc00 [size=64]
        Region 5: Memory at ed100000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at eb000000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Kernel is 2.5.58bk from the 15th at about 9pm with the following added:

ChangeSet@1.914.4.7, 2003-01-15 21:40:19-05:00, ed@oscar.et.ca
  let sound work until errno mess is fixed

ChangeSet@1.914.4.6, 2003-01-15 21:36:11-05:00, ed@oscar.et.ca
  reiserfs-readpages.patch (from 58-mm1)

ChangeSet@1.914.4.4, 2003-01-15 21:25:36-05:00, ed@oscar.et.ca
  scheduler-tunables.patch

ChangeSet@1.914.4.3, 2003-01-15 21:23:56-05:00, ed@oscar.et.ca
  ptg-B4

ChangeSet@1.914.4.2, 2003-01-15 21:19:48-05:00, ed@oscar.et.ca
  NFS_PATCH_missing_export_of_hash_mem_2_5_55

ChangeSet@1.914.4.1, 2003-01-15 21:16:17-05:00, ed@oscar.et.ca
  PATCH_kexec_for_2_5_54

Hope this helps,

Ed Tomlinson







