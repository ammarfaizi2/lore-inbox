Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVLJRke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVLJRke (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 12:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVLJRke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 12:40:34 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:31151 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964938AbVLJRke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 12:40:34 -0500
Message-ID: <439B24A7.E2508AAE@tv-sign.ru>
Date: Sat, 10 Dec 2005 21:55:35 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
References: <439889FA.BB08E5E1@tv-sign.ru> <20051209024623.GA14844@in.ibm.com> <4399D852.47E0BB4E@tv-sign.ru> <20051210151951.GA2798@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> 
> On Fri, Dec 09, 2005 at 10:17:38PM +0300, Oleg Nesterov wrote:
> > >         rcp->cur++;     /* New GP */
> > >
> > >         smp_mb();
> >
> > I think I need some education on memory barriers.
> >
> > Does this mb() garantees that the new value of ->cur will be visible
> > on other cpus immediately after smp_mb() (so that rcu_pending() will
> > notice it) ?
> 
> AFAIK the new value of ->cur should be visible to other CPUs when smp_mb()
> returns. Here's a definition of smp_mb() from Paul's article:
> 
> smp_mb(): "memory barrier" that orders both loads and stores. This means loads
> and stores preceding the memory barrier are committed to memory before any
> loads and stores following the memory barrier.

Thanks, but this definition talks about ordering, it does not say
anything about the time when stores are really commited to memory
(and does it mean also that cache-lines are invalidated on other
cpus ?).

> [ http://www.linuxjournal.com/article/8211 ]

And thanks for this link, now I have some understanding about
read_barrier_depends() ...

Oleg.
