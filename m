Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSJ1Sck>; Mon, 28 Oct 2002 13:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbSJ1Sck>; Mon, 28 Oct 2002 13:32:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40095 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261464AbSJ1Sci>; Mon, 28 Oct 2002 13:32:38 -0500
Date: Mon, 28 Oct 2002 10:32:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <550240000.1035829958@flay>
In-Reply-To: <200210281811.47708.efocht@ess.nec.de>
References: <200210280132.33624.efocht@ess.nec.de> <3129290732.1035737182@[10.10.2.3]> <200210281811.47708.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Erich, what does all the pool stuff actually buy us over what
>> Michael is doing? Seems to be rather more complex, but maybe
>> it's useful for something we're just not measuring here?
> 
> The more complicated stuff is for achieving equal load between the
> nodes. It delays steals more when the stealing node is averagely loaded,
> less when it is unloaded. This is the place where we can make it cope
> with more complex machines with multiple levels of memory hierarchy
> (like our 32 CPU TX7). Equal load among the nodes is important if you
> have memory bandwidth eaters, as the bandwidth in a node is limited.
> 
> When introducing node affinity (which shows good results for me!) you
> also need a more careful ranking of the tasks which are candidates to
> be stolen. The routine task_to_steal does this and is another source
> of complexity. It is another point where the multilevel stuff comes in.
> In the core part of the patch the rank of the steal candidates is computed
> by only taking into account the time which a task has slept.

OK, it all sounds sane, just rather complicated ;-) I'm going to trawl
through your stuff with Michael, and see if we can simplify it a bit
somehow whilst not changing the functionality. Your first patch seems
to work just fine, it's just the complexity that bugs me a bit. 

The combination of your first patch with Michael's balance_exec stuff
actually seems to work pretty well ... I'll poke at the new patch you
sent me + Michael's exec balance + the little perf tweak I made to it,
and see what happens ;-)

> I attach the script for getting some statistics on the numa_test. I 
> consider this test more sensitive to NUMA effects, as it is a bandwidth
> eater also needing good latency.
> (BTW, Martin: in the numa_test script I've sent you the PROBLEMSIZE must
> be set to 1000000!).

It is ;-) I'm running 44-mm4, not virgin remember, so things like hot&cold 
page lists may make it faster?

M.

