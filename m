Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281181AbRLDRQF>; Tue, 4 Dec 2001 12:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRLDROc>; Tue, 4 Dec 2001 12:14:32 -0500
Received: from dsl-213-023-038-097.arcor-ip.net ([213.23.38.97]:1293 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S281391AbRLDROB>;
	Tue, 4 Dec 2001 12:14:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Linux/Pro  -- clusters
Date: Tue, 4 Dec 2001 18:16:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Donald Becker <becker@scyld.com>, Davide Libenzi <davidel@xmailserver.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10112032057070.978-100000@vaio.greennet> <E16BGhe-0000Pq-00@starship.berlin> <3C0CE97F.74AFFDBC@mandrakesoft.com>
In-Reply-To: <3C0CE97F.74AFFDBC@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16BJBR-0000RM-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 4, 2001 04:19 pm, Jeff Garzik wrote:
> Daniel Phillips wrote:
> > 
> > On December 4, 2001 03:09 am, Donald Becker wrote:
> > > To bring this branch back on point: we should distinguish between
> > > design for an arbitrary and unpredictable goal (e.g. 128 way SMP)
> > > vs. putting some design into things that we are supposed to already
> > > understan
> > >    [...]
> > >    a VFS layer that doesn't require the kernel to know a priori all of
> > >      the filesystem types that might be loaded
> > 
> > Right, there's a consensus that the fs includes have to fixed and that it
> > should be in 2.5.lownum.  The precise plan isn't fully evolved yet ;)
> > 
> > See fsdevel for the thread, 3-4 months ago.  IIRC, the favored idea (Linus's)
> > was to make the generic struct inode part of the fs-specific inode instead of
> > the other way around, which resolves the question of how the compiler
> > calculates the size/layout of an inode.
> > 
> > This is going to be a pervasive change that someone has to do all in one
> > day, so it remains to be seen when/if that is actually going to happen.
> > 
> > It's also going to break every out-of-tree filesystem.
> 
> ug.  what's wrong with a single additional alloc for generic_ip?  [if a
> filesystem needs to do multiple allocs post-conversion, somebody's doing
> something wrong]

Single additional alloc -> twice as many allocs, two slabs, more cachelines
dirty.  This was hashed out on fsdevel, though apparently not to everyone's
satisfaction.

> Using generic_ip in its current form has the advantage of being able to
> create a nicely-aligned kmem cache for your private inode data.

I don't see why that's hard with the combined struct.

--
Daniel
