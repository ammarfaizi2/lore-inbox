Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287337AbSAPTaG>; Wed, 16 Jan 2002 14:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287155AbSAPT3q>; Wed, 16 Jan 2002 14:29:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15909 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287205AbSAPT3o>; Wed, 16 Jan 2002 14:29:44 -0500
Date: Wed, 16 Jan 2002 20:30:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pte-highmem-5
Message-ID: <20020116203022.A3113@athlon.random>
In-Reply-To: <20020116194816.D835@athlon.random> <Pine.LNX.4.33.0201161109020.2261-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0201161109020.2261-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 16, 2002 at 11:11:48AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 11:11:48AM -0800, Linus Torvalds wrote:
> 
> On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> >
> > >  - do the highmem pte bouncing only for CONFIG_X86_PAE: with less then 4GB
> > >    of RAM this doesn't seem to matter all that much (rule of thumb: we
> > >    need about 1% of memory for page tables). Again, this will simplify
> > >    things, as it will make other architectures not have to worry about the
> > >    change.
> >
> > I'm not sure how simpler it will make things and I'd prefer to keep the
> > pte in highmem also with 4G to be more generic
> 
> I agree that this will not make things simpler, it will just streamline
> and speed up some of the VM paths for people who just don't need it.

speedwise of such code path indeed but see below.

> A lot of HIGHMEM users have just 1GB and use HIGHMEM to get at the last
> few megs, so..

I don't see a big difference with the pages. if pagetables won't go into
highmem it will be pages that will go there. Infact with the pagetables
may be much better than with the pages. I mean it may be much better to
have the few megs filled with pagetables rather than with pages that we
may have to read(2)/write(2) all the time. We may end generating a
bigger kmap overhead if we put pages in there (of course it also depends
on the workload). It's not really obvious to me that 4G is an
improvement compared to 4G+pte-kmap on a 1G box. So I'm still not
convinced that the below differentiation of configuration options is
worthwhile.  comments?

> It might make sense to make it an independent config option, and possibly
> just split up the highmem question a bit more (ie make the choices be
> something like "none", "4G", "4G+pte-kmap" or "64G(with pte-kmap)").

Andrea
