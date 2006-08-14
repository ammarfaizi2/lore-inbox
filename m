Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752010AbWHNLkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbWHNLkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWHNLkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:40:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:35250 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752007AbWHNLkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:40:23 -0400
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
References: <20060814110359.GA27704@2ka.mipt.ru>
From: Andi Kleen <ak@suse.de>
Date: 14 Aug 2006 13:40:21 +0200
In-Reply-To: <20060814110359.GA27704@2ka.mipt.ru>
Message-ID: <p73k65ba6l6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:

> Design notes.
> Original idea was to store meta information used for allocation in an
> AVL tree [1], but since I found a way to use some "unused" fields in struct page,
> tree is unused in the allocator.

But there seems to be still an AVL tree in there?


> Benchmarks with trivial epoll based web server showed noticeble (more
> than 40%) imrovements of the request rates (1600-1800 requests per
> second vs. more than 2300 ones). It can be described by more
> cache-friendly freeing algorithm, by tighter objects packing and thus
> reduced cache line ping-pongs, reduced lookups into higher-layer caches
> and so on.

So what are its drawbacks compared to slab/kmalloc? 

Also if it really performs that much better it might be a good
idea to replace all of kmalloc() with it, but doing that
would require a lot more benchmarks with various workloads
and small and big machines first.

-Andi

