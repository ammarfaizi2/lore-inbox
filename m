Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVCWJsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVCWJsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCWJsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:48:53 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:42761 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261246AbVCWJss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:48:48 -0500
Date: Wed, 23 Mar 2005 20:48:05 +1100
To: paulmck@us.ibm.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, simlo@phys.au.dk
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050323094805.GA14012@gondor.apana.org.au>
References: <20050323061601.GE1294@us.ibm.com> <E1DE2ME-0003d5-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DE2ME-0003d5-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 08:40:58PM +1100, Herbert Xu wrote:
> Paul E. McKenney <paulmck@us.ibm.com> wrote:
> >
> > +void rcu_read_unlock(void)
> > +{
> > +       int cpu;
> > +
> > +       if (--current->rcu_read_lock_nesting == 0) {
> > +               atomic_dec(&current->rcu_data->active_readers);
> > +               /*
> > +                * Check whether we have reached quiescent state.
> > +                * Note! This is only for the local CPU, not for
> > +                * current->rcu_data's CPU [which typically is the
> > +                * current CPU, but may also be another CPU].
> > +                */
> > +               cpu = get_cpu();
> > 
> > And need an smp_mb() here, again for non-x86 CPUs.
> 
> The atomic_dec is already a barrier.

Sorry, I was confused.  atomic_dec is not a barrier of course.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
