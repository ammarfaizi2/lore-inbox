Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281289AbRKMAct>; Mon, 12 Nov 2001 19:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281288AbRKMAcj>; Mon, 12 Nov 2001 19:32:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50905 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281277AbRKMAcb>;
	Mon, 12 Nov 2001 19:32:31 -0500
Date: Mon, 12 Nov 2001 19:32:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Gruenbacher <ag@bestbits.at>
cc: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at>
Message-ID: <Pine.GSO.4.21.0111121207530.21825-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Nov 2001, Andreas Gruenbacher wrote:

> There are curently two paths by which the extended attribute inode
> operations can be invoked: (a) from a system call, (b) from the
> permission() inode operation, when checking the access ACL of a file. We
> could trivially use a dentry in (a), but unfortunately we don't have a
> choice in (b), as permission() itself is not passed a dentry.

Which means that converting permission() to vfsmount/dentry should be
done first.  And that's not hard to do.

> > Rule of the tumb: if your function got a "cmd" argument - it's broken.
> > ioctl(2).  fcntl(2).  prctl(2).  quotactl(2).  sysfs(2).  Missed'em'V IPC
> > syscalls.  Enough, already.
> 
> There is one difference between the interfaces you are complaining about
> above and the proposed EA interface for EA's: In those interfaces you have
> wildcard parameters that are used for who-knows-what, depending on a
> command-like parameter, including use as a value, use as a pointer to a
> value/struct, etc.

Yes, and?  You've got more than enough material for the same kind of
abuse.  What's more, you _already_ have it - in some of the subfunctions
*data is read from, in some - written to, in some - ignored.  Worse
yet, in some subfunctions we put structured data in there, in some -
just a chunk of something.

With all that, who had said that a year down the road we won't get a
dozen of new syscalls hiding behind that one?

Sorry, folks, but idea of private extendable syscall table (per-filesystem,
no less) doesn't look like a good thing.  That's _the_ reason why ioctl()
is bad.

