Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315562AbSECGFl>; Fri, 3 May 2002 02:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315564AbSECGFl>; Fri, 3 May 2002 02:05:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27680 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315562AbSECGFj>; Fri, 3 May 2002 02:05:39 -0400
Date: Fri, 3 May 2002 08:06:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503080620.S11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random> <E173M9Y-00027s-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 09:22:07PM +0200, Daniel Phillips wrote:
> On Thursday 02 May 2002 20:41, Andrea Arcangeli wrote:
> > On Thu, May 02, 2002 at 10:16:55AM -0700, William Lee Irwin III wrote:
> > > On Thu, May 02, 2002 at 09:10:00AM -0700, Martin J. Bligh wrote:
> > > >> Even with 64 bit DMA, the real problem is breaking the assumption
> > > >> that mem between 0 and 896Mb phys maps 1-1 onto kernel space.
> > > >> That's 90% of the difficulty of what Dan's doing anyway, as I
> > > >> see it.
> > > 
> > > On Thu, May 02, 2002 at 06:40:37PM +0200, Andrea Arcangeli wrote:
> > > > control on virt_to_page, pci_map_single, __va.  Actually it may be as
> > > > well cleaner to just let the arch define page_address() when
> > > > discontigmem is enabled (instead of hacking on top of __va), that's a
> > > > few liner. (the only true limit you have is on the phys ram above 4G,
> > > > that cannot definitely go into zone-normal regardless if it belongs to a
> > > > direct mapping or not because of pci32 API)
> > > > Andrea
> > > 
> > > Being unable to have any ZONE_NORMAL above 4GB allows no change at all.
> > 
> > No change if your first node maps the whole first 4G of physical address
> > space, but in such case nonlinear cannot help you in any way anyways.
> 
> You *still don't have a clue what config_nonlinear does*.
> 
> It doesn't matter if the first 4G of physical memory belongs to node zero.
> Config_nonlinear allows you to map only part of that to the kernel virtual
> space, and the rest would be mapped to highmem.  The next node will map part
> of its local memory (perhaps the next 4 gig of physical memory) to a different
> part of the kernel virtual space, and so on, so that in the end, all nodes
> have at least *some* zone_normal memory.

You are the one that has no clue of what I'm talking about. Go ahead, do
that and you'll see the corruption you get after the first vmalloc32 or
similar.

This has nothing to do with nonlinaer or anything discontigmem/numa.
This is all about the GFP kernel API with pci32.

> 
> Do you now see why config_nonlinear is needed in this case?  Are you
> willing to recognize the possibility that you might have missed some other
> cases where config_nonlinear is needed, and config_discontigmem won't do
> the job?
> 
> -- 
> Daniel


Andrea
