Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316894AbSE1Tyv>; Tue, 28 May 2002 15:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSE1Tyu>; Tue, 28 May 2002 15:54:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3211 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316894AbSE1Tyt>;
	Tue, 28 May 2002 15:54:49 -0400
Date: Wed, 29 May 2002 01:27:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: alan@lxorguk.ukuu.org.uk
Cc: Dave Miller <davem@redhat.com>, Paul McKenney <paul.mckenney@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@suse.de>
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
Message-ID: <20020529012726.A23469@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

In article <1022609447.4123.126.camel@irongate.swansea.linux.org.uk> Alan Cox wrote:
> On Tue, 2002-05-28 at 17:34, Andi Kleen wrote:
>> And gain tons of new atomic_incs and decs everywhere in the process?  
>> I would prefer RCU. 

> Lots of people write drivers, many of them not SMP kernel locking gurus
> who have time to understand RCU and when they can or cannot sleep, and
> what happens if their unload is pre-empted and RCU is in use. The kernel
> core has to provide a clean easy interface. The network code is a superb
> example of this. All the hard thinking is done outside of the driver, at
> least unless you choose to join in that thinking to get the last scraps
> of performance.

FWIW, recent RCU implementations support preemption. synchronize_kernel()
in rcu_poll_preempt patches use call_rcu_preempt() where callbacks
wait until all CPUs have done a voluntary context switch.
See http://prdownloads.sourceforge.net/lse/rcu_poll_preempt-2.5.14-2.patch

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
