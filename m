Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSFPEfT>; Sun, 16 Jun 2002 00:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSFPEfT>; Sun, 16 Jun 2002 00:35:19 -0400
Received: from merlin.webone.com.au ([210.8.44.18]:64782 "EHLO
	merlin.webone.com.au") by vger.kernel.org with ESMTP
	id <S315883AbSFPEfS>; Sun, 16 Jun 2002 00:35:18 -0400
Date: Sun, 16 Jun 2002 14:35:07 +1000
To: hugh@veritas.com
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
Message-ID: <20020616143507.A30647@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Kevin Easton <s3159795@student.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Jun 2002, Hugh Dickins wrote:
> On Sat, 15 Jun 2002, Russell King wrote:
> > On Sat, Jun 15, 2002 at 07:12:30PM +1000, Kevin Easton wrote:
> > > Hmm.. so how do such pages get marked dirty on architectures that don't
> > > do it in hardware ("most RISC architectures" according to a comment in
> > > memory.c)? Is the entire mapping made dirty when the write permissions
> > > are added?
> > 
> > No.  You only give user space write access when the write access _and_
> > "Linux dirty bit" are set.  This means you fault when user space tries
> > to write to the page, which means you can set the dirty bit.  This is
> > what the following code is doing (if write_access is required and the
> > pte already has write permission, then set the dirty bit):
> > 
> >         if (write_access) {
> >                 if (!pte_write(entry))
> >                         return do_wp_page(mm, vma, address, pte, pmd, entry);
> > 
> >                 entry = pte_mkdirty(entry);
> > }
> 
> Thanks, Russell.  Sorry, Kevin: I wasn't even thinking about
> non-i86 cases, add that to the list of disclaimers I put in.
> 
> Hugh

So... the difference on i386 is just the definitions of the protection_map
entries that are used.. specifically that PAGE_SHARED in asm-i386/pgtable.h
includes _PAGE_RW? Changing this definition to be the same as the PAGE_COPY
definition would be one fix?

	- Kevin.

