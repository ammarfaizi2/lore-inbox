Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUDHXCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUDHXCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:02:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:49049 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263084AbUDHXCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:02:31 -0400
Date: Thu, 08 Apr 2004 16:14:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <32730000.1081466048@flay>
In-Reply-To: <20040408221915.GV31667@dualathlon.random>
References: <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay> <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay> <20040407231806.GV26888@dualathlon.random> <33900000.1081380891@flay> <20040408001845.GX26888@dualathlon.random> <1479132704.1081405456@[10.10.2.4]> <20040408215946.GU31667@dualathlon.random> <29690000.1081462791@flay> <20040408221915.GV31667@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Instead of fiddling with tuning knobs, I'd prefer to just do the UKVA
>> >> idea I've proposed before, and let each process have their own pagetables
>> >> mapped permanently ;-)
>> > 
>> > that will have you pay for pte-highmem even in non-highmem machines.
>> > I'm always been against your above idea ;) It can speedup mmap a bit for
>> > some uncommon case but I believe your slowdown comes from the page faults after
>> > exeve and startup not from mmap with the kernel compile, and worst of
>> > all for non-highmem too (no sysctl or tuning knob can save you then).
>> > Amittedly some mmap intensive workload can get a slight speedup compared
>> > to pte-highmem but I don't think it's common and it has the potential of
>> > slowing down the page faults especially in short lived tasks even w/o
>> > highmem.
>> 
>> You mean the page-faults for the pagetable mappings themselves? I wouldn't
>> have thought that'd make an impact - at least I don't see how it could be
>> worse than pte_highmem. And as we could make it conditional on highmem
> 
> it's worse because you pay for it even with lowmem.
> 
> as for your question for why the overhead is lower on 1/2G boxes, that
> as well is because the probability of the page going into highmem is
> much lower.

Me confused. Are you saying it's worse compared to pte_highmem? or to 
shoving ptes in lowmem?

>> anyway (or even CONFIG_64GB, I'm pretty sure 4GB machines don't need it),
>> I don't think it matters (ie you'd just turn it on instead of pte_highmem).
> 
> 1 single smp kernel with CONFIG64G and ptehighmem=y covers 99% of the
> x86 smp hardware in the market, from 32M of ram to 32G of ram both
> included and always at the 99% of peak possible performance of the
> hardware, that's really nice IMHO, I don't like design solutions that
> requires different kernel image every few gigs of ram you add to the
> machine unless real big gains can be demonstrated.  One can recompile
> and tune as usual, but we should prefer generic design solutions to
> dedicated ones unless they really make an huge difference. Running a
> CONFIG64G with ptehighmem=y on a 512M box may be say 0.1% slower than a
> nohighmem-noptehighmem, Ingo posted the exact PAE vs non-PAE slowdown a
> few days ago, it's non significant.
> 
>> But you're right, we do need to take that into consideration.
> 
> Best really would be to benchmark it, for it I definitely like your
> kernel compile -j benchmark for it (but with mem=800m ;).

Ah. You're worried about the distro situation, where PTE_HIGHMEM would
be turned on for a non-highmem machine, right? Makes more sense I guess.
But runtime switching it probably isn't that hard either ;-)

M.

