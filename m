Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314216AbSEBBme>; Wed, 1 May 2002 21:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314221AbSEBBmd>; Wed, 1 May 2002 21:42:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7747 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314216AbSEBBmc>; Wed, 1 May 2002 21:42:32 -0400
Date: Thu, 2 May 2002 03:43:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502034318.T11414@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172gnj-0001pS-00@starship> <20020502024740.P11414@dualathlon.random> <E172isy-0001rL-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 03:26:22AM +0200, Daniel Phillips wrote:
> On Thursday 02 May 2002 02:47, Andrea Arcangeli wrote:
> > >   - Leads forward to interesting possibilities such as hot plug memory.
> > >     (Because pinned kernel memory can be remapped to an alternative
> > >     region of physical memory if desired)
> > 
> > You cannot handle hot plug with nonlinear, you cannot take the mem_map
> > contigous when somebody plugins new memory, you've to allocate the
> > mem_map in the new node, discontigmem allows that, nonlinear doesn't.
> 
> You have not read and understood the patch, which this comment demonstrates.
> 
> For your information, the mem_map lives in *virtual* memory, it does not
> need to change location, only the kernel page tables need to be updated,
> to allow a section of kernel memory to be moved to a different physical
> location.  For user memory, this was always possible, now it is possible
> for kernel memory as well.  Naturally, it's not all you have to do to get
> hotplug memory, but it's a big step in that direction.

what kernel pagetables? pagetables for space that you left free for
what? You waste virtual space for that at the very least on x86 that is
just very tigh, at this point kernel virtual space is more costly than
physical space these days. And nevertheless most archs doesn't have
pagetables at all to read and write the page structures. yes it's
virtual memory but it's a direct mapping. DaveM even rewrote the palcode
of sparc to skip the pagetable walking for kernel direct mapping. alpha
mips have a kseg that maps to physical addresses directly. there are
_no_ pagetables for the mem_map in most archs, the palcode resolves it
directly without using the tlb. So if you move mem_map to pagetables
like modules to handle hotplug you just made automatically the whole
kernel slower due the additional pte walking and tlb trashing.

> > At the very least you should waste some tons of memory of unused mem_map
> > for all the potential memory that you're going to plugin, if you want to
> > handle hot-plug with nonlinear.
> 
> Eh.  No.
> 
> It's not useful for me to keep correcting you on your misunderstanding of
> what config_nonlinear actually does.  Please read Jonathan Corbet's
> excellent writeup in lwn, it's written in a very understandable fashion.
> 
> -- 
> Daniel


Andrea
