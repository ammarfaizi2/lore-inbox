Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288308AbSBIXhd>; Sat, 9 Feb 2002 18:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288342AbSBIXhY>; Sat, 9 Feb 2002 18:37:24 -0500
Received: from [63.231.122.81] ([63.231.122.81]:54887 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S288308AbSBIXhU>;
	Sat, 9 Feb 2002 18:37:20 -0500
Date: Sat, 9 Feb 2002 16:36:03 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Larry McVoy <lm@work.bitmover.com>, David Lang <dlang@diginsite.com>,
        Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
        Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020209163603.B9826@lynx.turbolabs.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Lang <dlang@diginsite.com>, Larry McVoy <lm@bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020209090527.B13735@work.bitmover.com> <Pine.LNX.4.44.0202091258110.25220-100000@dlang.diginsite.com> <20020209134132.J13735@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020209134132.J13735@work.bitmover.com>; from lm@bitmover.com on Sat, Feb 09, 2002 at 01:41:32PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 09, 2002  13:41 -0800, Larry McVoy wrote:
> We don't, but we can, and we should.  "bk relink tree1 tree2" seems like 
> the right interface.

Yes, this would be great.  It should probably only do this for files in
SCCS and BitKeeper directories, because vim (for example) will do the
wrong thing with hard-linked files if you edit them.  Maybe there could
be another option which would relink all of the checked-out files as well,
for people who use emacs?

> Right now we aren't too worried about the disk space, the data is sitting 
> on a pair of 40GB drives and we're running the trees in gzip mode, so they
> are 75MB each.  But yes, it's a good idea, we should do it, and probably
> should figure out some way to make it automatic.  I'll add it to the
> (ever growing) list, thanks.

One thing that I've noticed (got my first linux-2.5 clone last night) is
that the kernel build process is somewhat broken by the fact that not
everything that you need to build is checked out of the repository by
make.

It appears to handle .c files ok, but it failed for all of the .h files.
I take it this means that gcc doesn't know anything about SCCS, and it
would also appear that make is not properly checking dependencies for
these files, or it would have checked them out, right?

Also, things like "make menuconfig" and such also fail (because they are
doing stuff within scripts that have no concept of SCCS or BK).  Will
the new kernel build system take any of this into account?

I would prefer if we only checked out as much as we need (instead of
doing something like 'bk -r edit' which will use up a lot of space in
each clone for architectures and drivers which I don't need).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

