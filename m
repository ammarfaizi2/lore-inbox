Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbRGMRcZ>; Fri, 13 Jul 2001 13:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267511AbRGMRcP>; Fri, 13 Jul 2001 13:32:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15019 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267510AbRGMRcI>; Fri, 13 Jul 2001 13:32:08 -0400
Date: Fri, 13 Jul 2001 10:31:44 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@suse.de>, lse-tech@lists.sourceforge.net,
        Mike Kravetz <mkravetz@sequent.com>
Subject: Re: CPU affinity & IPI latency
Message-ID: <20010713103144.E1137@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20010712173641.C11719@work.bitmover.com> <XFMail.20010713094144.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010713094144.davidel@xmailserver.org>; from davidel@xmailserver.org on Fri, Jul 13, 2001 at 09:41:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 09:41:44AM -0700, Davide Libenzi wrote:
> 
> I personally think that a standard scheduler/cpu is the way to go for SMP.
> I saw the one IBM guys did and I think that the wrong catch there is trying
> always to grab the best task to run over all CPUs.

That was me/us.  Most of the reason for making 'global scheduling'
decisions was an attempt to maintain the same behavior as the existing
scheduler.  We are trying to see how well we can make this scheduler
scale, while maintaining this global behavior.  Thought is that if
there was ever any hope of someone adopting this scheduler, they would
be more likely to do so if it attempted to maintain existing behavior.


> I think that this concept could be relaxed introducing less chains between each
> CPU scheduler.
> A cheap load balancer should run, "time to time"(tm), to move tasks when a
> certain level of unbalancing has been reached.
> This will give each scheduler more independence and will make it more scalable,
> IMVHO.

Take a look at the 'CPU pooling & Load balancing' extensions to our
scheduler(lse.sourceforge.net/scheduling).  It allows you to divide
the system into CPU pools keep scheduling decisions limited to
these pools.  Periodicly, load balancing will be performed among
the pools.  This has shown some promise on NUMA architectures (as
one would expect).  You could define pool sizes to be 1 CPU and
get the scheduling behavior you desire on SMP.

But, none of this has to do with CPU affinity issues with the
current scheduler.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
