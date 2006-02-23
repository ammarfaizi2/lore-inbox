Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751709AbWBWKKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbWBWKKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 05:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWBWKKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 05:10:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751706AbWBWKKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 05:10:47 -0500
Date: Thu, 23 Feb 2006 02:09:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alok Kataria <alok.kataria@calsoftinc.com>
Cc: penberg@cs.helsinki.fi, clameter@engr.sgi.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: slab: Remove SLAB_NO_REAP option
Message-Id: <20060223020957.478d4cc1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alok Kataria <alok.kataria@calsoftinc.com> wrote:
>
>  On Thu, 2006-02-23 at 14:18, Pekka Enberg wrote:
>  On 2/23/06, Alok Kataria <alok.kataria@calsoftinc.com> wrote:
>  > > There can be some caches which are not used quite often, kmem_cache 
>  > > for instance. Now from performance perspective having SLAB_NO_REAP for 
>  > > such caches is good.
>  >
>  > Yeah, kmem_cache sounds like a realistic user, but I am wondering if
>  > it makes any sense for anyone else to use it?
>  >
>  Right, thats why my question still is why do these iscsi & ocfs  cache 
>  have this flag set.

I'm sure there's no good reason.

>  If we are sure that the flag is still required, we can use the patch 
>  below.

I'm very much hoping that it is not needed.  Would prefer to just toss the
whole thing away.

What's it supposed to do anyway?  Keep wholly-unused pages hanging about in
each slab cache?  If so, it may well be a net loss - it'd be better to push
those pages back into the page allocator so they can get reused for
something else while they're possibly still in-cache.  Similarly, it's
better to fall back to the page allocator for a new slab page because
that's more likely to give us a cache-hot one.

I'm convinced, anyway ;)
