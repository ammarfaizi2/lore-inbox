Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVLLIkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVLLIkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVLLIkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:40:45 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2721 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751133AbVLLIko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:40:44 -0500
Date: Mon, 12 Dec 2005 14:11:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20051212084112.GA3934@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1134344716.5937.11.camel@localhost.localdomain> <18382.1134348547@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18382.1134348547@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 11:49:07AM +1100, Keith Owens wrote:
> >On the contrary.  I did some digging and asking and thinking about this
> >for the Unreliable Guide to Kernel Locking, years ago:
> >
> >wmb() means all writes preceeding will complete before any writes
> >following are started.
> >rmb() means all reads preceeding will complete before any reads
> >following are started.
> >mb() means all reads and writes preceeding will complete before any
> >reads and writes following are started.
> 
> FWIW, wmb() on IA64 does not require that preceding stores are flushed
> to main memory.  It only requires that they be "made visible to other
> processors in the coherence domain".  "visible" means that the updated
> value must reach (at least) an externally snooped cache.  There is no
> requirement that the preceding stores be flushed all the way to main
> memory, the updates only have to get as far as a cache level that other
> cpus can see.  The cache snooping takes care of flushing to main memory
> when necessary.

For the context of the problem that we are dealing with, I think this fact
that writes are made "visible" to other CPUs (before smp_mb() finishes and 
before other reads are started) is good enough.

Oleg, with all these inputs, I consider the patch I had sent to be correct.
Let me know if you still have some lingering doubts!

P.S :- Thanks to everybody who reponded clarifying this subject.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
