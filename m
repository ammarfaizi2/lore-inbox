Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbREaAFD>; Wed, 30 May 2001 20:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262921AbREaAEx>; Wed, 30 May 2001 20:04:53 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:60118 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S262915AbREaAEs>; Wed, 30 May 2001 20:04:48 -0400
Message-ID: <3B158AAE.7233959D@idcomm.com>
Date: Wed, 30 May 2001 18:05:02 -0600
From: "D. Stimits" <stimits@idcomm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 Oops at boot
In-Reply-To: <578120000.991257754@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Wednesday, May 30, 2001 03:03:32 PM -0600 "D. Stimits"
> <stimits@idcomm.com> wrote:
> 
> [ snip ]
> 
> > RAMDISK: Compressed image found at block 0
> > Freeing initrd memory: 249k freed
> > VFS: Mounted root (ext2 filesystem).
> > Red Hat nash version 3.0.10 starting
> > VFS: Mounted root (ext2 filesystem) readonly.
> > change_root: old root has d_count=2
> > Trying to unmount old root ... <1>Unable to handle kernel NULL pointer
> > dereference at virtual address 00000010
> >  printing eip:
> 
> Can't say for sure without the oops decoded through ksymoops, but this
> looks like the oops in rd_ioctl fixed by 2.4.5-ac3 and higher.  I think the
> following patch (taken from ac3) will be sufficient:
> 
> -chris
> 
> --- linux.vanilla/fs/block_dev.c        Sat May 26 16:53:17 2001
> +++ linux.ac/fs/block_dev.c     Mon May 28 16:10:59 2001
> @@ -603,6 +602,7 @@
>         if (!bdev->bd_op->ioctl)
>                 return -EINVAL;
>         inode_fake.i_rdev=rdev;
> +       inode_fake.i_bdev=bdev;
>         init_waitqueue_head(&inode_fake.i_wait);
>         set_fs(KERNEL_DS);
>         res = bdev->bd_op->ioctl(&inode_fake, NULL, cmd, arg);

I'm just verifying that this one change was sufficient to allow booting
from a hard disk install. I'm still trying to figure out why "make
bzdisk" is failing, I will try the ac5 patch next.

Thanks,
D. Stimits, stimits@idcomm.com

PS: Is it possible to read a floppy image directly (for example, after
dd to a file), and tell if it is overrunning its maximum size limit? For
example, the partition records always end with 55 AA, is there something
I can look for to determine if a floppy image has gone too far?
