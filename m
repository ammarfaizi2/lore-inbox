Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315356AbSEBS5B>; Thu, 2 May 2002 14:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315357AbSEBS5A>; Thu, 2 May 2002 14:57:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13144 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315356AbSEBS47>; Thu, 2 May 2002 14:56:59 -0400
Date: Thu, 2 May 2002 20:57:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502205741.O11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <143790000.1020367912@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 12:31:52PM -0700, Martin J. Bligh wrote:
> between physical to virtual memory to a non 1-1 mapping.

correct. The direct mapping is nothing magic, it's like a big static
kmap area.  Everybody is required to use
virt_to_page/page_address/pci_map_single/... to switch between virtual
address and mem_map anyways (thanks to the discontigous mem_map), so you
can use this property by making discontigous the virtual space as well,
not only the mem_map.  discontigmem basically just allows that.

> No, you don't need to call changing that mapping "CONFIG_NONLINEAR",
> but that's basically what the bulk of Dan's patch does, so I think we should 
> steal it with impunity ;-) 

The difference is that if you use discontigmem you don't clobber the
common code in any way, there is no "logical/ordinal" abstraction,
there is no special table, it's all hidden in the arch section, and the
pgdat you need them anyways to allocate from affine memory with numa.

Actually the same mmu technique can be used to coalesce in virtual
memory the discontigous chunks of iSeries, then you left the lookup in
the tree to resolve from mem_map to the right virtual address and from
the right virtual address back to mem_map. (and you left DISCONTIGMEM
disabled) I think it should be possible.

Andrea
