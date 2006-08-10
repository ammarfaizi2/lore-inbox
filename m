Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWHJSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWHJSwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWHJSwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:52:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15239 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161166AbWHJSwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:52:41 -0400
Date: Thu, 10 Aug 2006 11:52:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, mpm@selenic.com,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
In-Reply-To: <44DB7F29.3060901@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608101148140.9601@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
 <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
 <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
 <20060810151305.bc4602e0.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608100823580.8368@schroedinger.engr.sgi.com>
 <44DB7F29.3060901@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006, Manfred Spraul wrote:

> > Yes that is a general problem with RCU freeing. One can use the
> > SLAB_DESTROY_BY_RCU option to have RCU applied to the whole slab. In that
> > case on can use the cache hot effect but has the additional problem in RCU
> > of dealing with the issue that the object can be replaced at any time.
> >  
> No SLAB_DESTROY_BY_RCU is not equivalent to delayed_free_foo().
> SLAB_DESTROY_BY_RCU just means that the slab allocator uses
> delayed_free_pages() instead of free_pages().
> kmem_cache_free() does not delay the reuse, an object will be returned by the
> next kmem_cache_alloc, without any grace periods in between.

Yes that is what I said. SLAB_DESTROY_BY_RCU is RCU applied to the "whole 
slab".

> Independantly from that point, we need some benchmarks to test the allocator.

Right. This is pretty early for tests though. Its barely functional.

> The last benchmarks  of the slab allocator (that I'm aware of) were done with
> packet routing - packet routing was the reason why the shared_array layer was
> added:
> The shared_array layer is used to perform inter-cpu bulk object transfers.
> Without that cache, i.e. if a list_add() / list_del() was required to transfer
> one object from one cpu to another cpu, a significant amount of time was spent
> in the allocator.

If the overhead of general allocation/free from a slab is reduced then 
this effect should not occur. IMHO it may turn out that the need for 
the shared array is an artifact of the per cpu caches. 
