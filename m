Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130054AbRBZA0p>; Sun, 25 Feb 2001 19:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130055AbRBZA0g>; Sun, 25 Feb 2001 19:26:36 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46464 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130054AbRBZA02>;
	Sun, 25 Feb 2001 19:26:28 -0500
Date: Sun, 25 Feb 2001 19:26:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
cc: Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <20010226005103.V18271@almesberger.net>
Message-ID: <Pine.GSO.4.21.0102251910070.26808-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Feb 2001, Werner Almesberger wrote:

> Alexander Viro wrote:
> > No. Just an overmount.
> 
> Ah, too bad. Union mounts would have been really elegant (allowing the
> operation to be repeated without residues, and also allowing umounting
> of the covered FS as a sanity check). But I guess there's no way to
> implement them without performance penalty ...

There is no way to implement them without credentials' cache. Which needs
to be done for many other reasons, but that's a separate patch and
separate story. If it's done - no serious penalty involved. However,
I doubt that we want a union on / itself. /dev - sure, /bin and /lib -
maybe, but /... What for?
 
> > Is it worth emptying?
> 
> Probably not ... the only interesting case would be if you could completely
> umount it.

What's the point in unmounting it? Let the root of the mount tree be fixed -
it actually simplifies the things big way. Not that we had any performance
penalty for having the thing in place - after this forced chroot we never
touch it in lookups. BTW, pivot_root() is simpler that way.

BTW, we probably want to add mount --move <old> <new> - atomically moving
a subtree from one place to another. Code is there, we just need to
decide on API. Andries?

> So with some luck, distributors will switch to pivot_root sometime soon,
> when deploying 2.4. So if we drop all the old junk in 2.5, the amount of
> letter bombs should be small ;-)

Tomorrow I'll try to catch Erik and talk with him about that. I'm not sure
that I know anyone in Debian Install System Team (oh, boy... somebody sure
loved capital letters). And I've absolutely no idea who is doing that stuff
in other distributions...
							Cheers,
								Al

