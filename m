Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTJ3VdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTJ3VdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:33:13 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:12786 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262881AbTJ3VdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:33:09 -0500
Message-ID: <3FA1838C.3060909@mvista.com>
Date: Thu, 30 Oct 2003 13:33:00 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: Stephen Hemminger <shemminger@osdl.org>, Gabriel Paubert <paubert@iram.es>,
       john stultz <johnstul@us.ibm.com>, Joe Korty <joe.korty@ccur.com>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
References: <20031027234447.GA7417@rudolph.ccur.com>	<1067300966.1118.378.camel@cog.beaverton.ibm.com>	<20031027171738.1f962565.shemminger@osdl.org>	<20031028115558.GA20482@iram.es>	<20031028102120.01987aa4.shemminger@osdl.org>	<20031029100745.GA6674@iram.es>	<20031029113850.047282c4.shemminger@osdl.org> <16288.17470.778408.883304@wombat.chubb.wattle.id.au>
In-Reply-To: <16288.17470.778408.883304@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:
>>>>>>"Stephen" == Stephen Hemminger <shemminger@osdl.org> writes:
> 
> 
> Stephen> On Wed, 29 Oct 2003 11:07:45 +0100 Gabriel Paubert
> Stephen> <paubert@iram.es> wrote:
> 
>>>for example.
> 
> 
> Stephen> The suggestion of using time interpolation (like ia64) would
> Stephen> make the discontinuities smaller, but still relying on fine
> Stephen> grain gettimeofday for controlling servo loops with NTP
> Stephen> running seems risky. Perhaps what you want to use is the
> Stephen> monotonic_clock which gives better resolution (nanoseconds)
> Stephen> and doesn't get hit by NTP.
> 
> monotonic_clock:
> 	-- isn't implemented for most architectures
> 	-- even for X86 only works for some timing sources
> 	-- and for the most common case is variable rate because of
> 	   power management functions changing the TSC clock rate.
> 
> As far as I know, there isn't a constant-rate monotonic clock
> available at present for all architectures in the linux kernel.  The
> nearest thing is scheduler_clock().

What you want is the POSIX clocks and timers CLOCK_MONOTONIC which is available 
on all archs (as of 2.6).  The call is:

       cc [ flag ... ] file -lrt [ library ... ]

        #include <time.h>

        int clock_gettime(clockid_t which_clock, struct timespec *setting);

where you want "which_clock" to be CLOCK_MONOTONIC.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

