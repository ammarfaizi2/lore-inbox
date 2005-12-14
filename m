Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbVLNBqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbVLNBqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVLNBqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:46:08 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:30147 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030353AbVLNBqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:46:06 -0500
Date: Tue, 13 Dec 2005 17:46:26 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Keith Owens <kaos@sgi.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20051214014626.GF14158@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051213162027.GA14158@us.ibm.com> <17158.1134512861@ocs3.ocs.com.au> <20051213225059.GD14158@us.ibm.com> <20051214011253.GB23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214011253.GB23384@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 02:12:53AM +0100, Andi Kleen wrote:
> On Tue, Dec 13, 2005 at 02:50:59PM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 14, 2005 at 09:27:41AM +1100, Keith Owens wrote:
> > > On Tue, 13 Dec 2005 08:20:27 -0800, 
> > > "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> > > >If the variable p references MMIO rather than normal memory, then
> > > >wmb() and rmb() are needed instead of smp_wmb() and smp_rmb().
> > > 
> > > mmiowb(), not wmb().  IA64 has a different form of memory fence for I/O
> > > space compared to normal memory.  MIPS also has a non-empty form of
> > > mmiowb().
> > 
> > New one on me!
> 
> Didn't it make only a difference on the Altix or something like that? 
> I suppose they added it only on the drivers for devices supported by SGI.

It could potentially help on a few other CPUs, but quite a few driver
changes would be needed to really bring out the full benefits.  I am
concerned that the current state leaves a number of CPU families broken --
the empty definitions cannot be good for other weakly ordered CPUs!

						Thanx, Paul
