Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVCRQ5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVCRQ5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVCRQ5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:57:24 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:47267 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261927AbVCRQ4R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:56:17 -0500
Date: Fri, 18 Mar 2005 17:55:44 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org,
       torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050318160229.GC25485@elte.hu>
Message-Id: <Pine.OSF.4.05.10503181750150.2466-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Mar 2005, Ingo Molnar wrote:

> 
> * Bill Huey <bhuey@lnxw.com> wrote:
> 
> > I'd like to note another problem. Mingo's current implementation of
> > rt_mutex (super mutex for all blocking synchronization) is still
> > missing reader counts and something like that would have to be
> > implemented if you want to do priority inheritance over blocks.
> 
> i really have no intention to allow multiple readers for rt-mutexes. We
> got away with that so far, and i'd like to keep it so. Imagine 100
> threads all blocked in the same critical section (holding the read-lock)
> when a highprio writer thread comes around: instant 100x latency to let
> all of them roll forward. The only sane solution is to not allow
> excessive concurrency. (That limits SMP scalability, but there's no
> other choice i can see.)
>

Unless a design change is made: One could argue for a semantics where
write-locking _isn't_ deterministic and thus do not have to boost all the
readers. Readers boost the writers but not the other way around. Readers
will be deterministic, but not writers.
Such a semantics would probably work for a lot of RT applications
happening not to take any write-locks - these will in fact perform better. 
But it will give the rest a lot of problems.
 
> 	Ingo

Esben

