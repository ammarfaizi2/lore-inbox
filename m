Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315295AbSDWTE6>; Tue, 23 Apr 2002 15:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315307AbSDWTE5>; Tue, 23 Apr 2002 15:04:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12275 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315295AbSDWTE4>;
	Tue, 23 Apr 2002 15:04:56 -0400
Message-ID: <3CC5B018.AE8E2F97@mvista.com>
Date: Tue, 23 Apr 2002 12:03:52 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: John Alvord <jalvo@mbay.net>, Pavel Machek <pavel@suse.cz>,
        davidm@hpl.hp.com, Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <Pine.LNX.4.20.0204221019280.20972-100000@otter.mbay.net> <3CC4861C.F21859A6@mvista.com> <20020422232627.GA5527@krispykreme>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> 
> > Please folks.  When can we put the "tick on demand" thing to bed?  If in
> > doubt, get the patch from the high-res-timers sourceforge site (see
> > signature for the URL) and try it.  Overhead becomes higher with system
> > load passing the ticked system at relatively light loads.  Just what we
> > want, very low overhead idle systems!
> >
> > The problem is in accounting (or time slicing if you prefer) where we
> > need to start a timer each time a task is context switched to, and stop
> > it when the task is switched away.  The overhead is purely in the set up
> > and tear down.  MOST of these never expire.
> 
> Did you work out where exactly the overhead was and if it was hardware
> specific? On ppc for example updating the timer is just a write to a cpu
> register.

It has nothing to do with hardware.  The over head is putting a timer
entry in the list and then removing it.  Almost all timers are canceled
before they expire.  Even with the O(1) timer list, this takes time and
when done at the context switch rate the time mounts rapidly.  And we
need at least one timer when we switch to a task.  In the test code I
only start a "slice" timer.  This means that a task that wants a
execution time signal may find the signal delayed by as much as a slice,
but it does keep the overhead lower.
> 
> Anton

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
