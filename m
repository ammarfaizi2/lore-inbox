Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbVCXGxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbVCXGxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVCXGxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:53:07 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:53922 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263067AbVCXGw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:52:58 -0500
Date: Wed, 23 Mar 2005 22:52:59 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       simlo@phys.au.dk
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324065259.GG1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050323063317.GB31626@elte.hu> <E1DE2JX-0003cP-00@gondolin.me.apana.org.au> <20050323094954.GA14052@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323094954.GA14052@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 08:49:54PM +1100, Herbert Xu wrote:
> On Wed, Mar 23, 2005 at 08:38:11PM +1100, Herbert Xu wrote:
> >
> > > ok. It's enough to put a barrier into the else branch here, because the
> > > atomic op in the main brain is a barrier by itself.
> > 
> > Since the else branch is only taken when rcu_read_lock_nesting > 0, do
> > we need the barrier at all?
> 
> Actually, since atomic_inc isn't a barrier, we do need that mb.
> However, it should only be necessary in the main branch and we
> can use smp_mb__after_atomic_inc which is optimised away on a
> number of architectures (i386 in particular).

You are right, I should have said smp_mb__after_atomic_inc() instead of
smp_mb() in the rcu_read_lock() case and smp_mb__after_atomic_dec()
in the rcu_read_unlock() case.

						Thanx, Paul
