Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285058AbRLKOBE>; Tue, 11 Dec 2001 09:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285056AbRLKOAz>; Tue, 11 Dec 2001 09:00:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17736 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284987AbRLKOAk>; Tue, 11 Dec 2001 09:00:40 -0500
Date: Tue, 11 Dec 2001 15:01:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011211150119.H4801@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva> <3C151F7B.44125B1@zip.com.au>, <3C151F7B.44125B1@zip.com.au>; <20011211011158.A4801@athlon.random> <3C15B0B3.1399043B@zip.com.au> <20011211144223.E4801@athlon.random> <20011211155922.B1863@crystal.2d3d.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011211155922.B1863@crystal.2d3d.co.za>; from abraham@2d3d.co.za on Tue, Dec 11, 2001 at 03:59:22PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 03:59:22PM +0200, Abraham vd Merwe wrote:
> Hi Andrea!
> 
> > > > > In my swapless testing, I burnt HUGE amounts of CPU in flush_tlb_others().
> > > > > So we're madly trying to swap pages out and finding that there's no swap
> > > > > space.  I beleive that when we find there's no swap left we should move
> > > > > the page onto the active list so we don't keep rescanning it pointlessly.
> > > > 
> > > > yes, however I think the swap-flood with no swap isn't a very
> > > > interesting case to optimize.
> > > 
> > > Running swapless is a valid configuration, and the kernel is doing
> > 
> > I'm not saying it's not valid or non interesting.
> > 
> > It's the mix "I'm running out of memory and I'm swapless" that is the
> > case not interesting to optimize.
> > 
> > If you're swapless it means you've enough memory and that you're not
> > running out of swap. Otherwise _you_ (not the kernel) are wrong not
> > having swap.
> 
> The problem is that your VM is unnecesarily eating up memory and then wants
> swap. That is unacceptable. Having 90% of your memory in buffers/cache and
> then the OOM killer kicks in because nothing is free is what we're moaning
> about.

Dear, Abraham please apply this patch:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17pre4aa1.bz2

on top of a 2.4.17pre4 and then recompile, try again and send me a
bugreport if you can reproduce. thanks,

Andrea
