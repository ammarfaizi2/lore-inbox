Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285447AbRLGKGO>; Fri, 7 Dec 2001 05:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285151AbRLGKFy>; Fri, 7 Dec 2001 05:05:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:443 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284037AbRLGKFm>;
	Fri, 7 Dec 2001 05:05:42 -0500
Date: Fri, 7 Dec 2001 15:40:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Niels Christiansen <nchr@us.ibm.com>
Cc: kiran@linux.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011207154017.B15810@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <OFEDC68CF2.34B05314-ON85256B1B.00355B4C@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFEDC68CF2.34B05314-ON85256B1B.00355B4C@raleigh.ibm.com>; from nchr@us.ibm.com on Fri, Dec 07, 2001 at 04:52:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 04:52:40AM -0500, Niels Christiansen wrote:
> 
> Hello Dikanpar,
> | It should be easy to place the counters in appropriately close
> | memory if linux gets good NUMA APIs built on top of the topology
> | services. If we extend kmem_cache_alloc() to allocate memory
> | in a particular NUMA node, we could simply do this for placing the
> | counters -
> | ...
> | This would put the block of counters corresponding to a CPU in
> | memory local to the NUMA node. If there are more sophisticated
> | APIs available for suitable memory selection, those too can be made
> | use of here.
> |
> | Is this the kind of thing you are looking at ?
> 
> I'm no NUMA person so I can't verify your code snippet but if it does
> what you say, yes, that is exactly what I meant:  We may have to deal
> with both cache coherence and placement of counters in local memory.

Yes, we will likely need to place the conters in memory closest to
the corresponding CPUs.

I haven't yet started looking at the current NUMA proposals, but
I hope that there will be support for NUMA-aware allocations. The
flexible allocator scheme in our statctr implementation allows
each counter block corresponding to a CPU to be allocated separately
and we can make the locational judgement at that time as indicated
in my hypothetical changes to the statctr code snippet.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
