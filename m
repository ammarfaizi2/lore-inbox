Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSC0UTt>; Wed, 27 Mar 2002 15:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293251AbSC0UTj>; Wed, 27 Mar 2002 15:19:39 -0500
Received: from imladris.infradead.org ([194.205.184.45]:7699 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S293181AbSC0UTb>; Wed, 27 Mar 2002 15:19:31 -0500
Date: Wed, 27 Mar 2002 20:19:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kmem_cache_zalloc
Message-ID: <20020327201917.A23810@phoenix.infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>, Eric Sandeen <sandeen@sgi.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1017257958.16305.168.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 01:39:17PM -0600, Eric Sandeen wrote:
> In the interest of whittling down the changes that XFS makes to the core
> kernel, I thought I'd start throwing out some the easier self-contained
> modifications for discussion.
> 
> XFS adds a kmem_cache_zalloc function to mm/slab.c, it does what you
> might expect:  kmem_cache_alloc + memset

I'd really go for k(mem_)zalloc, but a kmem_cache_alloc leads people toward
writing bad code.  The purpose of the slab allocator is to allow caching
readily constructed objects, a _zalloc destroys them on alloc.

I think code using kmem_cache_alloc really wants to use kzalloc and instead
of maintaining it's pool.

	Christoph

