Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTFDBSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 21:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTFDBSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 21:18:54 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30990
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262568AbTFDBSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 21:18:52 -0400
Date: Tue, 3 Jun 2003 18:21:12 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mauk van der Laan <mauk.lists@maatwerk.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: siimage slow on 2.4.21-rc6-ac2
In-Reply-To: <3EDD49FA.2080407@maatwerk.net>
Message-ID: <Pine.LNX.4.10.10306031819520.27756-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




static byte siimage_ratemask (ide_drive_t *drive)

or whatever the new name is:

        switch(dev->device) {
                case PCI_DEVICE_ID_CMD_3112:

+                       drive->id->hwconfig |= 0x6000;

Insert in your drivers/ide/pci/siimage.c



On Wed, 4 Jun 2003, Mauk van der Laan wrote:

> 
> He is right. I did several tests and it is the max_kb setting
> that does it, not the fact that I programmed both disks.
> Sorry to have put you in the wrong direction.
> 
> By the way, the autodma code doesnt seem to do anything?
> 
> Mauk
> 
> 
> Andre Hedrick wrote:
> 
> >NO, it is not irrelevant.
> >
> >Seagate and Silicon Image are the only two player (well intel now) who did
> >their own PHY.  They did not use the Marvel pairs.
> >
> >It is a function of possible ECC on the wire and the relation to the
> >segments in the PIO or SG operations.  It is a FIFO issue based on 512byte
> >boundaries being breached on corner cases.
> >
> >The data on the wire is in 8K units.
> >
> >It is a 7.5K + 0.5K corner case.
> >
> >max_kb_per_request:15 == 7.5K
> >
> >This prevents this corner case until I can code the proper special case SG
> >table.
> >
> >drive->id->hwconfig |= 0x6000;
> >
> >Is needed to fake the driver for device side cable detect.
> >There are several issues and I have not had time to keep up.
> >
> >I have to do other business ventures because being an independent
> >developer/contract no longer can pay the bills.  More proof that free
> >drivers and free software still has a cost to somebody.
> >
> >Cheers,
> >
> >On 3 Jun 2003, Alan Cox wrote:
> >
> >  
> >
> >>On Maw, 2003-06-03 at 23:48, Mauk van der Laan wrote:
> >>    
> >>
> >>>He! I just did
> >>>
> >>># hdparm -d1 -X66 /dev/hdX
> >>># echo "max_kb_per_request:15" > /proc/.ide/hdX/settings
> >>>
> >>>on BOTH sata drives and everything works fine!
> >>>Is it possible that they influence each other?
> >>>      
> >>>
> >>Not as I understand it, but this is rather useful information. The SI
> >>does have some ties for PIO mode but not UDMA clocking. This is most
> >>interesting information.
> >>
> >>The max_kb_per thing should be irrelevant btw.
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>    
> >>
> >
> >Andre Hedrick
> >LAD Storage Consulting Group
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >  
> >
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

