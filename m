Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263521AbTC3FvD>; Sun, 30 Mar 2003 00:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263522AbTC3FvD>; Sun, 30 Mar 2003 00:51:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13320
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263521AbTC3FvB>; Sun, 30 Mar 2003 00:51:01 -0500
Date: Sat, 29 Mar 2003 21:58:48 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Jeremy Jackson <jerj@coplanar.net>, linux-kernel@vger.kernel.org
Subject: Re: linux kernel IDE development process question
In-Reply-To: <Pine.SOL.4.30.0303291815560.27420-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10303292154361.5484-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bart,

When you do, let me know.
I would like to suggest how to decouple the hwgroup in general but not
lose it because of a need to sync the iops during setup and hba recovery.
The dirt on why it has to be done is not public per NDA's, but this will
help the driver.  Additionally, movement to create hwif->queue for
load-balance and threading of the channel IO is a must now.  As SATA
arrives in bulk, their will be more effective hwif's per hba and the
rules for assignment must change.

Cheers,

On Sat, 29 Mar 2003, Bartlomiej Zolnierkiewicz wrote:

> 
> Hey,
> 
> On 29 Mar 2003, Jeremy Jackson wrote:
> 
> > Hello IDE people,
> >
> > I'd like to get input from everyone involved in drivers/ide/ on the
> > current development process.
> >
> > I would like to know what code is kept in sync between 2.4/2.5
> > (2.2/2.0?).  This way I can start by understanding what is already being
> > done. This is related to the recent "hdparm and removable IDE?" thread
> > on LKML.
> >
> > I would like to start by declaring ide_hwifs[] static, and removing the
> > extern ide_hwifs from ide.h.  all references to ide_hwifs[] will be
> > converted to macros and/or access method functions, that return a
> > pointer to a particular ide_hwifs_t.  for_each_hwif() and replacements
> > for whatever else is in use will be provided as well, initially just
> > doing the same thing that is done now, ie iterating through ide_hwifs[].
> 
> Yes, I've been thinking about this recently and I think this is the way to
> go.
> 
> > There's more to my plan, that's just to get the discussion going.  I
> > will only address what can be easily merged into all currently supported
> > kernel trees, I just need to know what they are.
> 
> If it will be merged any time soon you may call yourself lucky :-).
> 
> > by creating a new file ide-kernel.[ch], and moving the ide_hwifs[] and
> > accessor functions to it, each kernel tree can implement it differently
> > without complicating backports for the common stuff.  Initially the
> > changes will *not* alter any behaviour, just jockeying stuff into place
> 
> You should just commit changes to 2.5 and later port it to 2.4.
> 
> > to make that painless when the time comes.  (think about it: if the
> > access methods return pointers, who's going to notice when ide_hwifs[]
> > is replaced with a linked list?)
> 
> Yep, but probably there will be some problems in transition.
> 
> > My motivation: I'd *really* like to be able to sell entry level PC
> > servers with hotswap raid1.  I'm not in a hurry, baby steps are ok, I
> > just want to get the ball rolling.  It's all negotiable.  I'm no expert
> > here.
> >
> > Regards,
> >
> > Jeremy
> > --
> > Jeremy Jackson <jerj@coplanar.net>
> 
> Regards
> --
> Bartlomiej Zolnierkiewicz
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

