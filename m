Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314275AbSEXQkW>; Fri, 24 May 2002 12:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSEXQkV>; Fri, 24 May 2002 12:40:21 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23347 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314275AbSEXQkU>; Fri, 24 May 2002 12:40:20 -0400
Date: Fri, 24 May 2002 18:39:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
Message-ID: <20020524163942.GB15703@dualathlon.random>
In-Reply-To: <Pine.GSO.4.21.0205241215340.9792-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0205240927580.11495-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 09:29:56AM -0700, Linus Torvalds wrote:
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

yep. the only case where it could provide some in-core "caching"
positive effect is:

	unlink
	open(w/o creat)

but I don't see it as a common case.

> The only think we save is a dentry kfree/kmalloc in this case, nbot a FS

agreed.

Andrea
