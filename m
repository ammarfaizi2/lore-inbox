Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTFJU21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTFJU1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:27:17 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:238 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP id S262318AbTFJU0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:26:14 -0400
Date: Tue, 10 Jun 2003 21:39:51 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Rob Landley <rob@landley.net>
cc: Sean Hunter <sean@uncarved.com>, Shawn <core@enodev.com>,
       Matthias Schniedermeyer <ms@citd.de>,
       "Leonardo H. Machado" <leoh@dcc.ufmg.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cachefs on linux
In-Reply-To: <200306101515.53464.rob@landley.net>
Message-ID: <Pine.SOL.3.96.1030610213326.23899A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, Rob Landley wrote:
> On Tuesday 10 June 2003 04:29, Sean Hunter wrote:
> > On Mon, Jun 09, 2003 at 03:49:36PM -0500, Shawn wrote:
> > > Well, it's a nice way to simulate writing on r/o filesystems IIRC. Like
> > > mounting a cdrom then writing to it, but you're not.
> > >
> > > Was that was this was? Anyway, linux also does not have unionFS. If it
> > > was that big of a deal, someone would write it. As it is, it's a
> > > whizbang no one cares about enough.
> >
> > Its particularly handy for fast read-only NFS stuff.  We have thousands
> > of linux hosts and distributing software to all of them is a pain.  With
> > cachefs with NFS as the "back" filesystem, you push to the masters and
> > the clients get the changes over NFS and then store them in their local
> > cache so your software distribution nightmare becomes no problem at all.
> > Clients read off the local disk if they can, but fetch over NFS as
> > required.  You can tune the cache size on all of the client machines so
> > they can cache more or less of the most recently used NFS junk on its
> > local disk.
> >
> > Sean
> 
> Technically cachefs is just a union mount with tmpfs or ramfs as the overlay 
> on the underlying filesystem.  Doing a seperate cachefs is kind of pointless 
> in Linux.

That is not correct (unless there is something about tmpfs/ramfs that I
have missed).

cachefs is very powerfull because it caches to both ram AND to local disk
storage. Thus for example you can use cachefs to mount cdroms and then the
first time some blocks are read they will come from the cdrom disk and
subsequent reads of the same blocks will come out of the local hard drive
and/or the local ram which is of course a lot faster. And you can do the
same for nfs or any other slow and/or non-local file system in order to
implement a faster cache.

Also the cache is intelligent in that the LRU blocks are discarded when
the cache is full (or to be precise above a certain adjustable threshold)
and is replaced by data that is fetched from the slow/remote fs.

AFAIK union mounting with tmpfs/ramfs could never give you such caching
behaviour as cachefs on Solaris...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

