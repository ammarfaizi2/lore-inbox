Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUFNXuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUFNXuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 19:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUFNXuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 19:50:01 -0400
Received: from colin2.muc.de ([193.149.48.15]:61962 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264633AbUFNXt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 19:49:59 -0400
Date: 15 Jun 2004 01:49:58 +0200
Date: Tue, 15 Jun 2004 01:49:58 +0200
From: Andi Kleen <ak@muc.de>
To: Anton Blanchard <anton@samba.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       lse-tech@lse.sourceforge.net
Subject: Re: NUMA API observations
Message-ID: <20040614234958.GC90963@colin2.muc.de>
References: <20040614153638.GB25389@krispykreme> <20040614161749.GA62265@colin2.muc.de> <20040614214003.GE25389@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614214003.GE25389@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 07:40:04AM +1000, Anton Blanchard wrote:
>  
> > interleave should always fall back to other nodes. Very weird.
> > Needs to be investigated. What were the actual arguments passed
> > to the syscalls? 
> 
> This one looks like a bug in my code. I wasnt setting numnodes high
> enough, so the node fallback lists werent being initialised for some
> nodes.

Ok. Good to know.

That's a bad generic bug, right?

interleaving isn't really doing much different from an ordinary allocation,
except that the numa_node_id() index to the zone table is replaced with a 
different number.

> > > My kernel is compiled with NR_CPUS=128, the setaffinity syscall must be
> > > called with a bitmap at least as big as the kernels cpumask_t. I will
> > > submit a patch for this shortly.
> > 
> > Umm, what a misfeature. We size the buffer up to the biggest
> > running CPU. That should be enough. 
> > 
> > IMHO that's just a kernel bug. How should a user space
> > application sanely discover the cpumask_t size needed by the kernel?
> > Whoever designed that was on crack.
> 
> glibc now uses a select style interface. Unfortunately the interface has
> changed about three times by now.

I have no plans to track the glibc interface of the week for this
and numactl must run with older glibc anyways, that is why I always 
used an own stub to this. I am not sure they even solved the problem 
completely. With the upcomming numactl version it should work.

What I wonder is why IA64 worked though. We tested on it previously,
but somehow didn't run into this. The regression test suite
needs to check this better.

-Andi
