Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRDYSr3>; Wed, 25 Apr 2001 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRDYSrJ>; Wed, 25 Apr 2001 14:47:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6874 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131157AbRDYSrH>;
	Wed, 25 Apr 2001 14:47:07 -0400
Date: Wed, 25 Apr 2001 14:47:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <200104251839.MAA30241@lynx.turbolabs.com>
Message-ID: <Pine.GSO.4.21.0104251445380.10935-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Apr 2001, Andreas Dilger wrote:

> Al writes:
> > It's not a fscking rocket science - encapsulate accesses to ->u.foofs_i
> > into inlined function, find ->read_inode, find places that do get_empty_inode
> 
> OK, I was doing this for the ext3 port I'm working on for 2.4, and ran into
> a snag.  In the ext3_inode_info, there is a list_head.  However, if this is
> moved into a separate slab struct, it is now impossible to locate the inode
> from the offset in the slab struct.  When I was checking the size of each
> inode_info struct, I noticed several others that had list_heads in them.
> One solution is that we store list_heads in the inode proper, after generic_ip.

If you need to go from ext3_inode_info to inode - put the pointer into the
thing and be done with that. No need to bump ->i_count - fs-private
part dies before inode itself.

