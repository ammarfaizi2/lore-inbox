Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbRGJNZ5>; Tue, 10 Jul 2001 09:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbRGJNZr>; Tue, 10 Jul 2001 09:25:47 -0400
Received: from weta.f00f.org ([203.167.249.89]:35970 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266295AbRGJNZc>;
	Tue, 10 Jul 2001 09:25:32 -0400
Date: Wed, 11 Jul 2001 01:25:24 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: msync() bug
Message-ID: <20010711012524.A31799@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010709170835.J1594@athlon.random>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc' list snipped)

This stuff is gold.

Anyone clueful want to comment things so this will end up in the
documentation when you do a make docbook or something?

Having access to simple facts like this is of so much value to those
of us who simply just don't have the time and/or exposure and many of
you (oh, and of course some of us just aren't as clever and need a
little more help!)




  --cw


On Mon, Jul 09, 2001 at 05:08:35PM +0200, Andrea Arcangeli wrote:

    On Tue, Jul 10, 2001 at 12:43:12AM +1000, Andrew Morton wrote:

    > If the physical address of the page is somewhere inside our
    > working RAM.
    
    correct.
    
    > > !PageReserved(page)
    > 
    > And it's not a reserved page (discontigmem?)
    
    yes, but it's not discontigmem issue, it is the other way around (page
    structure is valid but it maps to non ram, like the 640k-1M region that
    we have the page structure for, we don't use discontigmem for it because
    the hole is too smalle, but it is non ram, or also normal ram mapped by
    some device as dma region).
    
    > > ptep_test_and_clear_dirty(ptep))
    > 
    > And if it was modified via this mapping
    
    yes.
    
    > 
    > > +                       flush_tlb_page(vma, address);
    > > +                       set_page_dirty(page);
    > 
    > Question:  What happens if a program mmap's a part of /dev/mem
    > which passes all of these tests?   Couldn't it then pick some
    
    that cannot happen, remap_pte_range only maps invalid pages or reserved
    pages.
    
