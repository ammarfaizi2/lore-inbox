Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314072AbSEFCaa>; Sun, 5 May 2002 22:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314073AbSEFCa3>; Sun, 5 May 2002 22:30:29 -0400
Received: from [195.223.140.120] ([195.223.140.120]:35632 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314072AbSEFCaZ>; Sun, 5 May 2002 22:30:25 -0400
Date: Mon, 6 May 2002 04:31:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Russell King <rmk@arm.linux.org.uk>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020506043125.L6712@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174Vq8-0004BK-00@starship> <20020506015505.B14956@flint.arm.linux.org.uk> <E174XqN-0004D2-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 04:03:15AM +0200, Daniel Phillips wrote:
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
> I just went through every variant of arm in the kernel tree, and I found that
> *all* of them implement a simple linear relationship between kernel virtual and
> physical memory, of the form:
> 
>    #define __virt_to_phys(vpage) ((vpage) - PAGE_OFFSET + PHYS_OFFSET)
>    #define __phys_to_virt(ppage) ((ppage) + PAGE_OFFSET - PHYS_OFFSET)

ARM is an example that the pgdat way is fine. As an example of the other
part about the zone_normal coalescing (page_address/__va/virt_to_page)
check ppc and m68k. ARM doesn't have highmem, so it's clearly not strict
in the address space since the first place (remeber, it's not an high
end cpu, it pays off big time in other areas), and it couldn't take
advantage in making the kernel virtual address space not a linear
mapping with the physical address space. Did you actually read Roman's
email of a few days ago that shows you __va is even just used as nonlinear?

> Are you talking about code that isn't in the tree?

first of all it doesn't matter if there wouldn't be a nonlinear __va in
ppc and m68k trees, if something can be done or not doesn't depend if
somebody did it before or not, but somebody just did it in practice too
in this case.

I've the feeling you reply too fast ignoring previous emails, so please
try to ask strict questions with non obvious stuff that you disagree
with on the past emails or you'll waste resources. If you ask stuff that
is just been discussed and that ignores the previous discussions
completly I will probably not have time to answer next times (like I've
no time for IRC for similar reasons), sorry.

Andrea
