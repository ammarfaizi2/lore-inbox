Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132844AbRDPCrI>; Sun, 15 Apr 2001 22:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132845AbRDPCq5>; Sun, 15 Apr 2001 22:46:57 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:21253 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132844AbRDPCqr>;
	Sun, 15 Apr 2001 22:46:47 -0400
Date: Mon, 16 Apr 2001 04:46:30 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ben Greear <greearb@candelatech.com>
Cc: george anzinger <george@mvista.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
Message-ID: <20010416044630.A18776@pcep-jamie.cern.ch>
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <3AD77540.42BF138E@mvista.com> <20010414011035.D2290@pcep-jamie.cern.ch> <3ADA60C6.1593A2BF@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ADA60C6.1593A2BF@candelatech.com>; from greearb@candelatech.com on Sun, Apr 15, 2001 at 08:02:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> > Note that jumping around the array thrashes no more cache than
> > traversing a tree (it touches the same number of elements).  I prefer
> > heap-ordered trees though because fixed size is always a bad idea.
> 
> With a tree, you will be allocating and de-allocating for every
> insert/delete right?

No, there is no memory allocation.

> On cache-coherency issues, wouldn't it be more likely to have a cache
> hit when you are accessing one contigious (ie the array) piece of
> memory?  A 4-k page will hold a lot of indexes!!

No, because when traversing an array-heap, you don't access contiguous
entries.  You might get one or two more cache hits near the root of the
heap.

> To get around the fixed size thing..could have
> the array grow itself when needed (and probably never shrink again).

You could to that, but then you'd have to deal with memory allocation
failures and memory deadlocks, making add_timer rather complicated.
It's not acceptable for add_timer to fail or require kmalloc().

-- Jamie
