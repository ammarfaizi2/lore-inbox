Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbRE3OMW>; Wed, 30 May 2001 10:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbRE3OMB>; Wed, 30 May 2001 10:12:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2322 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262800AbRE3OL5>;
	Wed, 30 May 2001 10:11:57 -0400
Date: Wed, 30 May 2001 16:06:53 +0200
From: Jens Axboe <axboe@kernel.org>
To: andrea@e-mind.com
Cc: Jens Axboe <axboe@kernel.org>, Mark Hemment <markhe@veritas.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: [patch] 4GB I/O, cut three
Message-ID: <20010530160653.G17136@suse.de>
In-Reply-To: <20010529160704.N26871@suse.de> <Pine.LNX.4.21.0105301022410.7153-100000@alloc> <20010530115538.B15089@suse.de> <20010530160008.C1408@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010530160008.C1408@athlon.random>; from andrea@suse.de on Wed, May 30, 2001 at 04:00:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30 2001, Andrea Arcangeli wrote:
> > >   I did change the patch so that bounce-pages always come from the NORMAL
> > > zone, hence the ZONE_DMA32 zone isn't needed.  I avoided the new zone, as
> > > I'm not 100% sure the VM is capable of keeping the zones it already has
> > > balanced - and adding another one might break the camels back.  But as the
> > > test box has 4GB, it wasn't bouncing anyway.
> > 
> > You are right, this is definitely something that needs checking. I
> > really want this to work though. Rik, Andrea? Will the balancing handle
> > the extra zone?
> 
> The bounces can came from the ZONE_NORMAL without problems, however the

Of course

> ZONE_DMA32 way is fine too, but yes probably it isn't needed in real
> life unless you do an huge amount of I/O at the same time. If you want

It's not strictly needed, but it does buy us 3 extra gig to do I/O from
an a pae enabled x86.

> to reduce the amount of changes you can defer the zone_dma32 patch and
> possibly plug it in later.

Yes, I did modular patches for this reason.

Thanks!

-- 
Jens Axboe

