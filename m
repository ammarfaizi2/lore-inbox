Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTAJLjb>; Fri, 10 Jan 2003 06:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbTAJLjb>; Fri, 10 Jan 2003 06:39:31 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:17792 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S261292AbTAJLja>; Fri, 10 Jan 2003 06:39:30 -0500
Date: Fri, 10 Jan 2003 12:48:12 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.5.55 - ide-scsi hw lockup
Message-ID: <20030110114812.GA612@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as of 2.5.55, ide-scsi still lockups my system during boot.

I have: (ide=reverse is applied)
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:DMA, hdd:pio
hda: ST380021A, ATA DISK drive
ide0 at 0x9000-0x9007,0x8802 on irq 10
hdc: IBM-DTLA-307045, ATA DISK drive
ide1 at 0x8400-0x8407,0x8002 on irq 10
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:DMA, hdh:pio
hde: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
hde: DMA disabled
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hdg: CD-W512EB, ATAPI CD/DVD-ROM drive
hdg: DMA disabled


If I tell hdg=ide-scsi then at ide-scsi initialization IDE LED lights and
nothing but hw reset helps.

If I physically swap hdg and hde then hde=ide-scsi works ok. 

Without ide-scsi cdrecord dev=/dev/hdg works perfectly. However readcd and 
cdrdao is not ready for the atapi yet.

System is Asus A7V motherboard with AMD Thunderbird 1.2GHz.


With kernel 2.4.20 is all ok, so it should not be a hw bug.

Why it reports DMA disabled?

my .config
#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y

-- 
Luká¹ Hejtmánek
