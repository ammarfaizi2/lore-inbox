Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131240AbRCRQxD>; Sun, 18 Mar 2001 11:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131241AbRCRQwy>; Sun, 18 Mar 2001 11:52:54 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:52498 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131240AbRCRQwk>; Sun, 18 Mar 2001 11:52:40 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Sun, 18 Mar 2001 16:53:59 +0000
From: quintaq@yahoo.co.uk
To: <linux-kernel@vger.kernel.org>
Subject: UDMA 100 / PIIX4 question
Reply-To: quintaq@yahoo.co.uk
X-Mailer: Sylpheed version 0.4.62 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010318165246Z131240-406+1417@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This question is much the same as one I posted a couple of months ago, at which time I was using the stock 2.2.18 kernel supplied with my SuSE distro.  Some people suggested that I should upgrade, and since then I have been learning my way around kernel compilation and following this list.  I am now running 2.4.2, but my problem remains, so I thought I might reasonably ask again.

I have an IBM DTLA 307030 (ATA 100 / UDMA 5) on an 815e board (Asus CUSL2), which has a PIIX4 controller.

The drive is properly cabled and correctly recognised.  I have, I think, set the right options in my kernel config (I have quoted the relevant part  below).  Lilo.conf includes append="ide0=ata66.

Boot.msg includes:

<4>PIIX4: chipset revision 1
<4>PIIX4: not 100% native mode: will probe irqs later
<4>PIIX4: ATA-66/100 forced bit set (WARNING)!!
<4>    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
<4>hda: IBM-DTLA-307030, ATA DISK drive
<snip> ...
<6>hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(100)

According to hdparm -i the drive thinks that it is in UDMA mode 5.

My problem is that (according to hdparm -t), I never get a better transfer rate than approximately 15.8 Mb/sec.  I achieve this when DMA is enabled, - without it I fall back to about 5 Mb /sec.  No amount of fiddling with other hdparm settings makes any difference.

I do appreciate that there are some issues involving higher UDMA rates and certain hardware.  I have read a number of relevant posts, including those passing between Linus, Andre Hedrick, Alan Cox and others on the subject last January, but I cannot understand from what I have read whether or not my particular configuration (in particular the PIIX4),is subject to these problems - or if I am simply screwed up.

TIA,

Geoff

CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

