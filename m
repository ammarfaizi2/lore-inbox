Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbRE3OBJ>; Wed, 30 May 2001 10:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262797AbRE3OA7>; Wed, 30 May 2001 10:00:59 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27488 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262796AbRE3OAs>; Wed, 30 May 2001 10:00:48 -0400
Date: Wed, 30 May 2001 16:00:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@kernel.org>
Cc: Mark Hemment <markhe@veritas.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, riel@conectiva.com.br,
        andrea@e-mind.com
Subject: Re: [patch] 4GB I/O, cut three
Message-ID: <20010530160008.C1408@athlon.random>
In-Reply-To: <20010529160704.N26871@suse.de> <Pine.LNX.4.21.0105301022410.7153-100000@alloc> <20010530115538.B15089@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010530115538.B15089@suse.de>; from axboe@kernel.org on Wed, May 30, 2001 at 11:55:38AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ my usual email is offline at the moment, please CC to andrea@e-mind.com
  for anything urgent until the problem is fixed ]

On Wed, May 30, 2001 at 11:55:38AM +0200, Jens Axboe wrote:
> On Wed, May 30 2001, Mark Hemment wrote:
> > Hi Jens,
> > 
> >   I ran this (well, cut-two) on a 4-way box with 4GB of memory and a
> > modified qlogic fibre channel driver with 32disks hanging off it, without
> > any problems.  The test used was SpecFS 2.0
> 
> Cool, could you send me the qlogic diff? It's the one-liner can_dma32
> chance I'm interested in, I'm just not sure what driver you used :-)
> I'll add that to the patch then. Basically all the PCI cards should
> work, I'm just being cautious and only enabling highmem I/O to the ones
> that have been tested.
> 
> >   Peformance is definitely up - but I can't give an exact number, as the
> > run with this patch was compiled with no-omit-frame-pointer for debugging
> > any probs.
> 
> Good
> 
> >   I did change the patch so that bounce-pages always come from the NORMAL
> > zone, hence the ZONE_DMA32 zone isn't needed.  I avoided the new zone, as
> > I'm not 100% sure the VM is capable of keeping the zones it already has
> > balanced - and adding another one might break the camels back.  But as the
> > test box has 4GB, it wasn't bouncing anyway.
> 
> You are right, this is definitely something that needs checking. I
> really want this to work though. Rik, Andrea? Will the balancing handle
> the extra zone?

The bounces can came from the ZONE_NORMAL without problems, however the
ZONE_DMA32 way is fine too, but yes probably it isn't needed in real
life unless you do an huge amount of I/O at the same time. If you want
to reduce the amount of changes you can defer the zone_dma32 patch and
possibly plug it in later.

Andrea
