Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130619AbRCWLpb>; Fri, 23 Mar 2001 06:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130618AbRCWLpU>; Fri, 23 Mar 2001 06:45:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15573 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130606AbRCWLpL>;
	Fri, 23 Mar 2001 06:45:11 -0500
Date: Fri, 23 Mar 2001 06:44:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Alexander Viro <aviro@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-fsdevel@webber.adilger.int,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-lvm] EXT2-fs panic (device lvm(58,0)):
In-Reply-To: <200103230548.f2N5mM407684@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0103230631540.8373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Mar 2001, Andreas Dilger wrote:

> If this is the case, then all of the other zero initializations can be
> removed as well.  I figured that if most of the fields needed to be
> zeroed, then ones _not_ being zeroed would lead to this problem.

	Other zero initializations in inode->u certainly can be
removed, but whether it's worth doing or not depends is a matter of
taste (recall the flamefest around Tigran's crusade against global
zero initializers several months ago ;-)
	The rule is that inode->u is zeroed before fs gets to see
the inode, be it in ->read_inode() or after get_empty_inode().
The rest is private business of that fs. That's what ->u is about,
after all...
						Cheers,
							Al

