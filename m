Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314838AbSDVVxJ>; Mon, 22 Apr 2002 17:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314839AbSDVVxJ>; Mon, 22 Apr 2002 17:53:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63222 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314838AbSDVVxH>;
	Mon, 22 Apr 2002 17:53:07 -0400
Message-ID: <3CC4861C.F21859A6@mvista.com>
Date: Mon, 22 Apr 2002 14:52:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Alvord <jalvo@mbay.net>
CC: Pavel Machek <pavel@suse.cz>, davidm@hpl.hp.com,
        Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <Pine.LNX.4.20.0204221019280.20972-100000@otter.mbay.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord wrote:
> 
> On Sun, 21 Apr 2002, Pavel Machek wrote:
> 
> > Hi!
> >
> > >   Davide> i still have pieces of paper on my desk about tests done on
> > >   Davide> my dual piii where by hacking HZ to 1000 the kernel build
> > >   Davide> time went from an average of 2min:30sec to an average
> > >   Davide> 2min:43sec. that is pretty close to 10%
> > >
> > > The last time I measured timer tick overhead on ia64 it was well below
> > > 1% of overhead.  I don't really like using kernel builds as a
> > > benchmark, because there are far too many variables for the results to
> > > have any long-term or cross-platform value.  But since it's popular, I
> > > did measure it quickly on a relatively slow (old) Itanium box: with
> > > 100Hz, the kernel compile was about 0.6% faster than with 1024Hz
> > > (2.4.18 UP kernel).
> >
> > .5% still looks like a lot to me. Good compiler optimization is .5% on
> > average...
> >
> > And think what it does with old 386sx.. Maybe time for those "tick on demand"
> > patches?
> 
> Doesn't IBM have a tickless patch.. useful when demonstrating 10,000
> virtual linux machines on a single system.

Please folks.  When can we put the "tick on demand" thing to bed?  If in
doubt, get the patch from the high-res-timers sourceforge site (see
signature for the URL) and try it.  Overhead becomes higher with system
load passing the ticked system at relatively light loads.  Just what we
want, very low overhead idle systems!  

The problem is in accounting (or time slicing if you prefer) where we
need to start a timer each time a task is context switched to, and stop
it when the task is switched away.  The overhead is purely in the set up
and tear down.  MOST of these never expire.

-g
> 
> john alvord
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
