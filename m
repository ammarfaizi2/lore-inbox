Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132740AbRDOR23>; Sun, 15 Apr 2001 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132746AbRDOR2U>; Sun, 15 Apr 2001 13:28:20 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:54288 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132740AbRDOR2B>; Sun, 15 Apr 2001 13:28:01 -0400
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200104151723.KAA30317@google.engr.sgi.com>
Subject: Re: [Lse-tech] Bug in sys_sched_yield
To: frankeh@us.ibm.com (Hubertus Franke)
Date: Sun, 15 Apr 2001 10:23:31 -0700 (PDT)
Cc: george@mvista.com (george anzinger),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        lse-tech@lists.sourceforge.net
In-Reply-To: <OF33FEDED1.EDF6D260-ON85256A2D.006D99DE@pok.ibm.com> from "Hubertus Franke" at Apr 13, 2001 04:06:16 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> George, while this is needed as pointed out in a previous message,
> due to non-contiguous physical IDs, I think the current usage is
> pretty bad (at least looking from a x86 perspective). Maybe somebody
> can chime in from a different architecture.
> 
> I think that all data accesses particularly to __aligned_data
> should be performed through logical ids. There's a lot of remapping
> going on, due to the mix of logical and physical IDs.
>

I _think_ cpu_logical_map() can be deleted from the kernel, and all
places that use it can just use the [0 ... (smp_num_cpus-1)] number.
This is for the generic kernel code. The only place that should need
to convert from this number space to a "physical" space would be the
intercpu interrupt code (arch specific code). 

Only a handful of architectures (mips64, sparc*, alpha) do array
lookups for cpu_logical_map() anyway, those probably can be changed 
to the x86 definition of cpu_logical_map().

Kanoj
