Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752012AbWHNLqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbWHNLqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbWHNLqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:46:35 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:23003 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750727AbWHNLqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:46:34 -0400
Date: Mon, 14 Aug 2006 15:46:16 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andi Kleen <ak@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060814114615.GA18321@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <p73k65ba6l6.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <p73k65ba6l6.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 14 Aug 2006 15:46:19 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 01:40:21PM +0200, Andi Kleen (ak@suse.de) wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:
> 
> > Design notes.
> > Original idea was to store meta information used for allocation in an
> > AVL tree [1], but since I found a way to use some "unused" fields in struct page,
> > tree is unused in the allocator.
> 
> But there seems to be still an AVL tree in there?

Yep.
Tree structure can be used for simpler memory addon/removal from
hotplug, but I have not that in mind.
It will be removed soon.
 
> > Benchmarks with trivial epoll based web server showed noticeble (more
> > than 40%) imrovements of the request rates (1600-1800 requests per
> > second vs. more than 2300 ones). It can be described by more
> > cache-friendly freeing algorithm, by tighter objects packing and thus
> > reduced cache line ping-pongs, reduced lookups into higher-layer caches
> > and so on.
> 
> So what are its drawbacks compared to slab/kmalloc? 

Hmm... Bigger per-page overhead (additional bitmask of free/used
objects). More complex algorithm behind freeing.

> Also if it really performs that much better it might be a good
> idea to replace all of kmalloc() with it, but doing that
> would require a lot more benchmarks with various workloads
> and small and big machines first.

First user can be MMU-less systems which suffer noticebly from
fragmentations and power-of-two overhead.

> -Andi

-- 
	Evgeniy Polyakov
