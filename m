Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRDWVUL>; Mon, 23 Apr 2001 17:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132121AbRDWVUB>; Mon, 23 Apr 2001 17:20:01 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:65244 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S132042AbRDWVTn>; Mon, 23 Apr 2001 17:19:43 -0400
Date: Mon, 23 Apr 2001 15:19:35 -0600
Message-Id: <200104232119.f3NLJZT24922@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Alexander Viro <viro@math.psu.edu>, Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <20010423224505.H719@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010423172335.G719@nightmaster.csn.tu-chemnitz.de>
	<Pine.GSO.4.21.0104231133120.3617-100000@weyl.math.psu.edu>
	<20010423224505.H719@nightmaster.csn.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser writes:
> On Mon, Apr 23, 2001 at 11:36:24AM -0400, Alexander Viro wrote:
> > > Great idea. We allocate this space anyway. And we don't have to
> > > care about the internals of this union, because never have to use
> > > it outside the kernel ;-)
> > > 
> > > I like it. ext2fs does the same, so there should be no VFS
> > > hassles involved. Al?
> > 
> > We should get ext2 and friends to move the sucker _out_ of struct inode.
> > As it is, sizeof(struct inode) is way too large. This is 2.5 stuff, but
> > it really has to be done. More filesystems adding stuff into the union
> > is a Bad Thing(tm). If you want to allocates space - allocate if yourself;
> > ->clear_inode() is the right place for freeing it.
> 
> You need an inode anyway. So why not using the space in it? tmpfs
> would only use sizeof(*inode.u)-sizeof(struct shmem_inode_info) for
> this kind of symlinks.
> 
> Last time we suggested this, people ended up with some OS trying
> it and getting worse performance. 
> 
> Why? You need to allocate the VFS-inode (vnode in other OSs) and
> the on-disk-inode anyway at the same time. You get better
> performance and less fragmentation, if you allocate them both
> together[1].

We want to take out that union because it sucks for virtual
filesystems. Besides, it's ugly.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
