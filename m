Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRDPMxM>; Mon, 16 Apr 2001 08:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbRDPMxD>; Mon, 16 Apr 2001 08:53:03 -0400
Received: from iris.mc.com ([192.233.16.119]:2438 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S131457AbRDPMws>;
	Mon, 16 Apr 2001 08:52:48 -0400
From: Mark Salisbury <mbs@mc.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Ben Greear <greearb@candelatech.com>
Subject: Re: No 100 HZ timer!
Date: Mon, 16 Apr 2001 08:36:10 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: george anzinger <george@mvista.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <3ADA60C6.1593A2BF@candelatech.com> <20010416044630.A18776@pcep-jamie.cern.ch>
In-Reply-To: <20010416044630.A18776@pcep-jamie.cern.ch>
MIME-Version: 1.0
Message-Id: <0104160841431V.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

all this talk about which data structure to use and how to allocate memory is
waaaay premature.

there needs to be a clear definition of the requirements that we wish to meet,
including whether we are going to do ticked, tickless, or both

a func spec, for lack of a better term needs to be developed

then, when we go to design the thing, THEN is when we decide on the particular
flavor of list/tree/heap/array/dbase that we use.

let's engineer this thing instead of hacking it.



On Sun, 15 Apr 2001, Jamie Lokier wrote:
> Ben Greear wrote:
> > > Note that jumping around the array thrashes no more cache than
> > > traversing a tree (it touches the same number of elements).  I prefer
> > > heap-ordered trees though because fixed size is always a bad idea.
> > 
> > With a tree, you will be allocating and de-allocating for every
> > insert/delete right?
> 
> No, there is no memory allocation.
> 
> > On cache-coherency issues, wouldn't it be more likely to have a cache
> > hit when you are accessing one contigious (ie the array) piece of
> > memory?  A 4-k page will hold a lot of indexes!!
> 
> No, because when traversing an array-heap, you don't access contiguous
> entries.  You might get one or two more cache hits near the root of the
> heap.
> 
> > To get around the fixed size thing..could have
> > the array grow itself when needed (and probably never shrink again).
> 
> You could to that, but then you'd have to deal with memory allocation
> failures and memory deadlocks, making add_timer rather complicated.
> It's not acceptable for add_timer to fail or require kmalloc().
> 
> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

