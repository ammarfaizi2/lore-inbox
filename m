Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262386AbSJLIm7>; Sat, 12 Oct 2002 04:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262405AbSJLIm7>; Sat, 12 Oct 2002 04:42:59 -0400
Received: from b107245.adsl.hansenet.de ([62.109.107.245]:1665 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id <S262386AbSJLImz> convert rfc822-to-8bit;
	Sat, 12 Oct 2002 04:42:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Jan Dittmer <jan@jandittmer.de>
To: linux-kernel@vger.kernel.org
Subject: harddisk corruption with 2.5.41bk and tcq enabled
Date: Sat, 12 Oct 2002 10:50:01 +0200
User-Agent: KMail/1.4.3
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210121050.01471.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

recent tcp additions seem to corrupt harddisk. X/KDE doesn't start up anymore 
and 'mount' was broken after reboot. (Debian/unstable, ext3 fs) No Problem 
with clean 2.5.41. Will try 2.5.42 now. You need any more information?

jan

Here goes dmesg/config output:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L060AVVA07-0, ATA DISK drive
hda: DMA disabled
hda: bad special flag: 0x03
hda: tagged command queueing enabled, command queue depth 8
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY CD-RW CRX175E2, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=7476/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
ide-cd: passing drive hdc to ide-scsi emulation.
hdd: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX175E2   Rev: S002
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray

[...]

attempt to access beyond end of device
ide0(3,2): rw=0, want=1076371720, limit=19535040
attempt to access beyond end of device
ide0(3,2): rw=0, want=1076261672, limit=19535040
attempt to access beyond end of device
ide0(3,2): rw=0, want=1076240168, limit=19535040
attempt to access beyond end of device
ide0(3,2): rw=0, want=1076243240, limit=19535040
attempt to access beyond end of device
ide0(3,2): rw=0, want=1076335080, limit=19535040
attempt to access beyond end of device
ide0(3,2): rw=0, want=1076262568, limit=19535040
attempt to access beyond end of device
ide0(3,2): rw=0, want=1076262568, limit=19535040
attempt to access beyond end of device
ide0(3,2): rw=0, want=1076262568, limit=19535040

.config:
#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=8
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_IDEDMA_FORCED=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
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
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
