Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311605AbSCNMwx>; Thu, 14 Mar 2002 07:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311608AbSCNMwn>; Thu, 14 Mar 2002 07:52:43 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:4870 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S311605AbSCNMwd>;
	Thu, 14 Mar 2002 07:52:33 -0500
Date: Thu, 14 Mar 2002 22:27:26 +1100
From: Anton Blanchard <anton@samba.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 10.31 second kernel compile
Message-ID: <20020314112725.GA2008@krispykreme>
In-Reply-To: <20020313085217.GA11658@krispykreme> <460695164.1016001894@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460695164.1016001894@[10.10.2.3]>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Wow! Is this box NUMA (what latency ratio, mem access speeds, etc?), or
> can you really build a straight SMP that big?

The system has two cpus on a chip sharing a l2 cache, 4 of these chips
built into a multichip module and up to 4 of these modules connected
together. The l3 and memory is distributed amongst the modules.

As you can imagine there is a hierarchy of latencies but the ratio is
quite low.

> OK, now I'm going to have to build a bigger system ;-)

I've got 8 more cpus in store too :)

> I have some strange plans for the lru stuff, but it'll take me a while.
> I'm curious as to why lru_cache_del is so much lower in your list than
> add, whereas the ratio for me is about:
> 
>    719 lru_cache_add                              7.8152
>    477 lru_cache_del                             21.6818

Not sure about that.

> >   6714 .local_flush_tlb_range                  ppc64 specific
> >   2773 .local_flush_tlb_page                   ppc64 specific
> 
> Do you know what's causing the tlb flushes? Just context switches?

Thats due to the way we manipulate the ppc hashed page table. Every
time we update the linux page tables we have to update the hashed
page table. There are some obvious optimisations we need to make,
hopefully then this will go away. The tlb flushes here are probably
process exits and things like COW faults.

> >    554 .d_lookup                               
> 
> Did you try the dcache patches?

Not for this, I did do some benchmarking of the RCU dcache patches a
while ago which I should post.

> Can you publish lockmeter stats?

I didnt get a chance to run lockmeter, I tend to use the kernel profiler
and use a hacked readprofile (originally from tridge) that displays
profile hits vs assembly instruction. Thats usually good enough to work
out which spinlocks are a problem.

Anton
