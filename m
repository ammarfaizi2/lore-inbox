Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267649AbTALXZv>; Sun, 12 Jan 2003 18:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbTALXZv>; Sun, 12 Jan 2003 18:25:51 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:65203 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267649AbTALXZu> convert rfc822-to-8bit; Sun, 12 Jan 2003 18:25:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] Minature NUMA scheduler
Date: Mon, 13 Jan 2003 00:35:00 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301101734.56182.efocht@ess.nec.de> <967810000.1042217859@titus>
In-Reply-To: <967810000.1042217859@titus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301130035.00069.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 January 2003 17:57, Martin J. Bligh wrote:
> This seems like the right approach to me, apart from the trigger to
> do the cross-node rebalance. I don't believe that has anything to do
> with when we're internally balanced within a node or not, it's
> whether the nodes are balanced relative to each other. I think we should
> just check that every N ticks, looking at node load averages, and do
> a cross-node rebalance if they're "significantly out".

OK, I changed my mind about the trigger and made some experiments with
the cross-node balancer called after every N calls of
load_balance. If we make N tunable, we can even have some dynamics in
case the nodes are unbalanced: make N small if the current node is
less loaded than the average node loads, make N large if the node is
averagely loaded. I'll send the patches in a separate email.

> The NUMA rebalancer
> is obviously completely missing from the current implementation, and
> I expect we'd use mainly Erich's current code to implement that.
> However, it's suprising how well we do with no rebalancer at all,
> apart from the exec-time initial load balance code.

The fact that we're doing fine on kernbench and numa_test/schedbench
is (I think) understandeable. In both benchmarks a process cannot
change its node during its lifetime, therefore has minimal memory
latency. In numa_test the "disturbing" hackbench just cannot move away
any of the tasks from their originating node. Therefore the results
are the best possible.

Regards,
Erich

