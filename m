Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266595AbSKGV5L>; Thu, 7 Nov 2002 16:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266596AbSKGV5L>; Thu, 7 Nov 2002 16:57:11 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:63240 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266595AbSKGV5J>;
	Thu, 7 Nov 2002 16:57:09 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200211072202.gA7M2Rd132519@saturn.cs.uml.edu>
Subject: Re: ps performance sucks
To: akpm@digeo.com (Andrew Morton)
Date: Thu, 7 Nov 2002 17:02:26 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), davidsen@tmr.com (Bill Davidsen),
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, jw@pegasys.ws,
       wa@almesberger.net, andersen@codepoet.org, woofwoof@hathway.com
In-Reply-To: <3DCAD5A9.D4D4C1CB@digeo.com> from "Andrew Morton" at Nov 07, 2002 01:05:45 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> "Albert D. Cahalan" wrote:

>> In case you happen to know where they are, I'm looking for these:
>>
>> pages reclaimed
>
> /proc/vmstat:pgsteal

That's a funny name for it. Sure about that? Longer description
of what I'm looking for:

    reattaches from reclaim list
        Number of pages that have been faulted while on the inactive list

To me, "pgsteal" sounds like pages grabbed from a clean list to
be used for some new purpose.

>> minor faults
>
> /proc/vmstat:pgfault - /proc/vmstat:pgmajfault
>
>> COW faults
>> zero-page faults
>
> These are not available separately

They count as minor faults?

>> anticipated short-term memory shortfall
>
> hm.  tricky.

How about these then? (and would you want them?)

a. urgency level for the need to free up memory
b. amount (or %) by which the system is overcommitted

>> pages freed
>
> /proc/vmstat:pgfree
>
> This is a little broken in 2.5.46.  pgfree is accumulated
> _before_ the per-cpu LIFO queues and pgalloc is accumulated _after_
> the per-cpu queues (or vice versa) so they're out of whack.

Can I assume it will be fixed soon? Is this a value you'd like?

>> pages scanned by page-replacement algorithm
>
> /proc/vmstat:pgscan
>
>> clock cycles by page replacement algorithm
>
> Not available.  Could sum up the CPU across all kswapd instances,
> which is a bit lame.

I suspect that it's cycles of the page aging "clock" hand,
not CPU cycles. So that would be pages scanned divided by
the average number of pages in a full scan.

>> number of system calls
>
> Not available

I though so. Bummer. I guess this is due to overhead.

>> number of forks (fork, vfork, & clone) and execs
>
> /proc/stat: processes

That's fork/vfork/clone all together, w/o execs?
(good for "vmstat -f", but poor for "vmstat -s")

Got one more:

      wired pages
          Total number of pages that are currently in use
          and cannot be used for paging

Thanks for all the help. BTW, you didn't say if you liked the
proposed changes, so I'm assuming they don't matter to you.
