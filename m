Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315574AbSECGiM>; Fri, 3 May 2002 02:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315575AbSECGiL>; Fri, 3 May 2002 02:38:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9508 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315574AbSECGiJ>; Fri, 3 May 2002 02:38:09 -0400
Date: Fri, 3 May 2002 08:38:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503083849.Y11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com> <148490000.1020378039@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 03:20:39PM -0700, Martin J. Bligh wrote:
> > On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> >> but can you plugin 32bit pci hardware into your 64bit-pci slots, right?
> >> If not, and if you're also sure the linux drivers for your hardware are all
> >> 64bit-pci capable then you can do the changes regardless of the 4G
> >> limit, in such case you can spread the direct mapping all over the whole
> >> 64G physical ram, whereever you want, no 4G constraint anymore.
> > 
> > I believe 64-bit PCI is pretty much taken to be a requirement; if it
> > weren't the 4GB limit would once again apply and we'd be in much
> > trouble, or we'd have to implement a different method of accommodating
> > limited device addressing capabilities and would be in trouble again.
> 
> IIRC, there are some funny games you can play with 32bit PCI DMA.
> You're not necessarily restricted to the bottom 4Gb of phys addr space, 
> you're restricted to a 4Gb window, which you can shift by programming 
> a register on the card. Fixing that register to point to a window for the 
> node in question allows you to allocate from a node's pg_data_t and 
> assure DMAable RAM is returned.

if you've as many windows as the number of nodes than you're just fine
in all cases.  you only need to teach pci_map_single and friends to
return the right bus address that won't be an identity anymore with the
phys addr, then you can forget the >4G phys constraint on the pages
returned by zone_normal :).

Andrea
