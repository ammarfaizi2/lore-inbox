Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314056AbSEFBlT>; Sun, 5 May 2002 21:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSEFBlS>; Sun, 5 May 2002 21:41:18 -0400
Received: from [195.223.140.120] ([195.223.140.120]:44842 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314056AbSEFBlR>; Sun, 5 May 2002 21:41:17 -0400
Date: Mon, 6 May 2002 03:42:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Russell King <rmk@arm.linux.org.uk>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020506034218.H6712@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174Wy4-0004C2-00@starship> <20020506032054.F6712@dualathlon.random> <E174XFK-0004CJ-00@starship>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2002 at 03:24:58AM +0200, Daniel Phillips wrote:
> On Monday 06 May 2002 03:20, Andrea Arcangeli wrote:
> > On Mon, May 06, 2002 at 03:07:07AM +0200, Daniel Phillips wrote:
> > > On Monday 06 May 2002 02:55, Russell King wrote:
> > > So, since __phys_to_virt (and hence phys_to_virt and __va) is clearly linear, the
> > > relation __pa(__va(kva)) == kva cannot hold.  Perhaps that doesn't bother you?
> > 
> > Check my previous email:
> > 
> > 	[..] They will all be normal zones provided you implement a static
> > 	view of them in the kernel virtual address space, and you also
> > 	cover page_address/virt_to_page [..]
> > 
> > Depending on the kind of coalescing of those chunks in the direct
> > mapping virt_to_page/page_address will vary. virt_to_page and
> > page_address will have all the necessary internal knowledge in order to
> > make it all zone_normal.
> 
> What do you mean by 'implement a static view of them'?

See the attached email. assuming chunks of 256M ram every 1G, 1G phys
goes at 3G+256M virt, 2G goes at 3G+512M etc...

Andrea

--ZGiS0Q5IWpPtfppv
Content-Type: message/rfc822
Content-Disposition: inline

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
In-Reply-To: <E172wFc-00024h-00@starship>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc

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

--ZGiS0Q5IWpPtfppv--
