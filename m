Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263093AbTCLISM>; Wed, 12 Mar 2003 03:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263094AbTCLISM>; Wed, 12 Mar 2003 03:18:12 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:34699 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S263093AbTCLISK>;
	Wed, 12 Mar 2003 03:18:10 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303120828.h2C8SkY17826@csl.stanford.edu>
Subject: Re: [CHECKER] more potential deadlocks
To: jmorris@intercode.com.au (James Morris)
Date: Wed, 12 Mar 2003 00:28:46 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
In-Reply-To: <Pine.LNX.4.44.0303121910090.5320-100000@blackbird.intercode.com.au> from "James Morris" at Mar 12, 2003 07:22:53 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> James Morris writes:
> > BUG: seems like it, if they can point to the same thing.  ERROR: 1 thread deadlock.
> >    <struct in_device.lock (<local>:0)>-><struct ip_mc_list.lock (<local>:0)> occurred 5 times
> >    <struct ip_mc_list.lock (<local>:0)>-><struct in_device.lock (<local>:0)> occurred 5 times
> 
> See below.
> 
> > BUG? very hard to follow, but interesting if a real bug.  unfortunately,
> > could also be a false positive because of 
> > 	1. infeasible callchain path or 
> > 
> > 	2. the various in_dev and im pointers never actually point to
> > 	   the same object.
> > 
> > requires three threads: 
> > 	thread 1: acquires im->lock then tries to get inetdev_lock
> > 	thread 2: acquires inetdev_lock and tries to get in_dev->lock.
> > 	thread 3: acquires in_dev->lock and tries to get im->lock.
> > 
> > ERROR: 2 thread deadlock.
> >    <struct ip_mc_list.lock (<local>:0)>-><&inetdev_lock> occurred 5 times
> >    <&inetdev_lock>-><struct ip_mc_list.lock (<local>:0)> occurred 4 times
> 
> These are indeed potential deadlock cases, caused by holding im->lock for
> too long, now fixed by Alexey (in 2.5 bk at least).

great!  Thanks very much for the feedback.  I'd given up on anyone
looking at these.

If people are interested, I can release more deadlock bugs pretty easily.

Dawson
