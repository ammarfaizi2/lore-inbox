Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSIONOs>; Sun, 15 Sep 2002 09:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318038AbSIONOs>; Sun, 15 Sep 2002 09:14:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28585 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318035AbSIONOr>;
	Sun, 15 Sep 2002 09:14:47 -0400
Date: Sun, 15 Sep 2002 15:19:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020915131920.GR935@suse.de>
References: <E17odbY-000BHv-00@f1.mail.ru> <20020910062030.GL8719@suse.de> <E17qQum-0001qO-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17qQum-0001qO-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15 2002, Daniel Phillips wrote:
> On Tuesday 10 September 2002 08:20, Jens Axboe wrote:
> > On Tue, Sep 10 2002, Samium Gromoff wrote:
> > >       Hello folks, i`m looking at the DAC960 driver and i have
> > > realised its implemented at the block layer, bypassing SCSI.
> > > 
> > >    So given i have some motivation to have a working 2.5 DAC960
> > > driver (i have one, being my only controller)
> > > i`m kinda pondering the matter.
> > > 
> > >    Questions:
> > >        1. Whether we need the thing to be ported to SCSI
> > > layer, as opposed to leaving it being a generic block device? (i suppose yes)
> > 
> > No
> 
> A somewhat curt reply, it could be seen as a brush-off.  I believe the
> whole story goes something like this: the scsi system is a festering
> sore on the whole and eventually needs to be rationalized.  But until
> that happens, we should basically just keep nursing along the various
> drivers that should be using a generic interface, until there really
> is a generic interface around worth putting in the effort to port to.

Please, the scsi sub system is not a 'festering sore'. Have you even
taken a decent look at it, or just spreading the usual "I heard SCSI
dizzed somwhere" fud? Sure there's room for improvement, 2.5 has in fact
already gotten quite a lot. It's not perfect and there's still stuff
that can be cleaned up, but that doesn't mean it's crap.

> Linus indicated at the Kernel Summit that he'd like to see a
> cleaned-up scsi midlayer used as framework for *all* disk IO,
> including IDE.  Obviously, what with IDE transitions and whatnot, we
> are far from being ready to attempt that, so see "nursing along"
> above.  There's no longer any chance that a generic disk midlayer is
> going to happen in this cycle, as far as I can see.  Still, anybody
> who is interested would do well by studing the issues, and fixing
> broken drivers certainly qualifies as a way to come up to speed.

First of all, I believe Linus' plan is to push more functionality into
the block layer. Generic functionality. And in fact a lot of has already
happened there, but one does need to pay attention to that sort of thing
instead of just assuming spouting fud. Examples:

	- queue merge and dma mappings. this is all generic block/bio
	  functionality now. please compare scsi_merge.c between 2.4 and
	  2.5, if you care to.

	- highmem bounceless operation also added the possibilty to do
	  isa bouncing generically in 2.5. this is also gone from scsi.

	- request tagging. 2.5 has a generic implementation, scsi
	  transition is not complete though.

that's just off the top of my head.

So where am I going with this? I said "don't bother" to the question of
studying SCSI code, and I stand by that 100%. It would be an absolute
_waste of time_ if the goal is to make dac960 work in 2.5. I believe why
should be pretty obvious now.

Daniel, your (seen before) 'clarification' posts are not.

> > >        2. Which 2.5 SCSI driver should i use as a start of learning?
> > 
> > Don't bother
> 
> Ah, a little harsh.  I'd say: study the DAC960 driver, study the
> scsi midlayer, and study the new bio interface.  That's what I'm
> doing.

My advise is: take a look at the transition of other drivers, forget
scsi. Study of bio goes hand in hand with learning from transition of
other drivers. And note that a reasonable update of dac960 should remove
3x as much code as it adds, at least.

I can only note that so far there has been a lot of talk about dac960
and updating it, and that's about it. Talk/code ratio is very very low,
I'm tempted to just do the update myself. Might even safe some time.

-- 
Jens Axboe

