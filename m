Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVCWJli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVCWJli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVCWJlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:41:37 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:30985 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261171AbVCWJlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:41:21 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: paulmck@us.ibm.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, simlo@phys.au.dk
Organization: Core
In-Reply-To: <20050323061601.GE1294@us.ibm.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DE2ME-0003d5-00@gondolin.me.apana.org.au>
Date: Wed, 23 Mar 2005 20:40:58 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney <paulmck@us.ibm.com> wrote:
>
> +void rcu_read_unlock(void)
> +{
> +       int cpu;
> +
> +       if (--current->rcu_read_lock_nesting == 0) {
> +               atomic_dec(&current->rcu_data->active_readers);
> +               /*
> +                * Check whether we have reached quiescent state.
> +                * Note! This is only for the local CPU, not for
> +                * current->rcu_data's CPU [which typically is the
> +                * current CPU, but may also be another CPU].
> +                */
> +               cpu = get_cpu();
> 
> And need an smp_mb() here, again for non-x86 CPUs.

The atomic_dec is already a barrier.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
