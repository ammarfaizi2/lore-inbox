Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbTHWAaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 20:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTHWAaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 20:30:21 -0400
Received: from dyn-ctb-210-9-245-87.webone.com.au ([210.9.245.87]:56585 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261591AbTHWAaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 20:30:12 -0400
Message-ID: <3F46B561.7060706@cyberone.com.au>
Date: Sat, 23 Aug 2003 10:29:21 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: habanero@us.ibm.com
CC: Bill Davidsen <davidsen@tmr.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>,
       torvalds@osdl.org, mingo@elte.hu
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
References: <Pine.LNX.3.96.1030813163849.12417I-100000@gatekeeper.tmr.com> <200308221046.31662.habanero@us.ibm.com> <3F469FA4.6020203@cyberone.com.au> <200308221912.38184.habanero@us.ibm.com>
In-Reply-To: <200308221912.38184.habanero@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Theurer wrote:

>On Friday 22 August 2003 17:56, Nick Piggin wrote:
>
>>Andrew Theurer wrote:
>>
>>>On Wednesday 13 August 2003 15:49, Bill Davidsen wrote:
>>>
>>>>On Mon, 28 Jul 2003, Andrew Theurer wrote:
>>>>
>>>>>Personally, I'd like to see all systems use NUMA sched, non NUMA systems
>>>>>being a single node (no policy difference from non-numa sched), allowing
>>>>>us to remove all NUMA ifdefs.  I think the code would be much more
>>>>>readable.
>>>>>
>>>>That sounds like a great idea, but I'm not sure it could be realized
>>>>short of a major rewrite. Look how hard Ingo and Con are working just to
>>>>get a single node doing a good job with interactive and throughput
>>>>tradeoffs.
>>>>
>>>Actually it's not too bad.  Attached is a patch to do it.  It also does
>>>multi-level node support and makes all the load balance routines
>>>runqueue-centric instead of cpu-centric, so adding something like shared
>>>runqueues (for HT) should be really easy.  Hmm, other things: inter-node
>>>balance intervals are now arch specific (AMD is "1").  The default
>>>busy/idle balance timers of 200/1 are not arch specific, but I'm thinking
>>>they should be.  And for non-numa, the scheduling policy is the same as
>>>it was with vanilla O(1).
>>>
>>I'm not saying you're wrong, but do you have some numbers where this
>>helps? ie. two architectures that need very different balance numbers.
>>And what is the reason for making AMD's balance interval 1?
>>
>
>AMD is 1 because there's no need to balance within a node, so I want the 
>inter-node balance frequency to be as often as it was with just O(1).  This 
>interval would not work well with other NUMA boxes, so that's the main reason 
>to have arch specific intervals.
>

OK, I misread the patch. IIRC AMD has 1 CPU per node? If so, why doesn't
this simply prevent balancing within a node?

>  And, as a general guideline, boxes with 
>different local-remote latency ratios will probably benefit from different 
>inter-node balance intervals.  I don't know what these ratios are, but I'd 
>like the kernel to have the ability to change for one arch and not affect 
>another.
>

I fully appreciate there are huge differences... I am curious if
you can see much improvements in practice.

>
>>Also, things like nr_running_inc are supposed to be very fast. I am
>>a bit worried to see a loop and CPU shared atomics in there.
>>
>
>That has concerned me, too.  So far I haven't been able to see a measurable 
>difference either way (within noise level), but it's possible.  The other 
>alternative is to sum up node load at sched_best_cpu and find_busiest_node.
>

Hmm... get someone to try the scheduler benchmarks on a 32 way box ;)

>
>>node_2_node is an odd sounding conversion too ;)
>>
>
>I just went off the toplogy already there, so I left it.
>
>
>>BTW. you should be CC'ing Ingo if you have any intention of scheduler
>>stuff getting into 2.6.
>>
>
>OK, thanks!
>
>

Good luck with it. Definitely some good ideas.


