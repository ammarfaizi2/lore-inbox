Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSGQSTD>; Wed, 17 Jul 2002 14:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSGQSTD>; Wed, 17 Jul 2002 14:19:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54208 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316342AbSGQSTC>; Wed, 17 Jul 2002 14:19:02 -0400
Date: Wed, 17 Jul 2002 20:21:43 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andre Hedrick <andre@linux-ide.org>, Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2 and Promise RAID controller
In-Reply-To: <Pine.LNX.4.10.10207170950050.10225-100000@master.linux-ide.org>
Message-ID: <Pine.SOL.4.30.0207171952070.19596-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Yup, I have noticed that and haven't forward ported this part to 2.5]

Bug is with checking CONFIG_PDC202XX_FORCE, it should be #ifndef,
not #ifdef. Also this option should be by default turned _ON_.

So if somebody wants to use Promise _closed source_ driver for
"RAID" he/she has to disable this option.

Promise wants to remove this option and make people use their closed
source drivers, but they should get red light on this change.

And this comment should be removed from pdc202xx.c:
"
 *  Linux kernel will misunderstand FastTrak ATA-RAID series as Ultra
 *  IDE Controller, UNLESS you enable "CONFIG_PDC202XX_FORCE"
 *  That's you can use FastTrak ATA-RAID controllers as IDE controllers.
"
as it is bogus and it is not Linux's fault et all.

Regards
--
Bartlomiej

On Wed, 17 Jul 2002, Andre Hedrick wrote:

> This is just proves that accepting the patch code from Promise will begin
> to remove basic support for hardware.  I warned everyone of this and
> people do not listen.  So I suggest that you find another vendors product
> to use as the PDC20270 shall not be supported anymore.
>
>
> Andre Hedrick
> LAD Storage Consulting Group
>
> On Wed, 17 Jul 2002, Klaus Dittrich wrote:
>
> > With 2.4.19.rc2 my Promise RAID controller will be skipped.
> > With 2.4.19.rc1 and before it was detected and worked fine.
> >
> > from dmesg of 2.4.19rc2 ..
> >
> > PIIX4: chipset revision 1
> > PIIX4: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
> > 	ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
> > 	PDC20270: IDE controller on PCI bus 00 dev 48
> > 	PDC20270: chipset revision 2
> > 	ide: Skipping Promise RAID controller.
> > 	hdb: C/H/S=20510/81/228 from BIOS ignored
> > 	hdb: IBM-DTLA-307060, ATA DISK drive
> > 	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > 	hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
> > 	Partition check:
> > 		 hdb: hdb1
> > Floppy drive(s): fd0 is 1.44M
> >
> >
> >
> > from dmesg of 2.4.19rc1 ..
> >
> > PIIX4: chipset revision 1
> > PIIX4: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
> > 	ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
> > 	PDC20270: IDE controller on PCI bus 00 dev 48
> > 	PDC20270: chipset revision 2
> > 	PDC20270: not 100% native mode: will probe irqs later
> > 	ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
> > 	ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
> > 	hdb: C/H/S=20510/81/228 from BIOS ignored
> > 	hdb: IBM-DTLA-307060, ATA DISK drive
> > 	hde: WDC WD600BB-32CXA0, ATA DISK drive
> > 	hdg: WDC WD600BB-32CXA0, ATA DISK drive
> > 	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > 	ide2 at 0xb800-0xb807,0xb402 on irq 5
> > 	ide3 at 0xb000-0xb007,0xa802 on irq 5
> > 	hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
> > 	hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, (U)DMA
> > 	hdg: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, (U)DMA
> > 	Partition check:
> > 		hdb: hdb1
> > 		hde: hde1
> > 		hdg: hdg1
> > Floppy drive(s): fd0 is 1.44M
> >
> > --
> > Regards
> >
> > Klaus
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


