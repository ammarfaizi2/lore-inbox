Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVBXWNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVBXWNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVBXWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:13:49 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:2673 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262492AbVBXWNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:13:42 -0500
Message-ID: <421E5192.1060604@yahoo.com.au>
Date: Fri, 25 Feb 2005 09:13:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 12/13] schedstats additions for sched-balance-fork
References: <1109229491.5177.71.camel@npiggin-nld.site> <1109229542.5177.73.camel@npiggin-nld.site> <1109229650.5177.78.camel@npiggin-nld.site> <1109229700.5177.79.camel@npiggin-nld.site> <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <1109230087.5177.89.camel@npiggin-nld.site> <1109230125.5177.91.camel@npiggin-nld.site> <20050224084622.GC10023@elte.hu>
In-Reply-To: <20050224084622.GC10023@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>> [PATCH 11/13] sched-domains aware balance-on-fork
>>  [PATCH 12/13] schedstats additions for sched-balance-fork
>> [PATCH 13/13] basic tuning
> 
> 
> STREAMS numbers tricky. It's pretty much the only benchmark that 1)
> relies on being able to allocate alot of RAM in a NUMA-friendly way 2)
> does all of its memory allocation in the first timeslice of cloned
> worker threads.
> 

I know what you mean... but this is not _just_ for STREAM. Firstly,
if we start 4 tasks on one core (of a 4 socket / 8 core system), and
just let them be moved around by the periodic balancer, they will
tend to cluster on 2 or 3 CPUs, and that will be the steady state.

> There is little help we get from userspace, and i'm not sure we want to
> add scheduler overhead for this single benchmark - when something like a
> _tiny_ bit of NUMAlib use within the OpenMP library would probably solve
> things equally well!
> 

True, for OpenMP apps (and this work shouldn't stop that from happening).
But other threaded apps are also important, and fork()ed apps can be
important too.

What I hear from the NUMA guys (POWER5, AMD) is that they really want to
keep memory controllers busy. This seems to be the best way to do it.

There are a few differences between this and when we last tried it. The
main thing is that the balancer is now sched-domains aware. I hope we
can get it to do the right thing more often (at least it is a per domain
flag, so those who don't want it don't turn it on).

> Anyway, the code itself looks fine and it would be good if it improved
> things, so:
> 
>  Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> but this too needs alot of testing, and it the one that has the highest
> likelyhood of actually not making it upstream.
> 

Thanks for reviewing.

