Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264837AbRGITqJ>; Mon, 9 Jul 2001 15:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbRGITp5>; Mon, 9 Jul 2001 15:45:57 -0400
Received: from ECE.CMU.EDU ([128.2.236.200]:55759 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S264837AbRGITpn>;
	Mon, 9 Jul 2001 15:45:43 -0400
Date: Mon, 9 Jul 2001 15:45:36 -0400 (EDT)
From: Craig Soules <soules@happyplace.pdl.cmu.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: jrs@world.std.com, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <15177.65286.592796.329570@charged.uio.no>
Message-ID: <Pine.LNX.3.96L.1010709153516.16113R-100000@happyplace.pdl.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Trond Myklebust wrote:
> The NFSv2 spec says no such thing. It simply says that you set the
> cookie to zero when you want to start at the beginning of the
> directory. This is only needed when we want to reread the directory
> into the page cache.

Ok, perhaps I mis-spoke slightly.  What the spec does state is that the
cookie is opaque.  This has generally been interpreted to mean that you
should not trust it to be stable after a change to that directory.

> Your patch will automatically lead to duplicate entries in readdir()
> on most if not all servers whenever the attributes on the inode have
> been refreshed (whether or not the cache has been invalidated). That's
> a bug...

If I were to do a create during a readdir() operation which inserted
itself in the directory before the place it left off, that entry would be
left out of the listing.  That is also a bug, wouldn't you think?

I'd also like to point out that every other operating system which I have
tested this with has resulted in the correct behavior (NetBSD, FreeBSD,
Digital Unix, ...)

As for the refresh vs. invalidate problem, I would be happy to add
another time stamp to the in-core nfs inode exclusively for directory
invalidation.

Craig

