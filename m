Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbTAEI1V>; Sun, 5 Jan 2003 03:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTAEI1V>; Sun, 5 Jan 2003 03:27:21 -0500
Received: from d40.sstar.com ([209.205.179.40]:20734 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id <S263794AbTAEI1T>;
	Sun, 5 Jan 2003 03:27:19 -0500
Message-ID: <3E17EE6E.7030109@asjohnson.com>
Date: Sun, 05 Jan 2003 02:35:58 -0600
From: "Andrew S. Johnson" <andy@asjohnson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sean darcy <seandarcy@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 ide-scsi and cdrecord
References: <fa.j2ta49v.3k0haa@ifi.uio.no>
In-Reply-To: <fa.j2ta49v.3k0haa@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sean darcy wrote:
> ide-scsi refuses to boot with A NULL pointer oops (is  there a patch 
> yet?). But I figured it didn't matter because I could use cdrecord 
> without the scsi layer. So I rebuilt 2.5.54 w/o scsi. Here's the dmesg:
> 
> .............
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
>    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
>    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> hda: Maxtor 6Y120P0, ATA DISK drive
> hdb: MAXTOR 6L060J3, ATA DISK drive
> hda: DMA disabled
> hdb: DMA disabled
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: SONY CD-RW CRX195E1, ATAPI CD/DVD-ROM drive
> hdc: DMA disabled
> ide1 at 0x170-0x177,0x376 on irq 15
> spurious 8259A interrupt: IRQ7.
> hda: host protected area => 1
> hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=238216/16/63, 
> UDMA(133)
> hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
> hdb: host protected area => 1
> hdb: 117266688 sectors (60041 MB) w/1820KiB Cache, CHS=116336/16/63, 
> UDMA(133)
> hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 >
> ...........
> 
> I got cdrecord 2.0:
> 
> [root@amd1900 root]# cdrecord -scanbus -dev=ATAPI
> Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
> scsidev: 'ATAPI'
> devname: 'ATAPI'
> scsibus: -2 target: -2 lun: -2
> Warning: Using ATA Packet interface.
> Warning: The related libscg interface code is in pre alpha.
> Warning: There may be fatal problems.
> cdrecord: No such device or address. Cannot open SCSI driver.
> cdrecord: For possible targets try 'cdrecord -scanbus'. Make sure you 
> are root.
> cdrecord: For possible transport specifiers try 'cdrecord dev=help'.

Did you try cdrecord dev=help like it says?  The output of that will
tell you that -scanbus isn't supported with ATAPI devices.  I got it
to work blind using 'cdrecord speed=8 dev=ATAPI:0,1,0 -v my.iso' for
a CD-RW at hdb.  So, I'm assuming the first 0 is the IDE channel,
the 1 is for a slave (so 0 for master?), and the third I'll just leave
as zero.  Of course, don't use the ide-scsi module.  Use the ide-cd
module instead.

Hope this helps,

Andy Johnson

> 
> FWIW, I also tried just cdrecord -scanbus
> 
> What am I missing? I thought we didn't need the scsi layer anymore.
> 
> Here are snips from .config:
> 
> CONFIG_IDE=y
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> 
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> 
> CONFIG_BLK_DEV_IDECD=y
> 
> # IDE chipset support/bugfixes
> #
> 
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> 
> CONFIG_IDEDMA_PCI_AUTO=y
> 
> CONFIG_BLK_DEV_IDEDMA=y
> 
> CONFIG_BLK_DEV_ADMA=y
> 
> CONFIG_BLK_DEV_VIA82CXXX=y
> CONFIG_IDEDMA_AUTO=y
> 
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> #
> # SCSI device support
> #
> # CONFIG_SCSI is not set
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> _________________________________________________________________
> Protect your PC - get McAfee.com VirusScan Online 
> http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

