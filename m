Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275423AbRIZSPC>; Wed, 26 Sep 2001 14:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275427AbRIZSOx>; Wed, 26 Sep 2001 14:14:53 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:59398 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S275423AbRIZSOo>;
	Wed, 26 Sep 2001 14:14:44 -0400
From: tpepper@vato.org
Date: Wed, 26 Sep 2001 11:15:09 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        =?iso-8859-1?Q?Jacek_=5Biso-8859-2=5D_Pop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010926111509.A3332@cb.vato.org>
In-Reply-To: <20010926000922.I8350@athlon.random> <Pine.LNX.4.21.0109251823550.2193-100000@freak.distro.conectiva> <20010926010516.V8350@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010926010516.V8350@athlon.random>; from andrea@suse.de on Wed, Sep 26, 2001 at 01:05:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26 Sep at 01:05:16 +0200 andrea@suse.de done said:
> On Tue, Sep 25, 2001 at 06:25:10PM -0300, Marcelo Tosatti wrote:
> > 
> > Does vm-tweaks-1 fixes the current problem we're seeing? 
> 
> it seems no by reading the last email, however I'm not seeing any
> problem, the DEBUG_GFP will tell us where the problem cames from,
> pssobly it's a highmem thing since I never reproduced anything bad here.
> But the point is that the above isn't going to be a right fix anyways.

vm-tweaks-1 fixes things for me.  I've got 512MB ram (kernel not
configured for highmem) and 1 gig of swap.  The workload is heavy file
i/o and has now been running almost 24 hours (about 2 billion I/Os or
a few TB of data I think so far).  Previously all the memory was being
consumed by cache, nothing swapped (as expected if the memory is cached
buffer i/o right?) and I'd get the:
	__alloc_pages: 0-order allocation failed
Now I continue to see the memory consumption / no swap, and no more
error...iow the expected behaviour.

On an unrelated note if I want to backport the async I/O changes in 2.4.10,
are there patches from you I should apply other than:
	2.4.10pre10aa1/40_blkdev-pagecache-17
	2.4.7pre8aa1/41_blkdev-pagecache-5_drop_get_bh_async-1


Tim
