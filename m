Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVCSQcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVCSQcd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 11:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVCSQcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 11:32:33 -0500
Received: from mx2.elte.hu ([157.181.151.9]:34267 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262633AbVCSQcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 11:32:16 -0500
Date: Sat, 19 Mar 2005 17:31:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bhuey@lnxw.com, paulmck@us.ibm.com, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050319163128.GB28958@elte.hu>
References: <20050318160229.GC25485@elte.hu> <E1DCPut-0005XI-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DCPut-0005XI-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > i really have no intention to allow multiple readers for rt-mutexes. We
> > got away with that so far, and i'd like to keep it so. Imagine 100
> > threads all blocked in the same critical section (holding the read-lock)
> > when a highprio writer thread comes around: instant 100x latency to let
> > all of them roll forward. The only sane solution is to not allow
> > excessive concurrency. (That limits SMP scalability, but there's no
> > other choice i can see.)
> 
> What about allowing only as many concurrent readers as there are CPUs?

since a reader may be preempted by a higher prio task, there is no
linear relationship between CPU utilization and the number of readers
allowed. You could easily end up having all the nr_cpus readers
preempted on one CPU. It gets pretty messy.

	Ingo
