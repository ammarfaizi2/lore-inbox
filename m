Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265156AbUABHGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 02:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbUABHGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 02:06:19 -0500
Received: from dp.samba.org ([66.70.73.150]:39640 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265156AbUABHGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 02:06:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Wed, 31 Dec 2003 01:34:39 CDT."
             <3FF26DFF.3040909@pobox.com> 
Date: Fri, 02 Jan 2004 10:51:07 +1100
Message-Id: <20040102070615.EDE172C22C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FF26DFF.3040909@pobox.com> you write:
> Rusty Russell wrote:
> > For #2, if you really can't wait for keventd, perhaps your own
> > workqueue is in order?
> 
> Way too wasteful, 

I feel the same, which is one reason I didn't use them here...

> and doing so is working around a fundamental failing 
> of workqueues:  keventd gives no guarantee that your scheduled work will 
> be executed this week, this month, or this year :)

Hmm, I think that if you had an all-dancing, self-balancing workqueue
mechanism, you wouldn't need to create your own workqueues anyway.

> So it would be nice to have thread pool semantics occasionally found in 
> userspace:  if thread pool is full when new work is queued, 
> _temporarily_ increase the pool size (or create a one-shot kthread). 
> Sure you have kthread creation overhead, but at least you have a 
> reasonable guarantee that your work won't wait 5-30 seconds or more 
> before being performed.

If we're wishlisting, I'd prefer something which also scaled down
below one thread per cpu until required.  Mainly because it just feels
wrong to have those threads sitting around doing mainly nothing.

Simple matter of coding, right?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
