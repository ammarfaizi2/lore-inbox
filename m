Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272112AbRHVUZl>; Wed, 22 Aug 2001 16:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272110AbRHVUZc>; Wed, 22 Aug 2001 16:25:32 -0400
Received: from abasin.nj.nec.com ([138.15.150.16]:3851 "HELO abasin.nj.nec.com")
	by vger.kernel.org with SMTP id <S272112AbRHVUZR>;
	Wed, 22 Aug 2001 16:25:17 -0400
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15236.5429.958675.175951@abasin.nj.nec.com>
Date: Wed, 22 Aug 2001 16:25:25 -0400 (EDT)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
In-Reply-To: <Pine.LNX.4.21.0108221241040.2202-100000@freak.distro.conectiva>
In-Reply-To: <15235.55592.699783.338199@abasin.nj.nec.com>
	<Pine.LNX.4.21.0108221241040.2202-100000@freak.distro.conectiva>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cool, it now compiles, runs and doesn't crash while running bonnie++
like it did before.  I've told my users to beat at it.  if it crashes
or continues to get bad disk performance i'm sure the list will hear
from me.  Hopefully I'll be able to test more changes if they need
testing.

	Sven

Marcelo Tosatti writes:
 > 
 > Sven,
 > 
 > There is another mistake on the patch I sent you.
 > 
 > On buffer.c, instead 
 > 
 > "page->zone == &pgdat_list->node_zones[ZONE_HIGHMEM]"
 >             ^^
 > you should use
 > 
 > "page->zone != &pgdat_list->node_zones[ZONE_HIGHMEM]"
 > 	    ^^ 
 > 
 > Ok? 
 > 
 > On Wed, 22 Aug 2001, Sven Heinicke wrote:
 > 
 > > 
 > > I tried you patch below, to compile I had to edit like 2451 of
 > > buffer.c, after the patch to be "page->zone" instead of "page-zone".
 > > After that the build want great.  But part of the way through running
 > > bonnie++ the system crashed in a way that it didn't write anything to
 > > the sylog.  The terminal was spewing:
 > > 
 > > APIC error on CPU0: 0c(0c)
 > > APIC error on CPU1: 0c(0c)
 > > 
 > > I've really gotta put that system back into production.  As it seems
 > > much better off before the I started this thread with the 2.4.8-ac8
 > > kernel.
 > > 
 > > 	Sven
 > > 
 > > Marcelo Tosatti writes:
 > >  > 
 > >  > 
 > >  > On Tue, 21 Aug 2001, Sven Heinicke wrote:
 > >  > 
 > >  > > 
 > >  > > Forgive the sin of replying to my own message but Daniel Phillips
 > >  > > replied to a different message with a patch to somebody getting a
 > >  > > similar error to mine.  Here is the result:
 > >  > > 
 > >  > > Aug 20 15:10:33 ps1 kernel: cation failed (gfp=0x30/1). 
 > >  > > Aug 20 15:10:33 ps1 kernel: __alloc_pages: 0-order allocation failed
 > >  > > (gfp=0x30/1). 
 > >  > > Aug 20 15:10:46 ps1 last message repeated 327 times 
 > >  > > Aug 20 15:10:47 ps1 kernel: cation failed (gfp=0x30/1). 
 > >  > > Aug 20 15:10:47 ps1 kernel: __alloc_pages: 0-order allocation failed
 > >  > > (gfp=0x30/1). 
 > >  > > Aug 20 15:10:56 ps1 last message repeated 294 times 
 > >  > > 
 > >  > > 
 > >  > > Sven Heinicke writes:
 > >  > >  > 
 > >  > >  > It's always a blessing and a curse when people seem to be haveing
 > >  > >  > problems with the same drivers as you.  I started looking into this
 > >  > >  > when I user complained about disk access time.  I think this is
 > >  > >  > related to the running aic7xxx topics.
 > >  > >  > 
 > >  > >  > From my tests, I got a Dell 4400 who's Adaptec 7899P, according to
 > >  > >  > bonnie++, was writing slower then some of my my IDE drives on a
 > >  > >  > different system.  I tried Red Hat's 2.4.3-12smp kernel and got a
 > >  > >  > little improvement.  I then built 2.4.9 and started running bonnie++
 > >  > >  > again and my syslog gets filled up with such errors:
 > >  > >  > 
 > >  > >  > Aug 20 14:23:33 ps1 kernel: __alloc_pages: 0-order all
 > >  > >  > Aug 20 14:23:36 ps1 last message repeated 376 times
 > >  > >  > Aug 20 14:23:36 ps1 kernel: ed.
 > >  > >  > Aug 20 14:23:36 ps1 kernel: __alloc_pages: 0-order all
 > >  > >  > Aug 20 14:23:44 ps1 last message repeated 376 times
 > >  > >  > Aug 20 14:23:44 ps1 kernel: ed.
 > >  > >  > Aug 20 14:23:44 ps1 kernel: __alloc_pages: 0-order all
 > >  > >  > Aug 20 14:23:44 ps1 last message repeated 363 times
 > >  > >  > 
 > >  > >  > With slow access time.  Please request more info if you think it might
 > >  > >  > help.
 > >  > 
 > >  > Sven,
 > >  > 
 > >  > Could you please try the following patch on top of 2.4.9? 
 > >  > 
 > >  > diff -Nur --exclude-from=exclude linux.orig/fs/buffer.c linux/fs/buffer.c
 > >  > --- linux.orig/fs/buffer.c	Wed Aug 15 18:25:49 2001
 > >  > +++ linux/fs/buffer.c	Tue Aug 21 04:54:01 2001
 > >  > @@ -2447,7 +2447,8 @@
 > >  >  	spin_unlock(&free_list[index].lock);
 > >  >  	write_unlock(&hash_table_lock);
 > >  >  	spin_unlock(&lru_list_lock);
 > >  > -	if (gfp_mask & __GFP_IO) {
 > >  > +	if (gfp_mask & __GFP_IO || (gfp_mask & __GFP_NOBOUNCE) 
 > >  > +			&& page-zone == &pgdat_list->node_zones[ZONE_HIGHMEM]) {
 > >  >  		sync_page_buffers(bh, gfp_mask);
 > >  >  		/* We waited synchronously, so we can free the buffers. */
 > >  >  		if (gfp_mask & __GFP_WAIT) {
 > >  > diff -Nur --exclude-from=exclude linux.orig/include/linux/mm.h linux/include/linux/mm.h
 > >  > --- linux.orig/include/linux/mm.h	Wed Aug 15 18:21:11 2001
 > >  > +++ linux/include/linux/mm.h	Tue Aug 21 04:52:08 2001
 > >  > @@ -538,6 +538,8 @@
 > >  >  #define __GFP_HIGH	0x20	/* Should access emergency pools? */
 > >  >  #define __GFP_IO	0x40	/* Can start physical IO? */
 > >  >  #define __GFP_FS	0x80	/* Can call down to low-level FS? */
 > >  > +#define __GFP_NOBOUNCE	0x100	/* Don't do any IO operation which may
 > >  > +				   result in IO bouncing */
 > >  >  
 > >  >  #define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
 > >  >  #define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
 > >  > diff -Nur --exclude-from=exclude linux.orig/include/linux/slab.h linux/include/linux/slab.h
 > >  > --- linux.orig/include/linux/slab.h	Wed Aug 15 18:21:13 2001
 > >  > +++ linux/include/linux/slab.h	Tue Aug 21 04:51:20 2001
 > >  > @@ -23,7 +23,7 @@
 > >  >  #define	SLAB_NFS		GFP_NFS
 > >  >  #define	SLAB_DMA		GFP_DMA
 > >  >  
 > >  > -#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS)
 > >  > +#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS|__GFP_NOBOUNCE)
 > >  >  #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
 > >  >  
 > >  >  /* flags to pass to kmem_cache_create().
 > >  > diff -Nur --exclude-from=exclude linux.orig/mm/highmem.c linux/mm/highmem.c
 > >  > --- linux.orig/mm/highmem.c	Thu Aug 16 13:42:45 2001
 > >  > +++ linux/mm/highmem.c	Tue Aug 21 04:50:08 2001
 > >  > @@ -321,7 +321,7 @@
 > >  >  	struct page *page;
 > >  >  
 > >  >  repeat_alloc:
 > >  > -	page = alloc_page(GFP_NOIO);
 > >  > +	page = alloc_page(GFP_NOIO|__GFP_NOBOUNCE);
 > >  >  	if (page)
 > >  >  		return page;
 > >  >  	/*
 > >  > @@ -359,7 +359,7 @@
 > >  >  	struct buffer_head *bh;
 > >  >  
 > >  >  repeat_alloc:
 > >  > -	bh = kmem_cache_alloc(bh_cachep, SLAB_NOIO);
 > >  > +	bh = kmem_cache_alloc(bh_cachep, SLAB_NOIO|__GFP_NOBOUNCE);
 > >  >  	if (bh)
 > >  >  		return bh;
 > >  >  	/*
 > >  > diff -Nur --exclude-from=exclude linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
 > >  > --- linux.orig/mm/page_alloc.c	Thu Aug 16 13:43:02 2001
 > >  > +++ linux/mm/page_alloc.c	Tue Aug 21 04:51:03 2001
 > >  > @@ -398,7 +398,8 @@
 > >  >  	 * - we're /really/ tight on memory
 > >  >  	 * 	--> try to free pages ourselves with page_launder
 > >  >  	 */
 > >  > -	if (!(current->flags & PF_MEMALLOC)) {
 > >  > +	if (!(current->flags & PF_MEMALLOC) 
 > >  > +			|| ((gfp_mask & __GFP_NOBOUNCE) && !order)) {
 > >  >  		/*
 > >  >  		 * Are we dealing with a higher order allocation?
 > >  >  		 *
 > >  > 
 > > -
 > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > > the body of a message to majordomo@vger.kernel.org
 > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > > Please read the FAQ at  http://www.tux.org/lkml/
 > > 
 > 
