Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315227AbSEBS1C>; Thu, 2 May 2002 14:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315233AbSEBS1B>; Thu, 2 May 2002 14:27:01 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:18336 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315227AbSEBS07>;
	Thu, 2 May 2002 14:26:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Thu, 2 May 2002 20:25:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173LGv-000277-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 18:40, Andrea Arcangeli wrote:
> On Thu, May 02, 2002 at 09:10:00AM -0700, Martin J. Bligh wrote:
> > > You can trivially map the phys mem between 1G and 1G+256M to be in a
> > > direct mapping between 3G+256M and 3G+512M, then you can put such 256M
> > > at offset 1G into the ZONE_NORMAL of node-id 1 with discontigmem too.
> > > 
> > > The constraints you have on the normal memory are only two:
> > > 
> > > 1) direct mapping
> > > 2) DMA
> > > 
> > > so as far as the ram is capable of 32bit DMA with pci32 and it's mapped
> > > in the direct mapping you can put it into the normal zone. There is no
> > > difference at all between discontimem or nonlinear in this sense.
> > 
> > Now imagine an 8 node system, with 4Gb of memory in each node.
> > First 4Gb is in node 0, second 4Gb is in node 1, etc.
> > 
> > Even with 64 bit DMA, the real problem is breaking the assumption
> > that mem between 0 and 896Mb phys maps 1-1 onto kernel space.
> > That's 90% of the difficulty of what Dan's doing anyway, as I
> > see it.
> 
> You don't need any additional common code abstraction to make virtual
> address 3G+256G to point to physical address 1G as in my example above,
          M ----^
> after that you're free to put the physical ram between 1G and 1G+256M
> into the zone normal of node 1 and the stuff should keep working but
> with zone-normal spread in more than one node.

I don't see that you accomplished that at all, with config_discontig.
How can you address the memory at 3G+256M?  That looks like highmem to
me.  No good at all for kmem caches, buffers, struct pages, etc.
Without config_nonlinear, those structures will all have to be off-node
for most nodes.

-- 
Daniel
