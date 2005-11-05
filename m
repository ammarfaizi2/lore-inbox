Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVKEAFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVKEAFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVKEAFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:05:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54491 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751167AbVKEAFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:05:46 -0500
Date: Fri, 4 Nov 2005 16:05:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export ia64_max_cacheline_size
Message-Id: <20051104160540.486051ed.akpm@osdl.org>
In-Reply-To: <20051104235257.GA21674@infradead.org>
References: <20051104220737.GA16551@redhat.com>
	<20051104223441.GA16285@infradead.org>
	<20051104145534.17e913f2.akpm@osdl.org>
	<20051104235257.GA21674@infradead.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Nov 04, 2005 at 02:55:34PM -0800, Andrew Morton wrote:
> > > Can we please move dma_get_cache_alignment() out of line instead?
> > 
> > It's a single statement!  It wants to be inlined.
> > 
> > > Always export sane APIs instead of random internals.
> > 
> > The exported API is dma_get_cache_alignment().  For internal implementation
> > reasons we need to export an ia64 symbol to modules to support it.  That
> > kinda sucks, but I don't think that we need to compromise kernel size and
> > performance because of it.
> 
> It's an API used only in slow pathes.  It's much better to enforce modularity
> in that case.

hm, spose so.  Putting it into .c means that all arches except one
implement it under include/, which is also a bit irritating sometimes, such
as $EDITOR include/asm-*/dma-mapping.h.

It's a 51%/49% decision, but I'm not sure which way.
