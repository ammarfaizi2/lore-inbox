Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbTHTAea (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbTHTAea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:34:30 -0400
Received: from [209.195.52.120] ([209.195.52.120]:41710 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261611AbTHTAe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:34:26 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Eric St-Laurent <ericstl34@sympatico.ca>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Date: Tue, 19 Aug 2003 17:32:04 -0700 (PDT)
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
In-Reply-To: <1061338547.1000.30.camel@orbiter>
Message-ID: <Pine.LNX.4.44.0308191731230.22008-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while thinking about scaling based on CPU speed remember systems with
variable CPU clocks (or even just variable performance like the transmeta
CPU's)

David Lang

 On Tue, 19 Aug 2003, Eric St-Laurent wrote:

> Date: Tue, 19 Aug 2003 20:15:48 -0400
> From: Eric St-Laurent <ericstl34@sympatico.ca>
> To: bill davidsen <davidsen@tmr.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: scheduler interactivity: timeslice calculation seem wrong
>
> > I have to agree with Eric that sizing the max timeslices to fit the
> > hardware seems like a reasonable thing to do. I have little salvaged
> > systems running (well strolling would be more accurate) Linux on old
> > Pentium Classic 90-166MHz machines. I also have 3+ GHz SMP machines. I
> > have a gut feeling that the timeslices need to be longer on the slow
> > machines to allow them to get something done, that the SMP machines
> > will perform best with a different timeslice than UP of the same speed,
>
> scaling the timeslice with cpu_khz is a start. already there the
> smp_tune_scheduling() function that tune the load balancing based on cpu
> speed and cache size.
>
> the problem is that the tick timer (1000 hz) is pretty limited
> resolution in relation to cpu clock speed and most HZ-related
> calculations are correct within a limited range. that's why i was
> talking about cycles or nanoseconds resolution all the way.
>
> with accurate accouting we could bench the context switch time, on boot,
> and adjust timeslices based on this.. like something a 10000:1 ratio.
>
> > I think you also want a user tunable for throughput vs. interactive, so
> > you know what you're trying to do best.
>
> the kernel should have sane defauts but the user should be able to fine
> tune them. because it depends on the "intention" efficient vs
> interactivity. it's a compromise and it's not the same for server that
> desktop. middleground works but it's not the best for either.
>
> I've read a paper someday that measured the scheduler overhead about
> 0.07% for HZ=100 and 0.7% for HZ=1000. personnally i would sacrifice a
> few percent of my cpu time to have a silky-smooth interactive feel.
>
> It's bizarre that my 2 GHz P4 feel slower than my old Amiga with 33Mhz.
> Throughput is greater but latency far worst.
>
> Eric St-Laurent
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
