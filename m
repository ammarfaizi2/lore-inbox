Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWBMCOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWBMCOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 21:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWBMCOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 21:14:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49621 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751151AbWBMCOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 21:14:14 -0500
Date: Sun, 12 Feb 2006 18:13:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: wli@holomorphy.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] compound page: use page[1].lru
Message-Id: <20060212181312.11392d12.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602130043480.17715@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602121943150.15774@goblin.wat.veritas.com>
	<20060212135457.2a3d3b37.akpm@osdl.org>
	<Pine.LNX.4.61.0602130043480.17715@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Sun, 12 Feb 2006, Andrew Morton wrote:
> > 
> > I'm scratching my head over flush_dcache_page() on, say, sparc64.  For
> > example, the one in fs/direct-io.c.  With this patch, we'll call
> > flush_dcache_page_impl(), which at least won't crash.  Before the patch I
> > think we'd just do random stuff.
> 
> A head-scratching business indeed.  I think your description is right.
> 
> I haven't looked up the intersection of the set of arches which have
> hugetlb with the set of arches which do something in flush_dcache_page,
> but maybe you have, and found sparc64 the only or most significant.

We have a page which has no ->mapping, but lo, it's mmapped by userspace
and can be MAP_SHARED between different CPUs and processes.

Yes, I suspect it'll do the wrong thing in unpleasantly subtle ways.

(cc's davem and runs away).

