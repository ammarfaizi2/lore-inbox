Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSEXRAQ>; Fri, 24 May 2002 13:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSEXRAP>; Fri, 24 May 2002 13:00:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40098 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314512AbSEXRAO>;
	Fri, 24 May 2002 13:00:14 -0400
Date: Fri, 24 May 2002 13:00:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
In-Reply-To: <Pine.LNX.4.44.0205240927580.11495-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0205241259230.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Linus Torvalds wrote:

> 
> On Fri, 24 May 2002, Alexander Viro wrote:
> >
> > On Fri, 24 May 2002, Linus Torvalds wrote:
> >
> > > However, you're right that it probably doesn't help to do this after
> > > "unlink()" - it's probably only worth doing when actually doing a
> > > "lookup()" that fails.
> >
> > Depends on many things, including the amount of userland code that does
> > 	unlink(name);
> > 	open(name, O_CREAT|O_EXCL..., ...);
> 
> Note that this will have to touch the FS anyway, since the O_CREAT thing
> forces a call down to the FS to actually create the file.
 
> The only think we save is a dentry kfree/kmalloc in this case, nbot a FS
> downcall. And I think Andrea is right that it can waste memory for the
> likely much more common case where the file just stays removed.

???
It's lookup + unlink + lookup + create vs. lookup + unlink + create.

