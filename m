Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278617AbRKFIIg>; Tue, 6 Nov 2001 03:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278630AbRKFIIQ>; Tue, 6 Nov 2001 03:08:16 -0500
Received: from mail009.syd.optusnet.com.au ([203.2.75.170]:689 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S278617AbRKFIIK>; Tue, 6 Nov 2001 03:08:10 -0500
Date: Tue, 6 Nov 2001 19:07:57 +1100
To: linux-kernel@vger.kernel.org
Cc: riel@conectiva.com.br
Subject: Re: Scheduling of low-priority background processes
Message-ID: <20011106190757.A28090@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0111052256170.2963-100000@imladris.surriel.com>
From: Kevin Easton <s3159795@student.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On those systems, you could assign a scheduling priority lower than 
> > the one nomally used by interactive processes to CPU-hogging, 
> > numbercrunching tasks. These tasks would then use up any CPU time left 
> > over by interactive processes without otherwise interfering with them. 
> > I always found this feature very useful (think of SETI@home!). 
>
>
> > But that idea is so obvious, and since nobody did it so far, I am 
> > probably missing something. What is it? 
>
>
> Priority inversion. I did a patch which does exactly 
> what you describe, around the 2.1 timeframe. It worked 
> fine most of the time, but occasionally the following 
> happened: 
>
>
> 1) a SCHED_IDLE process got hold of some kernel lock 
> 2) a normal, low-priority process started eating CPU 
>    for a number of seconds 
> 3) a high-priority normal process wanted the lock the 
>    SCHED_IDLE task had, but had to wait several seconds, 
>    at times up to a minute, before the SCHED_IDLE task 
>    got a chance to run and release the lock 
>
>
> This wasn't too much of a problem on my own system, but 
> of course this is an easily exploitable vulnerability for 
> attackers. 
>
>
> For me, this just means we should improve the scheduler so 
> nice levels are stronger ... say that a nice +20 process 
> only gets 1% of the CPU of a normal priority process ;) 
>

What if the SCHED_IDLE behaviour only applies when the process
is in userspace?  Couldn't scheduler compare the process's
instruction pointer against the kernel/user break point, and
if the process is in the kernel, then just treat it like a
normal process?

>
> regards, 
>
>
> Rik 

