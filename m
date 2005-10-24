Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVJXE7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVJXE7j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 00:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVJXE7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 00:59:39 -0400
Received: from gold.veritas.com ([143.127.12.110]:53145 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750999AbVJXE7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 00:59:38 -0400
Date: Mon, 24 Oct 2005 05:58:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: clameter@sgi.com, rmk@arm.linux.org.uk, matthew@wil.cx, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mm: split page table lock
In-Reply-To: <20051023211630.44459ff7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0510240538580.22972@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
 <20051023142712.6c736dd3.akpm@osdl.org> <20051023152245.4d1dc812.akpm@osdl.org>
 <Pine.LNX.4.61.0510240412350.22131@goblin.wat.veritas.com>
 <20051023211630.44459ff7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Oct 2005 04:59:38.0129 (UTC) FILETIME=[BC354810:01C5D857]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> I'm rather surprised that no architectures are already using page.mapping,
> .index, .lru or .virtual in pte pages.

It is important that we don't corrupt .virtual.  But beyond that, why
should they use those fields?  Some were used in the pte_chains days,
and ppc held on to that usage for a while longer (to get from page
table to mm), but that is all gone now.  Unless I've missed something.

> > > ick.  I think I prefer the union, although it'll make struct page bigger
> > > for CONFIG_PREEMPT+CONFIG_SMP+NR_CPUS>=4.    hmm.
> > 
> > Hmm indeed.  Definitely not the tradeoff I chose or would choose.
> 
> It's not that bad, really.  I do think that this approach is just too
> dirty, sorry.  We can avoid it by moving something else into the union. 
> lru, perhaps?

Perhaps.  But revisiting this is not something I'm prepared to rush
into overnight - right answers come slower.  I'd rather we start with
what I had, tested on few architectures as it is, and consider how to
robustify it more sedately.

Or, if you prefer, disable the split (raise Kconfig default to "4096"), or
back out the 7/9 for the moment; though I had been hoping for exposure.

Hugh
