Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290921AbSAaFF0>; Thu, 31 Jan 2002 00:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290927AbSAaFFQ>; Thu, 31 Jan 2002 00:05:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20442 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290921AbSAaFFG>;
	Thu, 31 Jan 2002 00:05:06 -0500
Date: Thu, 31 Jan 2002 00:05:05 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Kris Urquhart <kurquhart@littlefeet-inc.com>
cc: Andreas Dilger <adilger@turbolabs.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: ext2/mount - multiple mounts corrupts inodes
In-Reply-To: <B9F49C7F90DF6C4B82991BFA8E9D547B1256F7@BUFORD.littlefeet-inc.com>
Message-ID: <Pine.GSO.4.21.0201302359210.15689-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Jan 2002, Kris Urquhart wrote:

> + DEVICE=/dev/hda3
> + MOUNT=/mnt/hd
> + cat /proc/mounts
> + grep /mnt/hd
> + umount /mnt/hd
> umount: /mnt/hd: not mounted
[created fs on hda3]
> + rm -rf /mnt/hd
> + mkdir -p /mnt/hd
> + mount -t ext2 /dev/hda3 /mnt/hd
> + cat /proc/mounts
> + grep /mnt/hd
> /dev/hda3 /mnt/hd ext2 rw 0 0
> + cp -r /bin/tar /mnt/hd
> + cp -r /bin/zcat /mnt/hd
> + mount -t ext2 /dev/hda3 /mnt/hd
> mount: /dev/hda3 already mounted or /mnt/hd busy
> mount: according to mtab, /dev/hda3 is already mounted on /mnt/hd

Complains about mounting same fs on the same spot, refuses to mount.

> + grep /mnt/hd
> + cat /proc/mounts
> /dev/hda3 /mnt/hd ext2 rw 0 0
> + find /mnt/hd -ls
>      2    1 drwxr-xr-x   3 root     root         1024 Dec 31 15:17 /mnt/hd
>     11   12 drwxr-xr-x   2 root     root        12288 Dec 31 15:17
> /mnt/hd/lost+found
> find: /mnt/hd/tar: Input/output error
> find: /mnt/hd/zcat: Input/output error

WTF???  Very interesting...  What about kernel messages?  It looks like
stat(2) failing.

Just in case - could you put the same find before the second attempt of
mount?

