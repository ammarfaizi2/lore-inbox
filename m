Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314597AbSEBQFz>; Thu, 2 May 2002 12:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314603AbSEBQFy>; Thu, 2 May 2002 12:05:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23618 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314597AbSEBQFx>; Thu, 2 May 2002 12:05:53 -0400
Date: Thu, 2 May 2002 18:06:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502180632.I11414@dualathlon.random>
In-Reply-To: <20020502153402.A11414@dualathlon.random> <3968942217.1020327505@[10.10.2.3]> <20020502173522.F11414@dualathlon.random> <E172wFc-00024h-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 05:42:40PM +0200, Daniel Phillips wrote:
> On Thursday 02 May 2002 17:35, Andrea Arcangeli wrote:
> > On Thu, May 02, 2002 at 08:18:33AM -0700, Martin J. Bligh wrote:
> > > At the moment I use the contig memory model (so we only use discontig for
> > > NUMA support) but I may need to change that in the future.
> > 
> > I wasn't thinking at numa-q, but regardless numa-Q fits perfectly into
> > the current discontigmem-numa model too as far I can see.
> 
> No it doesn't.  The config_discontigmem model forces all zone_normal memory
> to be on node zero, so all the remaining nodes can only have highmem locally.

You can trivially map the phys mem between 1G and 1G+256M to be in a
direct mapping between 3G+256M and 3G+512M, then you can put such 256M
at offset 1G into the ZONE_NORMAL of node-id 1 with discontigmem too.

The constraints you have on the normal memory are only two:

1) direct mapping
2) DMA

so as far as the ram is capable of 32bit DMA with pci32 and it's mapped
in the direct mapping you can put it into the normal zone. There is no
difference at all between discontimem or nonlinear in this sense.

> Even with good cache hardware, this has to hurt.

Andrea
