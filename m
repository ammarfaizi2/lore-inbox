Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbTFWWNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbTFWWNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:13:40 -0400
Received: from mail.tbdnetworks.com ([63.209.25.99]:35591 "EHLO stargazer")
	by vger.kernel.org with ESMTP id S265423AbTFWWKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:10:05 -0400
Date: Mon, 23 Jun 2003 15:24:05 -0700
To: linux-kernel@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, nk@iname.com
Subject: 2.5.73bk1 hangs in boot (IDE setup)
Message-ID: <20030623222405.GA1248@defiant>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just tried to run 2.5.73bk1 on my desktop, but it hangs somewhere in
the IDE setup.  The identical hardware boots 2.4.x (currently 21ck3)
without problems.  I wrote down the output (see below).

The machine is an Athlon-1100 with an on-board RAID controller (which
I use as additional IDE controllers).

I also append the corresponding output from 2.4.21 (using "hdb=scsi"),
an extract of the config (hopefully including all relevant parts), and
lspci output.

so long
        Norbert

2.5.73bk1:
  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  VP_IDE: IDE controller at PCI slot 00:07.1
  VP_IDE: chipset revision 16
  VP_IDE: not 100%% native mode: will probe irqs later
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
      ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:DMA
  hda: KENWOOD CD-ROM UCR-421 V221F, ATAPI CD/DVD-ROM drive
  hdb: R/RW 4x4x24, ATAPI CD/DVD-ROM drive
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  hdd: Maxtor 91152D8, ATA DISK drive
  ide1 at 0x170-0x177,0x376 on irq 15
  CMD649: IDE controller at PCI slot 00:10.0
  CMD649: chipset revision 1
  CMD649: not 100%% native mode: will probe irqs later
      ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:pio, hdf:DMA
      ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:pio, hdh:DMA
  hdf: IBM-DJNA-370910, ATA DISK drive
  ide2 at 0xd400-0xd407,0xd802 on irq 12
  *** hangs right here ***

2.4.21ck3:
  Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  VP_IDE: IDE controller at PCI slot 00:07.1
  VP_IDE: chipset revision 16
  VP_IDE: not 100%% native mode: will probe irqs later
  VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
      ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:DMA
  CMD649: IDE controller at PCI slot 00:10.0
  CMD649: chipset revision 1
  CMD649: not 100%% native mode: will probe irqs later
      ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:pio, hdf:DMA
      ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:pio, hdh:DMA
  hda: KENWOOD CD-ROM UCR-421 V221F, ATAPI CD/DVD-ROM drive
  hdb: R/RW 4x4x24, ATAPI CD/DVD-ROM drive
  hdd: Maxtor 91152D8, ATA DISK drive
  blk: queue c032dd7c, I/O limit 4095Mb (mask 0xffffffff)
  hdf: IBM-DJNA-370910, ATA DISK drive
  blk: queue c032e1d8, I/O limit 4095Mb (mask 0xffffffff)
  hdh: QUANTUM FIREBALLP AS20.5, ATA DISK drive
  blk: queue c032e634, I/O limit 4095Mb (mask 0xffffffff)
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  ide1 at 0x170-0x177,0x376 on irq 15
  ide2 at 0xd400-0xd407,0xd802 on irq 12
  ide3 at 0xdc00-0xdc07,0xe002 on irq 12
  hdd: attached ide-disk driver.
  hdd: host protected area => 1
  hdd: 22510656 sectors (11525 MB) w/256KiB Cache, CHS=22332/16/63, UDMA(33)
  hdf: attached ide-disk driver.
  hdf: host protected area => 1
  hdf: 17803440 sectors (9115 MB) w/1966KiB Cache, CHS=17662/16/63, UDMA(33)
  hdh: attached ide-disk driver.
  hdh: host protected area => 1
  hdh: 40132503 sectors (20548 MB) w/1902KiB Cache, CHS=39813/16/63, UDMA(100)
  hda: attached ide-cdrom driver.
  hda: ATAPI 68X CD-ROM drive, 2048kB Cache, UDMA(33)
  Uniform CD-ROM driver Revision: 3.12
  ide-cd: passing drive hdb to ide-scsi emulation.
  hdb: attached ide-scsi driver.
  Partition check:
   hdd: hdd1 hdd2 < hdd5 hdd6 hdd7 hdd8 >
   hdf: hdf1
   hdh: hdh1 < hdh5 hdh6 > hdh2
  SCSI subsystem driver Revision: 1.00
  scsi0 : SCSI host adapter emulation for IDE ATAPI devices
    Vendor: IDE-CD    Model: R/RW 4x4x24       Rev: C12a
    Type:   CD-ROM                             ANSI SCSI revision: 02
  *** goes on with network etc. ***

CONFIG_GENERIC_ISA_DMA=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NOHIGHMEM=y

CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=m
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

# CONFIG_HOTPLUG_PCI is not set

CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y

# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

CONFIG_SCSI=y

CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

lspci -v:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
        Flags: bus master, medium devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d6000000-d7ffffff
        Prefetchable memory behind bridge: d4000000-d5ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at c000 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Flags: medium devsel, IRQ 5
        Capabilities: [68] Power Management version 2

00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at cc00 [size=128]
        Memory at d9000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d000 [size=256]
        Capabilities: [c0] Power Management version 2

00:10.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 01)
        Subsystem: CMD Technology Inc PCI0649
        Flags: bus master, medium devsel, latency 64, IRQ 12
        I/O ports at d400 [size=8]
        I/O ports at d800 [size=4]
        I/O ports at dc00 [size=8]
        I/O ports at e000 [size=4]
        I/O ports at e400 [size=16]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Subsystem: VISIONTEK: Unknown device 0005
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
        Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d4000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0

