Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135780AbRDTCNS>; Thu, 19 Apr 2001 22:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135781AbRDTCNI>; Thu, 19 Apr 2001 22:13:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6587 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135780AbRDTCMt>;
	Thu, 19 Apr 2001 22:12:49 -0400
Date: Thu, 19 Apr 2001 22:12:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: ext2 inode size (on-disk)
In-Reply-To: <200104191924.f3JJODWr015608@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0104192205500.19860-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Andreas Dilger wrote:

> Strange, I run "mke2fs -I 192 /dev/hdc2" and do not have a segfault or any
> problems with e2fsck or debugfs on the resulting filesystem.  I'm running
> 1.20-WIP, but I don't think anything was changed in this area for some time.
 
May depend on the libc version/size of device/phase of the moon. I've
got segfaults with 1.18, 1.19 and 1.20-WIP on a Debian box with glibc
2.1.3-18 and 20Mb image. What really happens is memory corruption in
libe2fs (ext2_write_inode()), segfault comes later (usually in free()).

> Basically, packing inodes across block boundaries is TOTALLY broken.
> This can lead to all sorts of data corruption issues if one block is
> written to disk, and the other is not.  For that matter, the same would

Yup.

> PS - is this a code cleanup issue, or do you have some reason that you want
>      to increase the inode size?

Code cleanup
								Al

