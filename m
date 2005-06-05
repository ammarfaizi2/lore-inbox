Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVFEJB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVFEJB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 05:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVFEJB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 05:01:27 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:37334 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261540AbVFEJBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 05:01:22 -0400
Date: Sun, 5 Jun 2005 11:00:51 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050605085313.GA30946@elte.hu>
Message-Id: <Pine.OSF.4.05.10506051055570.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > When K is a constant or bounded by a constant (140 in this 
> > application) any function which is O(K) is O(1) per definition of O!
> 
> technically you are right. But the question is - while K is considered a 
> constant, and N (nr_running_RT_tasks) is technically not bounded - in 
> practice N is bounded just as much. Have you ever seen any hard-RT 
> application that has more than 140 threads _running at the same time_ on 
> a single CPU? You can even enforce it to be theoretically bounded, via 
> ulimits.
> 
> in fact, K and N should be pretty close to each other for most 
> applications. I'd be interested in real application scenarios where N is 
> much (== more than 10 times) larger than K and plists really matter.
> 

I think that would only be the case when an application has an error. The
problem now is: Say you have two RT applications running, one living
in priority 0-49 and one in 50-99. Let us say the second has such an
error, like keep spawning threads whichs blocks on a mutex owned by a task
which is blocked forever. Without plists such an error will kill the high
priority RT task. With plists it will only see a _limited_ effect on it's
latency.

You can say plists is better at isolating applications wrt. timing than
ordinary sorted lists.

> 	Ingo
> 

