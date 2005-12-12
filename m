Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVLLJMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVLLJMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 04:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVLLJMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 04:12:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751152AbVLLJMO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 04:12:14 -0500
Date: Mon, 12 Dec 2005 01:11:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dada1@cosmosbay.com, pj@sgi.com, linux-kernel@vger.kernel.org,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051212011108.0725524d.akpm@osdl.org>
In-Reply-To: <439D3AD5.3080403@yahoo.com.au>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
	<439D3AD5.3080403@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Eric Dumazet wrote:
> > Paul Jackson a écrit :
> > 
> >> +
> >> +static kmem_cache_t *cpuset_cache;
> >> +
> > 
> > 
> > Hi Paul
> > 
> > Please do use __read_mostly for new kmem_cache :
> > 
> > static kmem_cache_t *cpuset_cache __read_mostly;
> > 
> > If not, the pointer can sit in the midle of a highly modified cache 
> > line, and multiple CPUS will have memory cache misses to access the 
> > cpuset_cache, while slab code/data layout itself is very NUMA/SMP friendly.
> > 
> 
> Is it a good idea for all kmem_cache_t? If so, can we move
> __read_mostly to the type definition?
> 

Yes, I suppose that's worthwhile.

We've been shuffling towards removing kmem_cache_t in favour of `struct
kmem_cache', but this is an argument against doing that.

If we can work out how:

void foo()
{
	kmem_cache_t *p;
}

That'll barf.


