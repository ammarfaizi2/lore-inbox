Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316964AbSEWRii>; Thu, 23 May 2002 13:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSEWRih>; Thu, 23 May 2002 13:38:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9982 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316964AbSEWRig>;
	Thu, 23 May 2002 13:38:36 -0400
Message-ID: <3CED1AF4.7170970@mvista.com>
Date: Thu, 23 May 2002 09:38:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Seppanen <eds@reric.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: via timer/clock problem workaround
In-Reply-To: <20020522221859.A24041@reric.net> <3CECB24E.D41B1527@mvista.com> <20020523103340.A27767@reric.net> <3CED076C.20C24B23@mvista.com> <20020523113943.A28069@reric.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Seppanen wrote:
> 
> On Thu, May 23, 2002 at 08:14:52AM -0700, george anzinger wrote:
> > It occurs to me that you could be MUCH more aggressive in
> > your fault detection.  Since the code you are detecting the
> > fault in is interruptable, (i.e. if a timer interrupts were
> > happening they surly would happen at this time) you should
> > be able to safely assume that a value greater than, oh say
> > 1.5*1/HZ IS a fault.  You could then, immediately do the
> > "fix" code.  Note that it is not enough to just restart the
> > time since it is now out of step with xtime.  The update I
> > suggested should fix things to oh say about a 10 usec or
> > less hiccup.
> 
> OK, makes sense.  My focus for now was to figure out how to detect the
> situation.  Since the offset returned is 71 minutes into the future, the
> number I chose (~1 second) wasn't real important.
> 
> > The unfortunate thing about the fix is that execution of the
> > detection code requires some one to request the time of
> > day.  This, of course, could be delayed by an arbitrary
> > time, depending on system activity.
> 
> Good point.  Looking at it from that perspective, it may be a waste of
> time to put fixes in do_gettimeofday().  A dead timer is pretty serious,
> and I can't think of a simple way to detect it.  A slower, backup timer
> would be an option.  Or maybe doing a timer-sanity-check every _x_
> interrupts.  But good luck getting that past Linus/Marcelo :)
> 
> Best thing would be to figure out what's wrong with the timer and try to
> find a way to use the timer that doesn't suffer this problem.  I don't
> have any good ideas to try here, however.

It would be good to have some input from VIA on this, but I
can not find any errata on this (or anything else for that
matter-- they must make perfect chips :).

If you have an SMP box, there are other timers (in the APIC)
that generate interrupts, but, of course, most do not have
SMP boxen.  The ONLY thing in a UP box that generates a
stream of interrupts with out being acknowledged is the
PIT.  This is why it drives the NMI stuff in SMP boxes, for
example.  There are other watchdogs, but I think they
require special hardware.

On the other hand, WHY does the box need to be busy for this
to fail?  From the timer point of view, exactly what is
busy?  I wonder if it is a voltage sag or some such.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
