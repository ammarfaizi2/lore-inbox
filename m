Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUFECSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUFECSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 22:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265991AbUFECSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 22:18:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:45984 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264512AbUFECST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 22:18:19 -0400
Date: Sat, 5 Jun 2004 04:18:13 +0200
From: Andi Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use numa policy API for boot time policy
Message-Id: <20040605041813.75e2d22d.ak@suse.de>
In-Reply-To: <40C12865.9050803@colorfullife.com>
References: <20040605034356.1037d299.ak@suse.de>
	<40C12865.9050803@colorfullife.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jun 2004 03:56:53 +0200
Manfred Spraul <manfred@colorfullife.com> wrote:

> Andi Kleen wrote:
> 
> >Suggested by Manfred Spraul.
> >
> >__get_free_pages had a hack to do node interleaving allocation at boot time.
> >This patch sets an interleave process policy using the NUMA API for init
> >and the idle threads instead. Before entering the user space init the policy
> >is reset to default again. Result is the same.
> >
> >Advantage is less code and removing of a check from a fast path.
> >
> >Removes more code than it adds.
> >
> >I verified that the memory distribution after boot is roughly the same.
> >
> >  
> >
> Does it work for order != 0 allocations? It's important that the big 
> hash tables do not end up all in node 0. AFAICS alloc_pages_current() 
> calls interleave_nodes() only for order==0 allocs.

That's correct. It will only work for order 0 allocations.

But it sounds quite bogus anyways to move the complete hash tables
to another node anyways. It would probably be better to use vmalloc() 
and a interleaving mapping for it. Then you would get the NUMA bandwidth 
benefit even for accessing single tables.

-Andi
