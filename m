Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWCQQLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWCQQLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWCQQLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:11:12 -0500
Received: from mx.pathscale.com ([64.160.42.68]:52415 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751006AbWCQQLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:11:12 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Roland Dreier <rdreier@cisco.com>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <441A04D0.3060201@yahoo.com.au>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>
	 <4419062C.6000803@yahoo.com.au>
	 <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>
	 <441A04D0.3060201@yahoo.com.au>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 17 Mar 2006 08:11:01 -0800
Message-Id: <1142611861.28538.22.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 11:37 +1100, Nick Piggin wrote:

> But it doesn't look like dma_alloc_coherent is guaranteed to return
> memory allocated from the regular page allocator, nor even memory
> backed by a struct page.

Hmm.  Which of the implementations that you've seen will return
something not backed by a struct page?  On the half dozen arches I've
looked at (i386/x86_64, powerpc, sparc64, ia64, mips), every one uses
either kmalloc, __get_free_pages, or __alloc_pages at some point, and I
think they all have struct pages behind them.

> For example, I see one that returns kmalloc()ed memory. If the pages
> for the slab are already allocated then __GFP_COMP will not do anything
> there.

Bleh.  Perhaps I'm being dense here, but if I'm making a request of
non-zero order and the slab has already been allocated, won't it be
populated with compound pages anyway?  Or will it have been allocated as
a single giant compound page, just handing me back individual hunks of
the appropriate size?

I ask this because I seemed to be getting compound pages out of
dma_alloc_coherent even when I *wasn't* passing in __GFP_COMP.  This is
apparently why PG_private was set on the individual pages I was getting
back.

	<b

