Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSEBTJN>; Thu, 2 May 2002 15:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315364AbSEBTJM>; Thu, 2 May 2002 15:09:12 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:673 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315358AbSEBTJM>;
	Thu, 2 May 2002 15:09:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Thu, 2 May 2002 21:08:18 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <143790000.1020367912@flay> <20020502205741.O11414@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173LwB-00027n-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 20:57, Andrea Arcangeli wrote:
> On Thu, May 02, 2002 at 12:31:52PM -0700, Martin J. Bligh wrote:
> > between physical to virtual memory to a non 1-1 mapping.
> 
> correct. The direct mapping is nothing magic, it's like a big static
> kmap area.  Everybody is required to use
> virt_to_page/page_address/pci_map_single/... to switch between virtual
> address and mem_map anyways (thanks to the discontigous mem_map), so you
> can use this property by making discontigous the virtual space as well,
> not only the mem_map.  discontigmem basically just allows that.

And what if you don't have enough virtual space to fit all the memory you
need, plus the holes?  Config_nonlinear handles that, config_discontig
doesn't.

> > No, you don't need to call changing that mapping "CONFIG_NONLINEAR",
> > but that's basically what the bulk of Dan's patch does, so I think we should 
> > steal it with impunity ;-) 
> 
> The difference is that if you use discontigmem you don't clobber the
> common code in any way,

First that's wrong.  Look at _alloc_pages and tell me that config_discontig
doesn't impact the common code (in fact, it adds two extra subroutine
calls, including two loops, to every alloc_pages call).

Secondly, config_nonlinear does not clobber the common code.  If it does,
please show me where.

When config_nonlinear is not enabled, suitable stubs are provided to make it
transparent.

> Actually the same mmu technique can be used to coalesce in virtual
> memory the discontigous chunks of iSeries, then you left the lookup in
> the tree to resolve from mem_map to the right virtual address and from
> the right virtual address back to mem_map. (and you left DISCONTIGMEM
> disabled) I think it should be possible.

So you're proposing a new patch?  Have you chosen a name for it?  How
about 'config_nonlinear'? ;-)

-- 
Daniel
