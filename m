Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276576AbRKFBDt>; Mon, 5 Nov 2001 20:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276628AbRKFBDj>; Mon, 5 Nov 2001 20:03:39 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:23824 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276576AbRKFBD0>;
	Mon, 5 Nov 2001 20:03:26 -0500
Date: Mon, 5 Nov 2001 23:03:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Thomas Koeller <tkoeller@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Scheduling of low-priority background processes
In-Reply-To: <01110521533900.00641@sarkovy.koeller.org>
Message-ID: <Pine.LNX.4.33L.0111052256170.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Thomas Koeller wrote:

> On those systems, you could assign a scheduling priority lower than
> the one nomally used by interactive processes to CPU-hogging,
> numbercrunching tasks. These tasks would then use up any CPU time left
> over by interactive processes without otherwise interfering with them.
> I always found this feature very useful (think of SETI@home!).

> But that idea is so obvious, and since nobody did it so far, I am
> probably missing something. What is it?

Priority inversion.  I did a patch which does exactly
what you describe, around the 2.1 timeframe. It worked
fine most of the time, but occasionally the following
happened:

1) a SCHED_IDLE process got hold of some kernel lock
2) a normal, low-priority process started eating CPU
   for a number of seconds
3) a high-priority normal process wanted the lock the
   SCHED_IDLE task had, but had to wait several seconds,
   at times up to a minute, before the SCHED_IDLE task
   got a chance to run and release the lock

This wasn't too much of a problem on my own system, but
of course this is an easily exploitable vulnerability for
attackers.

For me, this just means we should improve the scheduler so
nice levels are stronger ... say that a nice +20 process
only gets 1% of the CPU of a normal priority process ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

