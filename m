Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310622AbSCMOo4>; Wed, 13 Mar 2002 09:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310455AbSCMOoq>; Wed, 13 Mar 2002 09:44:46 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:27808 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S292992AbSCMOo2>; Wed, 13 Mar 2002 09:44:28 -0500
Date: Wed, 13 Mar 2002 06:44:56 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Anton Blanchard <anton@samba.org>, lse-tech@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: Re: 10.31 second kernel compile
Message-ID: <460695164.1016001894@[10.10.2.3]>
In-Reply-To: <20020313085217.GA11658@krispykreme>
In-Reply-To: <20020313085217.GA11658@krispykreme>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> make[1]: Leaving directory `/home/anton/intel_kernel/linux/arch/i386/boot'
> 130.63user 71.31system 0:10.31elapsed 1957%CPU (0avgtext+0avgdata 0maxresident)k

Wow! Is this box NUMA (what latency ratio, mem access speeds, etc?), or can you really build a straight SMP that big?

OK, now I'm going to have to build a bigger system ;-)

> Due to the final link and compress stage, there is a fair amount of idle
> time at the end of the run. Its going to be hard to push that number
> lower by adding cpus.

I think we need to fix the final phase .... anyone got any ideas
on parallelizing that?
 
> The profile results below show that kernel time is dominated by the low
> level ppc64 pagetable management. We are working to correct this, a lot
> of the overhead in __hash_page should be gone soon. The rest of the
> profile looks pretty good, do_anonymous_page and lru_cache_add show
> up high as they did in Martin's results.

I have some strange plans for the lru stuff, but it'll take me a while.
I'm curious as to why lru_cache_del is so much lower in your list than
add, whereas the ratio for me is about:

   719 lru_cache_add                              7.8152
   477 lru_cache_del                             21.6818

>   6714 .local_flush_tlb_range                  ppc64 specific
>   2773 .local_flush_tlb_page                   ppc64 specific

Do you know what's causing the tlb flushes? Just context switches?
 
>    554 .d_lookup                               

Did you try the dcache patches?

Can you publish lockmeter stats?

Thanks,

M.

