Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVCVLke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVCVLke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVCVLke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:40:34 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:19121 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262383AbVCVLkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:40:25 -0500
Date: Tue, 22 Mar 2005 12:39:51 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050322105640.GA28861@elte.hu>
Message-Id: <Pine.OSF.4.05.10503221220500.25802-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > +static inline void rcu_read_lock(void)
> > +{	
> > +	preempt_disable(); 
> > +	__get_cpu_var(rcu_data).active_readers++;
> > +	preempt_enable();
> > +}
> 
> this is buggy. Nothing guarantees that we'll do the rcu_read_unlock() on
> the same CPU, and hence ->active_readers can get out of sync.
> 

Ok, this have to be handled in the mitigration code somehow. I have already 
added an 
  current->rcu_read_depth++
so it ought to be painless. A simple solution would be not to mititagrate
threads with rcu_read_depth!=0.

> 	Ingo
> 

Esben

