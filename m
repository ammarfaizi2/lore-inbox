Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSHKJeo>; Sun, 11 Aug 2002 05:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSHKJeo>; Sun, 11 Aug 2002 05:34:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37898 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317012AbSHKJen>;
	Sun, 11 Aug 2002 05:34:43 -0400
Message-ID: <3D5632E7.F801228F@zip.com.au>
Date: Sun, 11 Aug 2002 02:48:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 13/21] deferred and batched addition of faulted-in pages to 
 the   LRU
References: <3D5614B2.EFD25A8D@zip.com.au.suse.lists.linux.kernel> <p73wuqxiwar.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Andrew Morton <akpm@zip.com.au> writes:
> >   */
> > -void lru_cache_add(struct page * page)
> > +static struct pagevec lru_add_pvecs[NR_CPUS];
> > +
> > +void lru_cache_add(struct page *page)
> > +{
> > +     struct pagevec *pvec = &lru_add_pvecs[get_cpu()];
> 
> This should probably use the linux/percpu.h macros.
> This way it could be more efficient on some architectures and also avoid
> potential false sharing.

Yes, I need to do a sweep sometime and convert some things like
that. Preferably after the hot-remove APIs are there.  Or is
that not planned?
