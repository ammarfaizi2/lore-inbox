Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311356AbSCMUiM>; Wed, 13 Mar 2002 15:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311324AbSCMUiC>; Wed, 13 Mar 2002 15:38:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29708 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311352AbSCMUho>;
	Wed, 13 Mar 2002 15:37:44 -0500
Date: Wed, 13 Mar 2002 21:37:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: ide driver broken in PIO mode
Message-ID: <20020313203719.GE20220@suse.de>
In-Reply-To: <a6o30m$25j$1@penguin.transmeta.com> <Pine.LNX.4.10.10203131001230.19703-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10203131001230.19703-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13 2002, Andre Hedrick wrote:
> On Wed, 13 Mar 2002, Linus Torvalds wrote:
> 
> > In article <Pine.LNX.4.21.0203131339050.26768-100000@serv>,
> > Roman Zippel  <zippel@linux-m68k.org> wrote:
> > >
> > >I first noticed the problem on my Amiga, but I can reproduce it on an ia32
> > >machine, when I turn off dma with hdparm.
> > 
> > With PIO, the current IDE/bio stuff doesn't like the write-multiple
> > interface and has bad interactions. 
> > 
> > Jens, you talked about a patch from Supparna two weeks ago, any
> > progress?
> 
> Linus,
> 
> Suparna understands the problem and it is a solution I have described,
> and I have been working with her on a solution but I suspect you will not
> take it.  Because it requires an in process operation of traversing
> several BIOS' in order to statisfy the hardware atomic.  Until you figure
> out, you can not have the partial completion update to the granularity of
> a single page or single bio it can not be fixed.  You have to permit the
> hardware to satisfy its needs and have an active in process list it will
> never work.

Again, this is not needed, there are two ways at doing this. One is to
traverse the segments and setup the drive for the full transfer with
write (or read) multi. Drive will expect nr_sectors transfer and do it
xx sectors of the time as programmed by set multi. The other approach is
what I tried last time (but with the early-interrupt fixed), just
program the drive for no more than current_nr_sectors and simply let the
command request nr_sectors / current_nr_sectors times.

The latter approach also satisfies 'the hardware atomic' as you call it.

> So let me know when you want a solution that is correct and proper to the

Still all talk, I'm guessing.

> The fact is a few people understand the problem and the solution.
> By now I think you are just now getting the problem.

No the fact is that you _think_ only a few people understand the
problem.

-- 
Jens Axboe

