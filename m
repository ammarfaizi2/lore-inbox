Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTE0BO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbTE0BNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:13:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18898
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262470AbTE0BNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:13:04 -0400
Date: Tue, 27 May 2003 03:26:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527012617.GH3767@dualathlon.random>
References: <20030527004115.GD3767@dualathlon.random> <20030526.174841.116378513.davem@redhat.com> <20030527010903.GF3767@dualathlon.random> <20030526.181309.02272953.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526.181309.02272953.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 06:13:09PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Tue, 27 May 2003 03:09:03 +0200
> 
>    I'm not going to implement the above in 2.4, that sounds a 2.5 thing,
> 
> Then your 2.4.x load balancing is buggy for networking.

it's not buggy, it's less performant than what 2.5 could be, it's not a
matter of bugs it's a matter of performance, this is an heuristic, it
can very well do the wrong thing sometime.

What I care about is if it is that it is less performant than any other
2.4 and any current 2.5. That is non obvious to me. The approximation
will never be as good as the perfect accounting, but it's still better
than no approximation at all IMHO, and for sure I don't want to waste
totally idle cpus on a 32way either.

> You simply cannot ignore this issue and act as if it
> does not exist and does not have huge consequence for IRQ
> load balancing decisions.

The only thing the ksoftirqd check can do is to generate less
conseguences now.

>    but my point is that by just ignoring ksoftirqd in the idle selection
>    should avoid the biggest of the NAPI issues.
> 
> On a properly functioning system, ksoftirqd should not be running.

I argue with that, NAPI needs to poll somehow, either you hook into the
kernel slowing down every single schedule, or you need to offload this
work to a kernel thread.

The other cases of ksoftirqd are meant to avoid the 1msec latency shall
the cpu go idle or shall the irqs arrive faster than the network stack
can process the data. They're all legitimate usages IMHO. And we should
be fine to keep irqs running togeter with softirq, that's the point of
this new check.

>    > But deciding how to intepret these measurements and what to do in
>    > response is a userlevel policy decision.  This also coincides with
>    > how cpufreq works.
>    
>    you mean you can have slightly different modes selectable by sysctl
>    right?
> 
> One posibility.  Another is a descriptor describing things like
> how much to weight hardware vs. software IRQ load, vs. process
> load etc.

this certainly sounds good to me.

> 
>    or do you really want to generate a reschedule per second
> 
> No, nothing like this.

ok.

Andrea
