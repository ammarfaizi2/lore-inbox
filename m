Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSHUD45>; Tue, 20 Aug 2002 23:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSHUD45>; Tue, 20 Aug 2002 23:56:57 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:6561 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317816AbSHUD45>; Tue, 20 Aug 2002 23:56:57 -0400
Date: Tue, 20 Aug 2002 22:01:00 -0600
Message-Id: <200208210401.g7L410F21464@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <Pine.LNX.4.44.0208201923470.28515-100000@serv>
References: <200208201700.g7KH0Qr10235@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0208201923470.28515-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> On Tue, 20 Aug 2002, Richard Gooch wrote:
> 
> > > So where again is the module count
> > > incremented?
> >
> > Which kernel tree are you looking at? I'm looking at 2.4.20-pre4.
> 
> Try 2.5.x.

Ah, that explains why we seemed to be talking past each other. For
2.4.x, def_blk_fops.open() will bump the reference count, but in 2.5.x
it won't. So in 2.5.x, fs/devfs/base.c:devfs_open() shouldn't drop the
refcount after def_blk_fops.open() returns.

> > > You never answered my question, why you insist on managing the ops
> > > pointer. The far easier fix would be to simply remove this nonsense.
> >
> > Because it's an optimsation, avoiding the need for looking up ops from
> > tables/lists. It's the sensible way of doing it. I've explained this
> > to others on the list, and in the FAQ. I'm not going to keep going
> > over it again and again.
> 
> Optimization??? This would require any device had to be be opened
> _only_ through devfs, you are not seriously suggesting that???

Huh? Of course not! All I'm saying is that if you use devfs, the
optimisation will short-circuit the lookups.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
