Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbRE3J4R>; Wed, 30 May 2001 05:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbRE3J4H>; Wed, 30 May 2001 05:56:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1040 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262659AbRE3J4B>;
	Wed, 30 May 2001 05:56:01 -0400
Date: Wed, 30 May 2001 11:55:38 +0200
From: Jens Axboe <axboe@kernel.org>
To: Mark Hemment <markhe@veritas.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, riel@conectiva.com.br,
        andrea@e-mind.com
Subject: Re: [patch] 4GB I/O, cut three
Message-ID: <20010530115538.B15089@suse.de>
In-Reply-To: <20010529160704.N26871@suse.de> <Pine.LNX.4.21.0105301022410.7153-100000@alloc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105301022410.7153-100000@alloc>; from markhe@veritas.com on Wed, May 30, 2001 at 10:43:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30 2001, Mark Hemment wrote:
> Hi Jens,
> 
>   I ran this (well, cut-two) on a 4-way box with 4GB of memory and a
> modified qlogic fibre channel driver with 32disks hanging off it, without
> any problems.  The test used was SpecFS 2.0

Cool, could you send me the qlogic diff? It's the one-liner can_dma32
chance I'm interested in, I'm just not sure what driver you used :-)
I'll add that to the patch then. Basically all the PCI cards should
work, I'm just being cautious and only enabling highmem I/O to the ones
that have been tested.

>   Peformance is definitely up - but I can't give an exact number, as the
> run with this patch was compiled with no-omit-frame-pointer for debugging
> any probs.

Good

>   I did change the patch so that bounce-pages always come from the NORMAL
> zone, hence the ZONE_DMA32 zone isn't needed.  I avoided the new zone, as
> I'm not 100% sure the VM is capable of keeping the zones it already has
> balanced - and adding another one might break the camels back.  But as the
> test box has 4GB, it wasn't bouncing anyway.

You are right, this is definitely something that needs checking. I
really want this to work though. Rik, Andrea? Will the balancing handle
the extra zone?

-- 
Jens Axboe

