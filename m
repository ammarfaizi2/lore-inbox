Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317071AbSEXQWB>; Fri, 24 May 2002 12:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSEXQWA>; Fri, 24 May 2002 12:22:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23857 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317071AbSEXQV7>; Fri, 24 May 2002 12:21:59 -0400
Date: Fri, 24 May 2002 18:21:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: negative dentries wasting ram
Message-ID: <20020524162119.GA15703@dualathlon.random>
In-Reply-To: <20020524153624.GL21164@dualathlon.random> <Pine.GSO.4.21.0205241210210.9792-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 12:12:16PM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 24 May 2002, Andrea Arcangeli wrote:
> 
> > The fs access will be exactly the same, only the dentry won't be
> > allocated because it's just in the hash, but it has no inode and it
> > doesn't correspond to any on-disk dentry, we simply cannot defer the
> 
> RTFS.
> 
> Lookup on a name that has hashed negative dentry does not touch fs code.
> At all.

of course I was thinking mostly at the unlink procedure, I see the point
now in having the information that no dentry exists on disk with such
name.  that's an heuristic to optimize some common case but the unlink
and a create failure should definitely get rid of the negative dentry,
it's not a common case to delete a file and then to try to access it,
while there are common cases that wants to avoid stale dentries around
for deleted files.

Andrea
