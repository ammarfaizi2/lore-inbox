Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130692AbQKQCER>; Thu, 16 Nov 2000 21:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbQKQCEH>; Thu, 16 Nov 2000 21:04:07 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:54668 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130692AbQKQCDv>; Thu, 16 Nov 2000 21:03:51 -0500
Message-Id: <5.0.0.25.2.20001117013109.00a5aeb0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Fri, 17 Nov 2000 01:34:14 +0000
To: Andre Hedrick <andre@linux-ide.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: sorted - was: How to add a drive to DMA black list?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011161725300.6910-100000@master.linux-ide.
 org>
In-Reply-To: <5.0.0.25.2.20001117011804.00a5eb50@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sure you knew this perfectly well already but just in case it is helpful:

the offending code is in:

drivers/ide/piix.c::piix_dmaproc [starts on line 402 in 2.4.0-test11-pre5]

It calls piix_config_drive_for_dma and only then calls ide_dmaproc.

It is ide_dmaproc that does the good/bad test so obviously it is called too 
late.

Anton

At 01:26 17/11/2000, Andre Hedrick wrote:

>Then I need to fix that to prevent the bypass that should not happen.
>
>On Fri, 17 Nov 2000, Anton Altaparmakov wrote:
>
> > The drive was being added to the black lists fine it's just that I had 
> PIIX
> > tuning enabled which caused the good/bad dma tables check to be bypassed
> > completely. - So disabling PIIX tuning made my PC boot fine.
> >
> > Regards,
> >
> > Anton
> >
> > At 00:13 17/11/2000, Anton Altaparmakov wrote:
> > >Hello all,
> > >
> > >I have an ide hard drive that misbehaves when the option "enable DMA at
> > >boot time" (2.4.x kernel) is selected (this is on a on board ide
> > >controller). But on the other hand I have a Promise Ultra-ATA-100
> > >controller with an IBM ATA-100 drive that, according to the menuconfig
> > >information and the information at the top of the driver requires the
> > >"enable DMA at boot time" feature to be selected.
> > >
> > >I tried adding the string that is output for the bad drive by hdparm -i
> > >into drivers/ide/ide-dma.c::drive_blacklist and
> > >drivers/ide/ide-dma.c::bad_dma_drives but the kernel still says that 
> it is
> > >using DMA and the kernel hangs after displaying:
> > >
> > >PIIX: chipset revision 2
> > >PIIX: not 100% native mode: will probe irqs later
> > >[snip]
> > >PDC20267: IDE controller on PCI bus 00 dev 98
> > >PDC20267: chipset revision 2
> > >PDC20267: not 100% native mode: will probe irqs later
> > >PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
> > >[snip]
> > >hdc: Conner Peripherals 1275MB - CFS1275A, ATA DISK drive
> > >hde: IBM-DTLA-307045, ATA DISK drive
> > >[snip]
> > >hdc: 2496876 sectors (1278 MB) w/64KiB Cache, CHS=2477/16/63, DMA
> > >hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63. 
> UDMA(100)
> > >Partition check:
> > >  hda: hda1 hda2 < hda5 >
> > >  hdc:hdc: timout waiting for DMA
> > >ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > >hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> > >_
> > >Dead.
> > >
> > >What should I do? Thanks in advance,
> > >
> > >Anton
> > >
> > >--
> > >      "Education is what remains after one has forgotten everything he
> > > learned in school." - Albert Einstein
> > >--
> > >Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) /
> > >+44-(0)7712-632205(mobile)
> > >Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
> > >Cambridge CB2 3BU    ICQ: 8561279
> > >United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> > >
> > >-
> > >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > >the body of a message to majordomo@vger.kernel.org
> > >Please read the FAQ at http://www.tux.org/lkml/
> >
> > --
> >       "Education is what remains after one has forgotten everything he
> > learned in school." - Albert Einstein
> > --
> > Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / 
> +44-(0)7712-632205(mobile)
> > Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
> > Cambridge CB2 3BU    ICQ: 8561279
> > United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> >
>
>Andre Hedrick
>CTO Timpanogas Research Group
>EVP Linux Development, TRG
>Linux ATA Development
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/

-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
