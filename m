Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136480AbREIOP2>; Wed, 9 May 2001 10:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136482AbREIOPS>; Wed, 9 May 2001 10:15:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:268 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136480AbREIOPD>;
	Wed, 9 May 2001 10:15:03 -0400
Date: Wed, 9 May 2001 16:14:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: blkdev in pagecache
Message-ID: <20010509161452.A521@suse.de>
In-Reply-To: <20010509043456.A2506@athlon.random> <3AF90A3D.7DD7A605@evision-ventures.com> <20010509151612.D2506@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010509151612.D2506@athlon.random>; from andrea@suse.de on Wed, May 09, 2001 at 03:16:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09 2001, Andrea Arcangeli wrote:
> On Wed, May 09, 2001 at 11:13:33AM +0200, Martin Dalecki wrote:
> > >   (buffered and direct) to work with a 4096 bytes granularity instead of
> > 
> > You mean PAGE_SIZE :-).
> 
> In my first patch it is really 4096 bytes, but yes I agree we should
> change that to PAGE_CACHE_SIZE. The _only_ reason it's 4096 fixed bytes is that
> I wasn't sure all the device drivers out there can digest a bh->b_size of
> 8k/32k/64k (for the non x86 archs) and I checked the minimal PAGE_SIZE
> supported by linux is 4k. If Jens says I can sumbit 64k b_size without
> any problem for all the relevant blkdevices then I will change that in a
> jiffy ;). Anyways changing that is truly easy, just define

On IDE it should at least be possible, it can handle single segment
entries as big as 64kB for DMA. But apart from that, I think it's a lot
better to stay with PAGE_CACHE_SIZE and not get into dark country :-)

-- 
Jens Axboe

