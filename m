Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbREWWGP>; Wed, 23 May 2001 18:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263286AbREWWGG>; Wed, 23 May 2001 18:06:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44003 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263285AbREWWFy>;
	Wed, 23 May 2001 18:05:54 -0400
Date: Wed, 23 May 2001 18:05:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Maciek Nowacki <maciek@Voyager.powersurfr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
In-Reply-To: <20010523154843.A32583@Voyager.powersurfr.com>
Message-ID: <Pine.GSO.4.21.0105231753270.20269-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001, Maciek Nowacki wrote:

> May 22 09:14:31 wintermute kernel: RAMDISK: romfs filesystem found at block 0
> May 22 09:14:31 wintermute kernel: RAMDISK: Loading 28216 blocks [1 disk] into ram disk... done.
> May 22 09:14:31 wintermute kernel: Freeing initrd memory: 28216k freed
> May 22 09:14:31 wintermute kernel: VFS: Mounted root (romfs filesystem) readonly.
> May 22 09:14:31 wintermute kernel: Mounted devfs on /dev
> May 22 09:14:31 wintermute kernel: VFS: Mounted root (romfs filesystem) readonly.
> May 22 09:14:31 wintermute kernel: change_root: old root has d_count=7
> May 22 09:14:31 wintermute kernel: Mounted devfs on /dev
> May 22 09:14:31 wintermute kernel: Trying to unmount old root ... okay

At that point /dev/ram0 _is_ killed.

> Perhaps they're bumping up the reference count so that it is impossible to
> free the ramdisk later?

If you want to keep it until later (i.e. want to destiry it by hands)
mkdir /initrd on your final root and old one will be remounted there.
Again, "Trying to unmount old root ... okay" means that it already got
an equivalent of BKLFLSBUF

I wonder why does it get -EBUSY if you repeat it... Uh-oh...

Folks, who the hell is responsible for rd_inodes[] idiocy?

