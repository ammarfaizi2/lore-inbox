Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314221AbSEBBqE>; Wed, 1 May 2002 21:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314225AbSEBBqD>; Wed, 1 May 2002 21:46:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9028 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314221AbSEBBqC>; Wed, 1 May 2002 21:46:02 -0400
Date: Thu, 2 May 2002 03:46:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Blanchard <anton@samba.org>, Russell King <rmk@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502034646.U11414@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme> <E172j1d-0001rS-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 03:35:20AM +0200, Daniel Phillips wrote:
> On Thursday 02 May 2002 02:20, Anton Blanchard wrote:
> > > so ia64 is one of those archs with a ram layout with huge holes in the
> > > middle of the ram of the nodes? I'd be curious to know what's the
> > > hardware advantage of designing the ram layout in such a way, compared
> > > to all other numa archs that I deal with. Also if you know other archs
> > > with huge holes in the middle of the ram of the nodes I'd be curious to
> > > know about them too. thanks for the interesting info!
> > 
> > From arch/ppc64/kernel/iSeries_setup.c:
> > 
> >  * The iSeries may have very large memories ( > 128 GB ) and a partition
> >  * may get memory in "chunks" that may be anywhere in the 2**52 real
> >  * address space.  The chunks are 256K in size.
> > 
> > Also check out CONFIG_MSCHUNKS code and see why I'd love to see a generic
> > solution to this problem.
> 
> Using the config_nonlinear model, you'd change the four mapping functions:
> 
> 	logical_to_phys
> 	phys_to_logical
> 	pagenum_to_phys
> 	phys_to_pagenum
> 
> to use a hash table instead of a table lookup.  Bill Irwin suggested a btree
> would work here as well.

btree? btree is not an interesting in core data structure. Anyways you
can use a btree with discontigmem too for the lookup. nonlinear will pay
off if you've something of the order of 256 discontigmem chunks with
significant holes in between like origin 2k, and I think it should be
resolved internally to the arch without exposing it to the common code.

> 
> (Note I'm trying out the term 'pagenum' instead of 'ordinal' here, following
> comments on lse-tech.)
> 
> -- 
> Daniel


Andrea
