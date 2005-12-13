Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVLMWuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVLMWuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbVLMWuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:50:35 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:52680 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030327AbVLMWue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:50:34 -0500
Date: Tue, 13 Dec 2005 14:50:59 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Keith Owens <kaos@sgi.com>
Cc: Andi Kleen <ak@suse.de>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20051213225059.GD14158@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051213162027.GA14158@us.ibm.com> <17158.1134512861@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17158.1134512861@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 09:27:41AM +1100, Keith Owens wrote:
> On Tue, 13 Dec 2005 08:20:27 -0800, 
> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> >If the variable p references MMIO rather than normal memory, then
> >wmb() and rmb() are needed instead of smp_wmb() and smp_rmb().
> 
> mmiowb(), not wmb().  IA64 has a different form of memory fence for I/O
> space compared to normal memory.  MIPS also has a non-empty form of
> mmiowb().

New one on me!

> >This is because the I/O device needs to see the accesses ordered
> >even in a UP system.
> 
> Why does mmiowb() map to empty on most systems, including Alpha?
> Should it not map to wmb() for everything except IA64 and MIPS?

Sounds like I am not the only one that it is new to...

There are over four hundred instances of wmb() still in the drivers tree
in 2.6.14.  I suspect that most of them are for MMIO fencing -- the ones
I looked at quickly certainly seem to be.

But, given mmiowb(), what is the point of having wmb()?  Why are
write memory barriers needed in UP kernels if not for MMIO and other
hardware-specific accesses?  Is your thought that use of wmb() should
be phased out in favor of mmiowb()?  (Might be a good idea, but doesn't
look like we are there yet.)

							Thanx, Paul
