Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129268AbRBXEE1>; Fri, 23 Feb 2001 23:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbRBXEER>; Fri, 23 Feb 2001 23:04:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11584 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129268AbRBXEEM>; Fri, 23 Feb 2001 23:04:12 -0500
Date: Sat, 24 Feb 2001 05:04:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15
Message-ID: <20010224050402.A32367@athlon.random>
In-Reply-To: <20010223214057.A22808@athlon.random> <Pine.LNX.4.10.10102231306140.21515-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10102231306140.21515-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Feb 23, 2001 at 01:09:02PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 01:09:02PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 23 Feb 2001, Andrea Arcangeli wrote:
> > 
> > I think that can't happen. Infact I think the whole section:
> > 
> > 		pmd = pmd_offset(pgd, address);
> > 		pmd_k = pmd_offset(pgd_k, address);
> > 
> > 		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
> > 			goto bad_area_nosemaphore;
> > 		set_pmd(pmd, *pmd_k);
> > 		return;
> > 
> > is superflows.
> 
> No. Think about the differences in PAE and non-PAE mode. 
> 
> > The middle pagetable is shared and the pmd_t entry is set by vmalloc itself (it
> > just points to the as well shared pte), it's only the pgd that is setup lazily
> 
> In non-PAE mode, the pgd entry doesn't exist. pgd_present() returns a
> unconditional 1. Its' the pmd functions that kick in then.

Woops, I see, I was thinking only PAE mode indeed 8), sorry. Thanks for the
correction.

All the rest still applies (and the patch still looks fine for PAE mode). I
think I only need to rediff my patch after resurrecting the pmd thing inside
the cli critical section in a #ifndef CONFIG_X86_PAE region.

Andrea
