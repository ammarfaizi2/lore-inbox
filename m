Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268423AbTCFVxr>; Thu, 6 Mar 2003 16:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268426AbTCFVxr>; Thu, 6 Mar 2003 16:53:47 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:13316 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S268423AbTCFVxk>; Thu, 6 Mar 2003 16:53:40 -0500
Date: Thu, 6 Mar 2003 17:00:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <3E6770F3.8030207@pobox.com>
Message-ID: <Pine.LNX.3.96.1030306164559.25959A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Jeff Garzik wrote:

> Pardon the suggestion of a dumb hueristic, feel free to ignore me: 
> would it work to run-first processes that have modified their iopl() 
> level?  i.e. "if you access hardware directly, we'll treat you specially 
> in the scheduler"?
> 
> An alternative is to encourage distros to set some sort of flag for 
> processes like the X server, when it is run.  This sounds suspiciously 
> like the existing "renice X server" hack, but it could be something like 
> changing the X server from SCHED_OTHER  to SCHED_HW_ACCESS instead.
> 
> Just throwing out some things, because I care about apps which access 
> hardware from userspace :)

Well, close. But any low-latency access, even if somewhat buffered,
is likely to be user visible if unresponsive. Clearly that means video
memory like X and DRI, and sound, and mouse. If you define this generally
it would include serial as well, probably not a bad thing.

The proposal to backfeed priority from interractive processes to processes
waking them sounds useful, perhaps that might be limited a bit however.
Someone (Ingo?, Linus?) proposed limiting this to a fraction of the
priority of the interractive process, but it might be more useful to
simply limit how much could be added at one time, perhaps as a fraction of
the delta between max and current interractive bonus, which would have the
waker increase asymptomically toward max. Hysteresis is nice.

I do agree that it would be better to identify processes using physical
devices, far better than trying to identify some subset because it's
obvious.

I think this would include parallel port, although other than PL/IP I
don't think of a case where it matters much.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

