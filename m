Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTEFD4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTEFD42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:56:28 -0400
Received: from dp.samba.org ([66.70.73.150]:36506 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262318AbTEFD4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:56:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "05 May 2003 19:11:59 MST."
             <1052187119.983.5.camel@rth.ninka.net> 
Date: Tue, 06 May 2003 14:08:27 +1000
Message-Id: <20030506040856.8B3712C36E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1052187119.983.5.camel@rth.ninka.net> you write:
> On Mon, 2003-05-05 at 18:52, Andrew Morton wrote:
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > OK.  It has a size restriction: PERCPU_POOL_SIZE is the maximum total
> > > kmalloc_percpu + static DECLARE_PER_CPU you'll get, ever.  This is the
> > > main downside.  It's allocated at boot.
> > 
> > And is subject to fragmentation.
> > 
> > Is it not possible to go allocate another N * PERCPU_POOL_SIZE from
> > slab if it runs out?
> 
> No, then you go back to things requireing multiple levels of
> dereferencing.

Actually, you can; my previous patch did this.  But then all CPUS have
to be one continuous allocation: since modern big-SMP machines are
non-uniform, so you don't want this.

	http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Misc/kmalloc_percpu-orig.patch.gz

> I think the fixed size pool is perfectly reasonable.

Yes.  It's a tradeoff.  I think it's worth it at the moment (although
I'll add a limited printk to __alloc_percpu if it fails).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
