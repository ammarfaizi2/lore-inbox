Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSHBAHM>; Thu, 1 Aug 2002 20:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317819AbSHBAHM>; Thu, 1 Aug 2002 20:07:12 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:46998 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S317772AbSHBAHK>;
	Thu, 1 Aug 2002 20:07:10 -0400
Subject: Re: BIG files & file systems
From: Stephen Lord <lord@sgi.com>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Alexander Viro <viro@math.psu.edu>, "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020801035119.GA21769@ravel.coda.cs.cmu.edu>
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>
	<Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu> 
	<20020801035119.GA21769@ravel.coda.cs.cmu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 01 Aug 2002 19:09:37 -0500
Message-Id: <1028246981.11223.56.camel@snafu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 22:51, Jan Harkes wrote:
> On Wed, Jul 31, 2002 at 05:13:46PM -0400, Alexander Viro wrote:
> > On Wed, 31 Jul 2002, Jan Harkes wrote:
> > > On Wed, Jul 31, 2002 at 01:16:20PM -0600, Peter J. Braam wrote:
> > > > I've just been told that some "limitations" of the following kind will
> > > > remain:
> > > >   page index = unsigned long
> > > >   ino_t      = unsigned long
> > > 
> > > The number of files is not limited by ino_t, just look at the
> > > iget5_locked operation in fs/inode.c. It is possible to have your own
> > > n-bit file identifier, and simply provide your own comparison function.
> > > The ino_t then becomes the 'hash-bucket' in which the actual inode is
> > > looked up.
> > 
> > You _do_ need unique ->st_ino from stat(2), though - otherwise tar(1)
> > and friends will break in all sorts of amusing ways.  And there's
> > nothing kernel can do about that - applications expect 32bit st_ino
> > (compare them as 32bit values, etc.)
> 
> Which is why "tar and friends" are to different extents already broken
> on various filesystems like Coda, NFS, NTFS, ReiserFS, and probably XFS.
> (i.e. anything that currently uses iget5_locked instead of iget to grab
> the inode).

Why are they broken? In the case of XFS at least you still get a unique
and stable inode number back - and it fits in 32 bits too.

Steve


