Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbTATTca>; Mon, 20 Jan 2003 14:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbTATTca>; Mon, 20 Jan 2003 14:32:30 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:38881 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266721AbTATTc3>; Mon, 20 Jan 2003 14:32:29 -0500
Date: Mon, 20 Jan 2003 11:33:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
cc: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <262510000.1043091224@flay>
In-Reply-To: <200301201313.39621.habanero@us.ibm.com>
References: <Pine.LNX.4.44.0301201817220.12564-100000@localhost.localdomain> <200301201313.39621.habanero@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I think the large PPC64 boxes have multilevel NUMA as well - two real
>> > phys cores on one die, sharing some cache (L2 but not L1? Anton?). And
>> > SGI have multilevel nodes too I think ... so we'll still need multilevel
>> > NUMA at some point ... but maybe not right now.
>> 
>> Intel's HT is the cleanest case: pure logical cores, which clearly need
>> special handling. Whether the other SMT solutions want to be handled via
>> the logical-cores code or via another level of NUMA-balancing code,
>> depends on benchmarking results i suspect. It will be one more flexibility
>> that system maintainers will have, it's all set up via the
>> sched_map_runqueue(cpu1, cpu2) boot-time call that 'merges' a CPU's
>> runqueue into another CPU's runqueue. It's basically the 0th level of
>> balancing, which will be fundamentally different. The other levels of
>> balancing are (or should be) similar to each other - only differing in
>> weight of balancing, not differing in the actual algorithm.
> 
> I have included a very rough patch to do ht-numa topology.  I requires to 
> manually define CONFIG_NUMA and CONFIG_NUMA_SCHED.  It also uses num_cpunodes 
> instead of numnodes and defines MAX_NUM_NODES to 8 if CONFIG_NUMA is defined.  

Whilst it's fine for benchmarking, I think this kind of overlap is a 
very bad idea long-term - the confusion introduced is just asking for
trouble. And think what's going to happen when you mix HT and NUMA.
If we're going to use this for HT, it needs abstracting out.

M.

