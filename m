Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281851AbRKRELB>; Sat, 17 Nov 2001 23:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281852AbRKREKu>; Sat, 17 Nov 2001 23:10:50 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:62578 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281851AbRKREKe>; Sat, 17 Nov 2001 23:10:34 -0500
Date: Sun, 18 Nov 2001 05:10:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: ehrhardt@mathematik.uni-ulm.de, linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
Message-ID: <20011118051023.A25232@athlon.random>
In-Reply-To: <20011116142344.A7316@netnation.com> <20011117225327.5368.qmail@thales.mathematik.uni-ulm.de> <200111180312.fAI3CpG01076@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200111180312.fAI3CpG01076@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 17, 2001 at 07:12:51PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 07:12:51PM -0800, Linus Torvalds wrote:
> In article <20011117225327.5368.qmail@thales.mathematik.uni-ulm.de> you write:
> >
> >I think this one liner (diffed against 2.4.14) could fix this Oops:
> 
> It really shouldn't matter - at that point we have the page locked, and

I also agree the patch shouldn't matter, but one suspect thing is the
fact add_to_swap_cache goes to clobber in a non atomic manner the page
lock. so yes, we hold the page lock both in swap_out and in
shrink_cache, but swap_out can drop it for a moment and then later
pretend to be the onwer again without a real trylock.

Andrea
