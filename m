Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313818AbSDUU4T>; Sun, 21 Apr 2002 16:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313824AbSDUU4S>; Sun, 21 Apr 2002 16:56:18 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:36357 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S313818AbSDUU4Q>;
	Sun, 21 Apr 2002 16:56:16 -0400
Date: Sun, 21 Apr 2002 21:54:59 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc comments patch
In-Reply-To: <20020420234752.GA26727@krispykreme>
Message-ID: <Pine.LNX.4.44.0204212153200.1650-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Apr 2002, Anton Blanchard wrote:

> > + * To give a safety margin, the linear address starts about 8MB after the end
> > + * of physical memory at VMALLOC_START. This is to try and catch memory
> > + * overruns.
>
> Thats architecture dependent. On ppc64 for example the kernel text
> starts at 0xC000000000000000 and the vmalloc region starts at
> 0xD000000000000000, 2^60 bits apart.
>

Changed to

 * These are the functions for assigning a block of linear addresses for pages.
 * To give a safety margin, the linear address starts at VMALLOC_START.
 * This is at PAGE_OFFSET + VMALLOC_OFFSET which are all arch dependant
 * values

Is that ok?

> >  		spin_unlock(&init_mm.page_table_lock);
> >  		page = alloc_page(gfp_mask);
> >  		spin_lock(&init_mm.page_table_lock);
>
> Since alloc_page can sleep we must drop the spinlock.
>

Changed to

                /* The page table lock has to be released because alloc_page
                 * could sleep if memory is low
                 */

All good?

			Mel

