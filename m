Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315565AbSECGUR>; Fri, 3 May 2002 02:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315566AbSECGUQ>; Fri, 3 May 2002 02:20:16 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15906 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315565AbSECGUQ>; Fri, 3 May 2002 02:20:16 -0400
Date: Fri, 3 May 2002 08:20:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503082057.U11414@dualathlon.random>
In-Reply-To: <20020502201043.L11414@dualathlon.random> <E173MG4-00024o-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 12:28:52PM -0700, Gerrit Huizenga wrote:
> In message <20020502201043.L11414@dualathlon.random>, > : Andrea Arcangeli writ
> es:
> > On Thu, May 02, 2002 at 09:58:02AM -0700, Gerrit Huizenga wrote:
> > > In message <3971861785.1020330424@[10.10.2.3]>, > : "Martin J. Bligh" writes:
> > > > > With numa-q there's a 512M hole in each node IIRC. that's fine
> > > > > configuration, similar to the wildfire btw.
> > > > 
> > > > There's 2 different memory models - the NT mode we use currently
> > > > is contiguous, the PTX mode is discontiguous. I don't think it's
> > > > as simple as a 512Mb fixed size hole, though I'd have to look it
> > > > up to be sure.
> > > 
> > > No - it definitely isn't as simple as a 512 MB hole.  Depends on how much
> > 
> > I meant that as an example, I recall that was valid config, 512M of ram
> > and 512M hole, then next node 512M ram and 512M hole etc... Of course it
> > must be possible to vary the mem size if you want more or less ram in
> > each node but still it doesn't generate a problematic layout for
> > discontigmem (i.e. not 256 discontigous chunks or something of that
> > order).
> 
> I *think* the ranges were typically aligned to 4 GB, although with 8 GB
> in a single node, I don't remember what the mapping layout looked like.
> 
> Which made everything but node 0 into HIGHMEM.

ok.

> 
> With the "flat" addressing mode that Martin has been using (the
> dummied down for NT version) everything is squished together.  That
> makes it a bit harder to do node local data structures, although he
> may have enough data from the MPS table to split memory appropriately.

sure, the only issue is the API that the hardware provides to advertise
the start/end of the memory for each node. It doesn't matter if it's
squashed or not as long as you still know the start/end of the phys ram
per node. It also won't make any difference with nonlinear or
discontigmem because you need to fill the pgdat anyways to enable the
numa heuristics (node-affine-allocations being the most sensible etc..).

Andrea
