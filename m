Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRCWWYg>; Fri, 23 Mar 2001 17:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRCWWY1>; Fri, 23 Mar 2001 17:24:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47844 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131483AbRCWWYO>;
	Fri, 23 Mar 2001 17:24:14 -0500
Date: Fri, 23 Mar 2001 17:23:29 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ben LaHaise <bcrl@redhat.com>,
        Christoph Rohland <cr@sap.com>
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
In-Reply-To: <E14gZuj-0005YN-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0103231721120.10092-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Alan Cox wrote:

> > On Fri, 23 Mar 2001, Stephen C. Tweedie wrote:
> > >
> > > The patch below is for two races in sysV shared memory.
> > 
> > 	+       spin_lock (&info->lock);
> > 	+
> > 	+       /* The shmem_swp_entry() call may have blocked, and
> > 	+        * shmem_writepage may have been moving a page between the page
> > 	+        * cache and swap cache.  We need to recheck the page cache
> > 	+        * under the protection of the info->lock spinlock. */
> > 	+
> > 	+       page = find_lock_page(mapping, idx);
> > 
> > Ehh.. Sleeping with the spin-lock held? Sounds like a truly bad idea.
> 
> Umm find_lock_page doesnt sleep does it ?

It certainly does. find_lock_page() -> __find_lock_page() -> lock_page() ->
-> __lock_page() -> schedule().

