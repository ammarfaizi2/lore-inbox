Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287279AbSAPTMq>; Wed, 16 Jan 2002 14:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287287AbSAPTMj>; Wed, 16 Jan 2002 14:12:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287289AbSAPTMX>; Wed, 16 Jan 2002 14:12:23 -0500
Date: Wed, 16 Jan 2002 11:11:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pte-highmem-5
In-Reply-To: <20020116194816.D835@athlon.random>
Message-ID: <Pine.LNX.4.33.0201161109020.2261-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
>
> >  - do the highmem pte bouncing only for CONFIG_X86_PAE: with less then 4GB
> >    of RAM this doesn't seem to matter all that much (rule of thumb: we
> >    need about 1% of memory for page tables). Again, this will simplify
> >    things, as it will make other architectures not have to worry about the
> >    change.
>
> I'm not sure how simpler it will make things and I'd prefer to keep the
> pte in highmem also with 4G to be more generic

I agree that this will not make things simpler, it will just streamline
and speed up some of the VM paths for people who just don't need it.

A lot of HIGHMEM users have just 1GB and use HIGHMEM to get at the last
few megs, so..

It might make sense to make it an independent config option, and possibly
just split up the highmem question a bit more (ie make the choices be
something like "none", "4G", "4G+pte-kmap" or "64G(with pte-kmap)").

		Linus

