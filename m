Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSFCXGM>; Mon, 3 Jun 2002 19:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315725AbSFCXGL>; Mon, 3 Jun 2002 19:06:11 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:57591 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315721AbSFCXGK>; Mon, 3 Jun 2002 19:06:10 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 3 Jun 2002 17:03:56 -0600
To: Ion Badulescu <ionut@cs.columbia.edu>,
        "Peter J. Braam" <braam@clusterfs.com>
Cc: Urban Widmark <urban@teststation.com>, linux-kernel@vger.kernel.org,
        Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Subject: Re: intent-based lookups (was Re: SMB filesystem)
Message-ID: <20020603230356.GG18668@turbolinux.com>
Mail-Followup-To: Ion Badulescu <ionut@cs.columbia.edu>,
	"Peter J. Braam" <braam@clusterfs.com>,
	Urban Widmark <urban@teststation.com>, linux-kernel@vger.kernel.org,
	Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
In-Reply-To: <Pine.LNX.4.44.0206022319290.27283-100000@cola.enlightnet.local> <200206032245.g53Mji123739@buggy.badula.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 03, 2002  18:45 -0400, Ion Badulescu wrote:
> On Sun, 2 Jun 2002 23:34:59 +0200 (CEST), Urban Widmark <urban@teststation.com> wrote:
> 
> > Currently autofs has a problem where it won't show the mountpoints of
> > non-mounted directories, but I think you would run into that problem too.
> > (short version of the problem: how do you prevent 'ls -l' from mounting
> > all filesystems in a directory?)
> 
> You add the concept of a "light" lookup, and you make path_walk() call this
> "light" lookup (be that a separate fs method, or a flag passed down to real
> lookup()) iff the path component being looked up is the last component in 
> the path. A "light" lookup sets a flag in the inode signalling that the inode
> is incomplete, so cached_lookup() can check this flag and call a "full"
> lookup() (or perhaps a "full" revalidate()) if necessary.
> 
> The actual details need to be thought out a bit more, this is only a general
> outline. In particular, we need a bullet-proof way to determine when to
> "upgrade" the inode from "light" to "full".

This may fit nicely with some work we are doing for Lustre (a scalable
distributed filesystem for Linux) which needs to do "intent-based
lookups".  It has a similar desire to separate the lookups of the start
of the path from the lookup of the last component of the path.  Peter
Braam (CC'd) has a patch for 2.4.18 which implements this.  I pass the
discussion over to him...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

