Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262763AbSJCG7K>; Thu, 3 Oct 2002 02:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262764AbSJCG7K>; Thu, 3 Oct 2002 02:59:10 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:58106 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262763AbSJCG7J>; Thu, 3 Oct 2002 02:59:09 -0400
Date: Thu, 3 Oct 2002 12:40:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@au1.ibm.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <20021003124017.B15070@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3D98C60B.9C1EA90B@mvista.com> <Pine.LNX.4.44.0210010542240.2564-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210010542240.2564-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Oct 01, 2002 at 05:51:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 05:51:45AM +0200, Ingo Molnar wrote:
> 
> the smp_processor_id()/(HZ*num_cpus) 'interleaving' of every APIC clock
> was an SMP scalability issue, and it was done as part of the smptimers
> patch. It just got into the kernel much earlier.
> 
> but these days, with the removal of BHs, it might be less of a factor,
> mainly because timers have no global synchronization anymore, so we can
> again try to not interleave the APIC clocks. Only testing will tell,
> because there might be some interaction between timer-generated code
> still.
> 
> Dipankar, wli, would it be possible to try the attached simple patch with
> some of the more complex networking loads? The patch gets rid of the APIC
> timer interleaving.
> 

Ingo,

Removal of interleaving of apic timers doesn't seem to have any adverse affect.
Here are some numbers from a 16-CPU NUMA-Q with tbench (32 clients) averaged 
over 5 runs -

2.5.40-vanilla - 44.16 MB/Sec
2.5.40-no-clock-interleave - 44.17 MB/Sec 

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
