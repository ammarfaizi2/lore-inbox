Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbTAQPVK>; Fri, 17 Jan 2003 10:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbTAQPVK>; Fri, 17 Jan 2003 10:21:10 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:59317 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267529AbTAQPVI> convert rfc822-to-8bit; Fri, 17 Jan 2003 10:21:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] sched-2.5.59-A2
Date: Fri, 17 Jan 2003 16:30:22 +0100
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301171630.22143.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 January 2003 16:11, Ingo Molnar wrote:
> On Fri, 17 Jan 2003, Erich Focht wrote:
> > I like the cleanup of the topology.h. Also the renaming to
> > prev_cpu_load. There was a mistake (I think) in the call to
> > load_balance() in the idle path, guess you wanted to have:
> > +           load_balance(this_rq, 1, __node_to_cpu_mask(this_node));
> > instead of
> > +           load_balance(this_rq, 1, this_cpumask);
> > otherwise you won't load balance at all for idle cpus.
>
> indeed - there was another bug as well, the 'idle' parameter to
> load_balance() was 1 even in the busy branch, causing too slow balancing.

I didn't see that, but it's impact is only that a busy cpu is stealing
at most one task from another node, otherwise the idle=1 leads to more
aggressive balancing.

> > From these results I would prefer to either leave the numa scheduler as
> > it is or to introduce an IDLE_NODEBALANCE_TICK and a
> > BUSY_NODEBALANCE_TICK instead of just having one NODE_REBALANCE_TICK
> > which balances very rarely.
>
> agreed, i've attached the -B0 patch that does this. The balancing rates
> are 1 msec, 2 msec, 200 and 400 msec (idle-local, idle-global, busy-local,
> busy-global).

This looks good! I'll see if I can rerun the tests today, anyway I'm
more optimistic about this version.

Regards,
Erich

