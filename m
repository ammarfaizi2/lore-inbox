Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274677AbRITWZk>; Thu, 20 Sep 2001 18:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274678AbRITWZa>; Thu, 20 Sep 2001 18:25:30 -0400
Received: from [195.223.140.107] ([195.223.140.107]:63989 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274677AbRITWZW>;
	Thu, 20 Sep 2001 18:25:22 -0400
Date: Fri, 21 Sep 2001 00:25:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: flush_tlb_all in vmalloc_area_pages
Message-ID: <20010921002547.G729@athlon.random>
In-Reply-To: <20010907165612.T11329@athlon.random> <20010920.142638.68040129.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010920.142638.68040129.davem@redhat.com>; from davem@redhat.com on Thu, Sep 20, 2001 at 02:26:38PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 02:26:38PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Fri, 7 Sep 2001 16:56:12 +0200
>    
>    For the flush_cache_all for the virtually indexed caches should be the
>    same issue in theory (at least the kmap logic only needs to flush the
>    caches before the unmapping [not before the mapping] too)
>    
>    Am I missing something, Dave?
> 
> Anything that creates or takes away vmalloc() mappings needs to flush
> the data cache if it is virtuall indexed.

The only question I'd like to get a answer is "what is actually the
data that can be virtually indexed) in the vmalloc range at the time we
run vmalloc?" Where does it cames from?

If there is no such data (as I think), we obviously don't need to flush
the virtually indexed caches at vmalloc time (but just at vfree).

Furthmore I recall on sparc you cannot flush the cache if you don't have
a mapping in place, and when you run vmalloc there should be no mapping
in place for the region of cache that you're trying to flush (or we
wouldn't trap the invalid faults there).

If anybody is using at boot time the vmalloc range for whatever purpuse
it should be its own business to flush the cache before dropping the
mappings from there.

Andrea
