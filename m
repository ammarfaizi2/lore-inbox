Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVCWJjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVCWJjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVCWJjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:39:35 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:26633 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261161AbVCWJj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:39:29 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mingo@elte.hu (Ingo Molnar)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, simlo@phys.au.dk
Organization: Core
In-Reply-To: <20050323063317.GB31626@elte.hu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DE2JX-0003cP-00@gondolin.me.apana.org.au>
Date: Wed, 23 Mar 2005 20:38:11 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
>> +#ifdef CONFIG_PREEMPT_RCU
>> +
>> +void rcu_read_lock(void)
>> +{
>> +     if (current->rcu_read_lock_nesting++ == 0) {
>> +             current->rcu_data = &get_cpu_var(rcu_data);
>> +             atomic_inc(&current->rcu_data->active_readers);
>> +             put_cpu_var(rcu_data);
>> 
>> Need an smp_mb() here for non-x86 CPUs.  Otherwise, the CPU can
>> re-order parts of the critical section to precede the rcu_read_lock().
>> Could precede the put_cpu_var(), but why increase latency?
> 
> ok. It's enough to put a barrier into the else branch here, because the
> atomic op in the main brain is a barrier by itself.

Since the else branch is only taken when rcu_read_lock_nesting > 0, do
we need the barrier at all?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
