Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275994AbRJGBiL>; Sat, 6 Oct 2001 21:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276014AbRJGBiB>; Sat, 6 Oct 2001 21:38:01 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62217 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S275994AbRJGBho>; Sat, 6 Oct 2001 21:37:44 -0400
Date: Sat, 6 Oct 2001 21:33:17 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <3BBFADDC.3FDE31E7@mvista.com>
Message-ID: <Pine.LNX.3.96.1011006212945.21032A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2001, george anzinger wrote:

> Alan Cox wrote:

> > So if you used your cpu quota you will get run reluctantly. If you slept
> > you will get run early and as you use time slice count you will drop
> > priority bands, but without pre-emption until you cross a band and there
> > is another task with higher priority.
> > 
> > This damps down task thrashing a bit, and for the cpu hogs it gets the
> > desired behaviour - which is that the all run their full quantum in the
> > background one after another instead of thrashing back and forth
> 
> If I understand this, you are decreasing the priority of a task that is
> running as it consumes its slice.  In the current way of doing things
> this happens and is noticed when the scheduler gets called.  A task can
> loose its place by being preempted by some quick I/O bound task.  I.e. A
> and B are cpu hogs with A having the cpu, if task Z comes along and runs
> for 100 micro seconds, A finds itself replace by B, where as if Z does
> not come along, A will complete its slice.  It seems to me that A should
> be first in line after Z and not bumped just because it has used some of
> its slice.  This would argue for priority being set at slice renewal
> time and left alone until the task blocks or completes its slice.

  It certainly argues for continuing to run the process with the unexpired
timeslice, becausle it is most likely to have current data in caches of
every type.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

