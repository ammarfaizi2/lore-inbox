Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317780AbSGKHRj>; Thu, 11 Jul 2002 03:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317781AbSGKHRi>; Thu, 11 Jul 2002 03:17:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53751 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317780AbSGKHRf>;
	Thu, 11 Jul 2002 03:17:35 -0400
Message-ID: <3D2D319B.D081A7D3@mvista.com>
Date: Thu, 11 Jul 2002 00:19:55 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Jesse Barnes <jbarnes@sgi.com>, Andreas Dilger <adilger@clusterfs.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SPsV-00028p-00@starship> <20020710233616.GA696482@sgi.com> <E17SWXm-0002BL-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Thursday 11 July 2002 01:36, Jesse Barnes wrote:
> > On Thu, Jul 11, 2002 at 12:24:06AM +0200, Daniel Phillips wrote:
> > > Acme, which is to replace all those above-the-function lock coverage
> > > comments with assert-like thingies:
> > >
> > >    spin_assert(&pagemap_lru_lock);
> > >
> > > And everbody knows what that does: when compiled with no spinlock
> > > debugging it does nothing, but with spinlock debugging enabled, it oopses
> > > unless pagemap_lru_lock is held at that point in the code.  The practical
> > > effect of this is that lots of 3 line comments get replaced with a
> > > one line assert that actually does something useful.  That is, besides
> > > documenting the lock coverage, this thing will actually check to see if
> > > you're telling the truth, if you ask it to.
> > >
> > > Oh, and they will stay up to date much better than the comments do,
> > > because nobody needs to to be an ueber-hacker to turn on the option and
> > > post any resulting oopses to lkml.
> >
> > Sounds like a great idea to me.  Were you thinking of something along
> > the lines of what I have below or perhaps something more
> > sophisticated?  I suppose it would be helpful to have the name of the
> > lock in addition to the file and line number...
> 
> I was thinking of something as simple as:
> 
>    #define spin_assert_locked(LOCK) BUG_ON(!spin_is_locked(LOCK))
> 
> but in truth I'd be happy regardless of the internal implementation.  A note
> on names: Linus likes to shout the names of his BUG macros.  I've never been
> one for shouting, but it's not my kernel, and anyway, I'm happy he now likes
> asserts.  I bet he'd like it more spelled like this though:
> 
>    MUST_HOLD(&lock);
> 
> And, dare I say it, what I'd *really* like to happen when the thing triggers
> is to get dropped into kdb.  Ah well, perhaps in a parallel universe...

I should hope that, when BUG executes the unimplemented
instruction, it does go directly to kdb.  It certainly does
with my kgdb, as do all Oops, NULL dereferences, etc., etc.
> 
> When one of these things triggers I do think you want everything to come to
> a screeching halt, since, to misquote Matrix, "you're already dead", and you
> don't want any one-per-year warnings to slip off into the gloomy depths of
> some forgotten log file.
> 
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
