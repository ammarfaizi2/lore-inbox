Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271887AbRIDEKD>; Tue, 4 Sep 2001 00:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271888AbRIDEJy>; Tue, 4 Sep 2001 00:09:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19697 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271887AbRIDEJj>;
	Tue, 4 Sep 2001 00:09:39 -0400
Date: Tue, 4 Sep 2001 00:09:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <Pine.LNX.4.31.0109040317500.16612-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.GSO.4.21.0109040001000.26423-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Jean-Marc Saffroy wrote:

> > Notice that setups along the lines "mount /dev/sda5 read-only on
> > /home/jail/pub and read-write on /home/ftp/pub" are not that
> > unreasonable, so even for local filesystems it might make sense.
> >
> > IOW, I suspect that right solution would have two separate layers -
> > 	* does anyone get write access under that mountpoint? (VFS)
> > 	* is this fs asked to handle write access and had it agreed with that?
> > (filesystem)
> 
> Then a mount point could be compared to the notion of view in a database,
> right ? Sounds nice.

Well, they _are_ views.  We have two distinct objects - superblock (fs
tree itself) and vfsmount (view into it).  Some of the flags obviously
belong to the latter (e.g. nosuid, nodev and noexec - in -ac they are
per-mountpoint and in effect you can turn them on and off on arbitrary
subtrees - e.g.
mount --bind /home/k1dd13 /home/k1dd13
mount -o remount,noexec /home/k1dd13
will have expected effect).

Read-only is more complex - in addition to mount side ("does anyone want
it to be r/w") there is a filesystem side ("does fs agree to be r/w")...

