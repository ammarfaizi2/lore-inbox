Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318852AbSH1S2P>; Wed, 28 Aug 2002 14:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318900AbSH1S2P>; Wed, 28 Aug 2002 14:28:15 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:8967 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318852AbSH1S1i>; Wed, 28 Aug 2002 14:27:38 -0400
Date: Wed, 28 Aug 2002 20:31:53 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: ide-2.4.20-pre4-ac2.patch
Message-ID: <20020828183153.GB16018@louise.pinerecords.com>
References: <20020828182616.GA16018@louise.pinerecords.com> <Pine.LNX.4.10.10208281126560.24156-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10208281126560.24156-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 3 days, 10:28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Big jump in clean up and debloating.
> If you try the patch and it repeats, you can re-LART me.

Since I have to reinstall the darn system anyway, I will
at least test the patch. Will let you know later tonight.

T.


> > > WHOA Tomas,
> > > 
> > > That is a major problem, are you using legacy patch or taskfile io?
> > > Ben H reported he was having problems with legacy path on PPC, but the new
> > > taskfile io worked fine.
> > 
> > Damn! Andre, I owe you **A BIG** apology -- it turns out the kernel that
> > caused the mess was actually a plain 2.4.20-pre4-ac2 _without_ your patch
> > applied -- dunno how far that is from what you have now. Nevertheless,
> > here's the corresponding 2.4.20-pre4-ac2 IDE config:
> > 
> > #
> > # IDE chipset support/bugfixes
> > #
> > # CONFIG_BLK_DEV_CMD640 is not set
> > # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> > # CONFIG_BLK_DEV_ISAPNP is not set
> > CONFIG_BLK_DEV_IDEPCI=y
> > CONFIG_BLK_DEV_GENERIC=y
> > CONFIG_IDEPCI_SHARE_IRQ=y
> > CONFIG_BLK_DEV_IDEDMA_PCI=y
> > # CONFIG_BLK_DEV_OFFBOARD is not set
> > # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> > CONFIG_IDEDMA_PCI_AUTO=y
> > # CONFIG_IDEDMA_ONLYDISK is not set
> > CONFIG_BLK_DEV_IDEDMA=y
> > # CONFIG_IDEDMA_PCI_WIP is not set
> > # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> > CONFIG_BLK_DEV_ADMA=y
> > # CONFIG_BLK_DEV_AEC62XX is not set
> > # CONFIG_BLK_DEV_ALI15X3 is not set
> > # CONFIG_WDC_ALI15X3 is not set
> > # CONFIG_BLK_DEV_AMD74XX is not set
> > # CONFIG_AMD74XX_OVERRIDE is not set
> > # CONFIG_BLK_DEV_CMD64X is not set
> > # CONFIG_BLK_DEV_CY82C693 is not set
> > # CONFIG_BLK_DEV_CS5530 is not set
> > # CONFIG_BLK_DEV_HPT34X is not set
> > # CONFIG_HPT34X_AUTODMA is not set
> > # CONFIG_BLK_DEV_HPT366 is not set
> > CONFIG_BLK_DEV_PIIX=y
> > # CONFIG_BLK_DEV_NFORCE is not set
> > # CONFIG_BLK_DEV_NS87415 is not set
> > # CONFIG_BLK_DEV_OPTI621 is not set
> > # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> > # CONFIG_PDC202XX_BURST is not set
> > CONFIG_BLK_DEV_PDC202XX_NEW=y
> > # CONFIG_PDC202XX_FORCE is not set
> > # CONFIG_BLK_DEV_RZ1000 is not set
> > # CONFIG_BLK_DEV_SVWKS is not set
> > # CONFIG_BLK_DEV_SIIMAGE is not set
> > # CONFIG_BLK_DEV_SIS5513 is not set
> > # CONFIG_BLK_DEV_SLC90E66 is not set
> > # CONFIG_BLK_DEV_TRM290 is not set
> > # CONFIG_BLK_DEV_VIA82CXXX is not set
> > # CONFIG_IDE_CHIPSETS is not set
> > CONFIG_IDEDMA_AUTO=y
> > # CONFIG_IDEDMA_IVB is not set
> > # CONFIG_DMA_NONPCI is not set
> > CONFIG_BLK_DEV_PDC202XX=y
> > CONFIG_BLK_DEV_IDE_MODES=y
> > # CONFIG_BLK_DEV_ATARAID is not set
> > # CONFIG_BLK_DEV_ATARAID_PDC is not set
> > # CONFIG_BLK_DEV_ATARAID_HPT is not set
> > 
> > 
> > > On Wed, 28 Aug 2002, Tomas Szepe wrote:
> > > 
> > > > > This is out and has been forwarded to AC for review.
> > > > 
> > > > Okay, I tested this the hard way -- the root of one of my machines
> > > > got trashed. The controller used was a PDC20268 (Ultra100TX2), the
> > > > disks (with two partitions of equal size on each forming a raid0)
> > > > are IBM and WD. Soon after the kernel came up, it started spitting
> > > > messages like 'DMA disabled' and 'No DRQ after WRITE has been issued',
> > > > after which the machine froze entirely. Rebooting w/ an alternate
> > > > kernel revealed massive fs corruption with the superblock completely
> > > > overwritten.
> > > > 
> > > >   *** Everybody please treat this patch with extreme care. ***
> > > > 
> > > > Reiserfs people, this unfortunate event also made me find out about
> > > > the inability of reiserfsck 3.6.3-pre1 to rebuild the node tree --
> > > > the program pretends to work just fine but the in-kernel fs code
> > > > barfs when it's to operate on a repaired fs. 3.x.1b was able to
> > > > get the job done for me, though.
> > > > 
> > > > T.
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > 
> > > 
> > > Andre Hedrick
> > > LAD Storage Consulting Group
> > 
> 
> Andre Hedrick
> LAD Storage Consulting Group
