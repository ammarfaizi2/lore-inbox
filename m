Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbUL2Pka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUL2Pka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 10:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUL2Pka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 10:40:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38818 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261361AbUL2PkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 10:40:17 -0500
Subject: Re: PATCH: 2.6.10 - Still mishandles volumes without geometry data
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041229025212.GA2818@pclin040.win.tue.nl>
References: <1104155840.20898.3.camel@localhost.localdomain>
	 <58cb370e041228124878cb6e2a@mail.gmail.com>
	 <1104271702.26131.11.camel@localhost.localdomain>
	 <20041229025212.GA2818@pclin040.win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104330967.30080.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Dec 2004 14:36:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-29 at 02:52, Andries Brouwer wrote:
> > +	/* No non-LBA info .. so valid! */
> > +	if (id->cyls == 0)
> > +		return 1;
> > +		
> >  	/*
> >  	 * The ATA spec tells large drives to return
> >  	 * C/H/S = 16383/16/63 independent of their size.
> 
> Reasonable in case this actually occurs. Do you have examples?

Yes - raid volumes on IT8212 is one such example.

> > -		pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
> > +		if(cyl)
> > +			pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
> >  
> >  		hwif->OUTB(0x00, IDE_FEATURE_REG);
> >  		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
> 
> Unreasonable. This part must be a misunderstanding.
> The cyl here is not the number of cylinders of a disk,

Yep - as Bartlomiej correctly noted this was a mismerge when I fixed up
to 2.6.10

> > -	printk(", CHS=%d/%d/%d", 
> > -	       drive->bios_cyl, drive->bios_head, drive->bios_sect);
> > +	if(drive->bios_cyl)
> > +		printk(", CHS=%d/%d/%d", 
> > +			drive->bios_cyl, drive->bios_head, drive->bios_sect);
> >  	if (drive->using_dma)
> >  		ide_dma_verbose(drive);
> >  	printk("\n");
> 
> Reasonable. (But s/if(/if (/ .)
> On the other hand, I like the "CHS=0/0/0" - it makes very clear what is wrong
> in case lilo or so has geometry problems.

0/0/0 is valid in these cases - would it be better if it printed
something else instead for that situation ("No physical geometry, ")
perhaps ?

