Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVCXHqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVCXHqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVCXHqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:46:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:62669 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262731AbVCXHqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:46:04 -0500
Date: Wed, 23 Mar 2005 23:46:13 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324074613.GJ1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050324052854.GA1298@us.ibm.com> <20050324053456.GA14494@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324053456.GA14494@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 06:34:56AM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > Now, it is true that CPU#2 might record a quiescent state during this 
> > time, but this will have no effect because -all- CPUs must pass 
> > through a quiescent state before any callbacks will be invoked.  Since 
> > CPU#1 is refusing to record a quiescent state, grace periods will be 
> > blocked for the full extent of task 1's RCU read-side critical 
> > section.
> 
> ok, great. So besides the barriers issue (and the long grace period time 
> issue), the current design is quite ok. And i think your original flip 
> pointers suggestion can be used to force synchronization.

The thing I am currently struggling with on the flip-pointers approach is
handling races between rcu_read_lock() and the flipping.  In the earlier
implementations that used this trick, you were guaranteed that if you were
executing concurrently with one flip, you would do a voluntary context
switch before the next flip happened, so that the race was harmless.
This guarantee does not work in the PREEMPT_RT case, so more thought
will be required.  :-/

						Thanx, Paul
