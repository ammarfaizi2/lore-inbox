Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314035AbSEFBT7>; Sun, 5 May 2002 21:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314043AbSEFBT6>; Sun, 5 May 2002 21:19:58 -0400
Received: from [195.223.140.120] ([195.223.140.120]:2346 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314035AbSEFBT5>; Sun, 5 May 2002 21:19:57 -0400
Date: Mon, 6 May 2002 03:20:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Russell King <rmk@arm.linux.org.uk>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020506032054.F6712@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174Vq8-0004BK-00@starship> <20020506015505.B14956@flint.arm.linux.org.uk> <E174Wy4-0004C2-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 03:07:07AM +0200, Daniel Phillips wrote:
> On Monday 06 May 2002 02:55, Russell King wrote:
> > On Mon, May 06, 2002 at 01:54:52AM +0200, Daniel Phillips wrote:
> > > I must be guilty of not explaining clearly.  Suppose you have the following
> > > physical memory map:
> > > 
> > > 	          0: 128 MB
> > > 	  8000,0000: 128 MB
> > > 	1,0000,0000: 128 MB
> > > 	1,8000,0000: 128 MB
> > > 	2,0000,0000: 128 MB
> > > 	2,8000,0000: 128 MB
> > > 	3,0000,0000: 128 MB
> > > 	3,8000,0000: 128 MB
> > > 
> > > The total is 1 GB of installed ram.  Yet the kernel's 1G virtual space,
> > > can only handle 128 MB of it.
> > 
> > I see no problem with the above with the existing discontigmem stuff.
> > discontigmem does *not* require a linear relationship between kernel
> > virtual and physical memory.  I've been running kernels for a while
> > on such systems.
> 
> Look, you've got this:
> 
> #define __phys_to_virt(ppage) ((unsigned long)(ppage) + PAGE_OFFSET - PHYS_OFFSET)
> 
> So, since __phys_to_virt (and hence phys_to_virt and __va) is clearly linear, the
> relation __pa(__va(kva)) == kva cannot hold.  Perhaps that doesn't bother you?

Check my previous email:

	[..] They will all be normal zones provided you implement a static
	view of them in the kernel virtual address space, and you also
	cover page_address/virt_to_page [..]

Depending on the kind of coalescing of those chunks in the direct
mapping virt_to_page/page_address will vary. virt_to_page and
page_address will have all the necessary internal knowledge in order to
make it all zone_normal.

Andrea
