Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315351AbSEBSoI>; Thu, 2 May 2002 14:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315350AbSEBSoH>; Thu, 2 May 2002 14:44:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:34132 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315338AbSEBSoD>; Thu, 2 May 2002 14:44:03 -0400
Date: Thu, 2 May 2002 20:44:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502204437.N11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <E173LGv-000277-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 08:25:35PM +0200, Daniel Phillips wrote:
> On Thursday 02 May 2002 18:40, Andrea Arcangeli wrote:
> > On Thu, May 02, 2002 at 09:10:00AM -0700, Martin J. Bligh wrote:
> > > > You can trivially map the phys mem between 1G and 1G+256M to be in a
> > > > direct mapping between 3G+256M and 3G+512M, then you can put such 256M
> > > > at offset 1G into the ZONE_NORMAL of node-id 1 with discontigmem too.
> > > > 
> > > > The constraints you have on the normal memory are only two:
> > > > 
> > > > 1) direct mapping
> > > > 2) DMA
> > > > 
> > > > so as far as the ram is capable of 32bit DMA with pci32 and it's mapped
> > > > in the direct mapping you can put it into the normal zone. There is no
> > > > difference at all between discontimem or nonlinear in this sense.
> > > 
> > > Now imagine an 8 node system, with 4Gb of memory in each node.
> > > First 4Gb is in node 0, second 4Gb is in node 1, etc.
> > > 
> > > Even with 64 bit DMA, the real problem is breaking the assumption
> > > that mem between 0 and 896Mb phys maps 1-1 onto kernel space.
> > > That's 90% of the difficulty of what Dan's doing anyway, as I
> > > see it.
> > 
> > You don't need any additional common code abstraction to make virtual
								  ^^^^^^^
> > address 3G+256G to point to physical address 1G as in my example above,
>           M ----^

indeed

> > after that you're free to put the physical ram between 1G and 1G+256M
> > into the zone normal of node 1 and the stuff should keep working but
> > with zone-normal spread in more than one node.
> 
> I don't see that you accomplished that at all, with config_discontig.
> How can you address the memory at 3G+256M?  That looks like highmem to

that's virtual memory, to access it you only need to dereference the
address. To get the page * you can simply use virt_to_page(3G+256M) and
it will return a page at phys address 1G+256M.

> me.  No good at all for kmem caches, buffers, struct pages, etc.

It is good for kmem buffers struct pages, pci32, it's ZONE_NORMAL memory.

> Without config_nonlinear, those structures will all have to be off-node
> for most nodes.
> 
> -- 
> Daniel


Andrea
