Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSHKJnk>; Sun, 11 Aug 2002 05:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSHKJnk>; Sun, 11 Aug 2002 05:43:40 -0400
Received: from ns.suse.de ([213.95.15.193]:6157 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317520AbSHKJnj>;
	Sun, 11 Aug 2002 05:43:39 -0400
Date: Sun, 11 Aug 2002 11:47:26 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch 13/21] deferred and batched addition of faulted-in pages to the   LRU
Message-ID: <20020811114726.A29079@wotan.suse.de>
References: <3D5614B2.EFD25A8D@zip.com.au.suse.lists.linux.kernel> <p73wuqxiwar.fsf@oldwotan.suse.de> <3D5632E7.F801228F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5632E7.F801228F@zip.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 02:48:23AM -0700, Andrew Morton wrote:
> Andi Kleen wrote:
> > 
> > Andrew Morton <akpm@zip.com.au> writes:
> > >   */
> > > -void lru_cache_add(struct page * page)
> > > +static struct pagevec lru_add_pvecs[NR_CPUS];
> > > +
> > > +void lru_cache_add(struct page *page)
> > > +{
> > > +     struct pagevec *pvec = &lru_add_pvecs[get_cpu()];
> > 
> > This should probably use the linux/percpu.h macros.
> > This way it could be more efficient on some architectures and also avoid
> > potential false sharing.
> 
> Yes, I need to do a sweep sometime and convert some things like
> that. Preferably after the hot-remove APIs are there.  Or is
> that not planned?

I would see them as independent problems. No need to stall one by the other.

-Andi
