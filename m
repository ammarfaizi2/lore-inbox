Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTATRLa>; Mon, 20 Jan 2003 12:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbTATRLa>; Mon, 20 Jan 2003 12:11:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30641 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S266435AbTATRL3>;
	Mon, 20 Jan 2003 12:11:29 -0500
Date: Mon, 20 Jan 2003 18:24:07 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch] sched-2.5.59-A2
In-Reply-To: <1382810000.1043082649@titus>
Message-ID: <Pine.LNX.4.44.0301201817220.12564-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Jan 2003, Martin J. Bligh wrote:

> Do you have that code working already (presumably needs locking
> changes)?  I seem to recall something like that existing already, but I
> don't recall if it was ever fully working or not ...

yes, i have a HT testbox and working code:

   http://lwn.net/Articles/8553/

the patch is rather old, i'll update it to 2.5.59.

> I think the large PPC64 boxes have multilevel NUMA as well - two real
> phys cores on one die, sharing some cache (L2 but not L1? Anton?). And
> SGI have multilevel nodes too I think ... so we'll still need multilevel
> NUMA at some point ... but maybe not right now.

Intel's HT is the cleanest case: pure logical cores, which clearly need
special handling. Whether the other SMT solutions want to be handled via
the logical-cores code or via another level of NUMA-balancing code,
depends on benchmarking results i suspect. It will be one more flexibility
that system maintainers will have, it's all set up via the
sched_map_runqueue(cpu1, cpu2) boot-time call that 'merges' a CPU's
runqueue into another CPU's runqueue. It's basically the 0th level of
balancing, which will be fundamentally different. The other levels of
balancing are (or should be) similar to each other - only differing in
weight of balancing, not differing in the actual algorithm.

	Ingo

