Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbTCYEIO>; Mon, 24 Mar 2003 23:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbTCYEIO>; Mon, 24 Mar 2003 23:08:14 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8978 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261439AbTCYEIL>; Mon, 24 Mar 2003 23:08:11 -0500
Date: Mon, 24 Mar 2003 20:16:33 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alexander Atanasov <alex@ssi.bg>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@brodo.de,
       linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: ide: indeed, using list_for_each_entry_safe removes endless
 looping / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
In-Reply-To: <20030324192451.13aa10b2.alex@ssi.bg>
Message-ID: <Pine.LNX.4.10.10303242014430.8000-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is one thing all of you don't get about hotplug.

You are not allowed on PATA, only SATA.

The BIOS and setup on the HBA's need a kick to come alive.
There are basic hooks that do not permit post boot hotplug in PATA.

Cheers,

On Mon, 24 Mar 2003, Alexander Atanasov wrote:

> 	Hello, Alan!
> 
> On 24 Mar 2003 17:40:08 +0000
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > On Mon, 2003-03-24 at 16:01, Alexander Atanasov wrote:
> > > 	I don't understand, what's the difference and how the list is
> > > 	lost?
> > > ata_unused used to hold all drives that were not claimed by any
> > > driver, now idedefault_driver claims all that drives, all drives go
> > > in the .list
> > 
> > ata_unused -> unattached device slots, new hotplug discoveries
> 
> 	Ok. 
> 
> > idedefault_driver -> attached/known devices with no driver
> > other list -> driven by that driver
> > 
> > > The bug is there,  and waiting to explode, keeping both lists would
> > > mean to add one more  list head  in ide_drive_t,  is that the fix
> > > you want?
> > 
> > I don't see where stuff is ending up on both lists yet. I've not had
> > time to look hard at it though
> > 
> 
> 	It happens this way:
> 	ide_register_driver -> ata_attach -> idedefault_driver.attach -> ide_register_subdriver -> list_add(&driver->list, &driver->drives) ->
> return to ata_attach -> list_add_tail(&drive->list, &ata_unused);
> 	
> --
> have fun,
> alex
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

