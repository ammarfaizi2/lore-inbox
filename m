Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262742AbRE0EX0>; Sun, 27 May 2001 00:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262744AbRE0EXR>; Sun, 27 May 2001 00:23:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6319 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262742AbRE0EXE>;
	Sun, 27 May 2001 00:23:04 -0400
Date: Sun, 27 May 2001 00:22:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Rankin <rankinc@pacbell.net>
cc: linux-kernel@vger.kernel.org, reiser@namesys.com
Subject: Re: Linux-2.4.5, reiserfs, Oops!
In-Reply-To: <200105270414.f4R4Emk01883@twopit.underworld>
Message-ID: <Pine.GSO.4.21.0105270018390.1945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 May 2001, Chris Rankin wrote:

> Linux 2.4.5, SMP, devfs, < 1 GB memory, compiled with gcc-2.95.3
 
> drive. I didn't do anything clever with parameters or anything; just
> "mkreisferfs /dev/sda1", mounted it and then unmounted it again. And
> the kernel oopsed on me.

Bloody hell. 
--- fs/super.c       Fri May 25 21:51:14 2001
+++ fs/super.c.new     Sun May 27 00:21:53 2001
@@ -873,6 +873,7 @@
        }
        spin_unlock(&dcache_lock);
        down_write(&sb->s_umount);
+       lock_kernel();
        sb->s_root = NULL;
        /* Need to clean after the sucker */
        if (fs->fs_flags & FS_LITTER)
@@ -901,6 +902,7 @@
        put_filesystem(fs);
        sb->s_type = NULL;
        unlock_super(sb);
+       unlock_kernel();
        up_write(&sb->s_umount);
        if (bdev) {
                blkdev_put(bdev, BDEV_FS);


