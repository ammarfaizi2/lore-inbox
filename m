Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135210AbRDVEMJ>; Sun, 22 Apr 2001 00:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135208AbRDVEL7>; Sun, 22 Apr 2001 00:11:59 -0400
Received: from [24.219.123.215] ([24.219.123.215]:8964 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135209AbRDVELq>; Sun, 22 Apr 2001 00:11:46 -0400
Date: Sat, 21 Apr 2001 21:10:28 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
cc: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Paul Flinders <P.Flinders@ftel.co.uk>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <3ADDF370.FAEF5117@gmx.at>
Message-ID: <Pine.LNX.4.10.10104212104160.627-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, Wilfried Weissmann wrote:

> > off to the head or tail of the drive and get me that raid-voodoo-bios-os
> > communication transport layer, and do it ins DMA modes, NOW!"
> 
> "voodoo" would be the sector where the raid configuration is stored
> then, right!? Maybe I did not understand you properly...

We are on the same page, good.

> I am really trying to understand what you want to do. From what I have
> seen this would go into kernel 2.5 first. For now there appears to be no
> information or this-would-be-new-in-2.5 list available of new
> development kernel so far, so I have to use my fantasy even more.
> So you want to introduce a new layer between the MD driver and the ATA
> HDs of IDE-RAIDs. This code would be placed in the ide-chipset driver.
> Configuration happens at system startup after the chipset is in service.
> There you read the config-sector (e.g. sector 9 on HPTs) of the disks
> and datafill your configuration tables. Plus you start one (or more) MD
> device with the according raid level(s). The MD then accesses your layer
> instead of talking directly to the disk driver, and the requests are
> mapped (buffer_head->rsector+10 with the HPTs) as the bios would do it.
> But the raid is still handled by MD. So you can completely reuse the
> raid code for all that.
> Pardon me, but please tell me that I am wrong, because this sounds odd
> to me! <:(
> 
> Talking about the API... These should be the basic steps that we need to
> do (unordered, this is just brainstorming):
> 
> *) device_size_calculation() should use a callback of the raid level to
> get the device size. Or the code should be completly moved over to the
> <raid level>_run()'s.
> 
> *) Hide/unhide disks from the userland (this is just a cosmetic issue).

Disks must be visable, always, but blocked from direct mounting.

> *) Shift sectors and shrink capacity of disks so that the existing raid
> levels can access the disks according to the ata-raid layout.

Yep.

> *) Get the configuration sector from disk. Analyse the configuration and
> setup disks and md-devices.

Yep and update the status of the raid if we have a device fail.

> *) All raid pers. must be able to handle I/O that requests sectors from
> more than only one disk.

Yep

> *) Partitioned raid devices must be handled somehow.

Yep

> > 
> > I do not have the desire to do personality tables, but I can.

> > With about 96% of all linux boxes in the world dependent on some form of
> > ATA/ATAPI, Linus and Alan are very sensitive to even the sligthest change.
> 
> I would avoid to change anything there, but do a raid personality...
> Well, we are back at our your solution vs. my raid personality
> discussion again!

No we are back to your "raid personality", and a functional API to the
ATA driver.

This is probably the first and last time I will openly agree for someone
to tell me were to go, and do it ;-).

You tell me what you want the driver to do, and I will make it happen.
It will be legal and technically correct.  Does that sound like a good
idea?

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

