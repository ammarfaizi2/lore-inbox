Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311531AbSCNF5i>; Thu, 14 Mar 2002 00:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311534AbSCNF53>; Thu, 14 Mar 2002 00:57:29 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56074
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311531AbSCNF5T>; Thu, 14 Mar 2002 00:57:19 -0500
Date: Wed, 13 Mar 2002 21:56:08 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: ide driver broken in PIO mode
In-Reply-To: <20020313203719.GE20220@suse.de>
Message-ID: <Pine.LNX.4.10.10203132139070.21396-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

How about telling me this much since you are claiming an answer and
solution.  Where exactly do you plan to determine whether the current
device data block is a success or failure?  This is regardless of read or
write direction.

For the record the single sector transfers do not handle this case either.

Maybe if the two of you will provide some room to get work done, I can
finish what I started and get out of your way.

As it is clear I am being shown the door.

I will go soon enough but I owe it to the folks out there to finish
something I started which I have wait to see if anyone could finish, this
includes the newly appointed Martin.

Your answer is incomplete, Jens.

However, I will stand back and let you do it and then proceed in a lab
with analyzers to provide the traces of short comings.

Regards,

Andre

On Wed, 13 Mar 2002, Jens Axboe wrote:

> On Wed, Mar 13 2002, Andre Hedrick wrote:
> > On Wed, 13 Mar 2002, Linus Torvalds wrote:
> > 
> > > In article <Pine.LNX.4.21.0203131339050.26768-100000@serv>,
> > > Roman Zippel  <zippel@linux-m68k.org> wrote:
> > > >
> > > >I first noticed the problem on my Amiga, but I can reproduce it on an ia32
> > > >machine, when I turn off dma with hdparm.
> > > 
> > > With PIO, the current IDE/bio stuff doesn't like the write-multiple
> > > interface and has bad interactions. 
> > > 
> > > Jens, you talked about a patch from Supparna two weeks ago, any
> > > progress?
> > 
> > Linus,
> > 
> > Suparna understands the problem and it is a solution I have described,
> > and I have been working with her on a solution but I suspect you will not
> > take it.  Because it requires an in process operation of traversing
> > several BIOS' in order to statisfy the hardware atomic.  Until you figure
> > out, you can not have the partial completion update to the granularity of
> > a single page or single bio it can not be fixed.  You have to permit the
> > hardware to satisfy its needs and have an active in process list it will
> > never work.
> 
> Again, this is not needed, there are two ways at doing this. One is to
> traverse the segments and setup the drive for the full transfer with
> write (or read) multi. Drive will expect nr_sectors transfer and do it
> xx sectors of the time as programmed by set multi. The other approach is
> what I tried last time (but with the early-interrupt fixed), just
> program the drive for no more than current_nr_sectors and simply let the
> command request nr_sectors / current_nr_sectors times.
> 
> The latter approach also satisfies 'the hardware atomic' as you call it.
> 
> > So let me know when you want a solution that is correct and proper to the
> 
> Still all talk, I'm guessing.
> 
> > The fact is a few people understand the problem and the solution.
> > By now I think you are just now getting the problem.
> 
> No the fact is that you _think_ only a few people understand the
> problem.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


