Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSESSnS>; Sun, 19 May 2002 14:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSESSnR>; Sun, 19 May 2002 14:43:17 -0400
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:40066 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S314811AbSESSnQ>; Sun, 19 May 2002 14:43:16 -0400
Message-ID: <000901c1ff65$05b7b5b0$6caca8c0@kpfdev>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Erik Steffl" <steffl@bigfoot.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3CDCD708.6000208@notnowlewis.co.uk> <3CDC3B90.AADE1835@bigfoot.com> <4.1.20020516224137.00914260@pop.cablewanadoo.nl> <200205170949.48426.mikeh@notnowlewis.co.uk> <3CE750E2.AA5585AB@bigfoot.com>
Subject: Re: lost interrupt hell - Plea for Help
Date: Sun, 19 May 2002 11:43:09 -0700
Organization: Laboratory Systems Group, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just switched motherboards in my file server, which previously had no
problems ripping audio from my Creative 52X drives. The new motherboard has
the KT266A chipset, but the CD drives are _not_ connected to that chipset's
IDE ports. I am getting "lost interrupt" messages when I try to rip audio
from the drives, or even mount ISO9660 discs (which do eventually succeed,
they just take over a minute to mount). So far I have done the following:

- turned off "dma" and "unmaskirq" for the CD drives
- tried ide-scsi/sg instead of ide-cd
- tried booting with "noapic"
- tried 2.4.19-pre8 and 2.4.19-pre8-ac4

Nothing has helped. The machine configuration is an MSI KT7266-Pro2RU
motherboard, KT266A chipset with on-board Promise PDC20265R FastTrak
"lite"). There is also a Promise PDC20262 (Ultra66TX2) in a PCI slot, and
that is where the CD drives are connected. Each CD drive is the master on
its channel, and one of them also has a Iomega ZIP 250 ATAPI drive as its
slave. Interestingly, the ZIP drive works perfectly, no "lost interrupt"
messages at all.

lspci output is below:

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:05.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
00:06.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller
00:07.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:08.0 Ethernet controller: National Semiconductor Corporation DP83820
10/100/1000 Ethernet Controller
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev
01)
00:0b.0 USB Controller: NEC Corporation USB (rev 41)
00:0b.1 USB Controller: NEC Corporation USB (rev 41)
00:0b.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
00:0c.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP

relevant sections of .config:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y


----- Original Message -----
From: "Erik Steffl" <steffl@bigfoot.com>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 19, 2002 12:14 AM
Subject: Re: lost interrupt hell - Plea for Help


> Mike wrote:
> >
> > Yeah, the spurious interrupt does seem to be an AMD apic problem, but
the lost
> > interrupt (on ripping audio) seems to be a VIA chipset problem, as
people
> > with KT266 chipsets are having boot problems / audio rip problems
regardless
> > of the processor type. Lucky me, I get both ;)
>



