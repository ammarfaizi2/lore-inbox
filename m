Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSDVTDw>; Mon, 22 Apr 2002 15:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314456AbSDVTDv>; Mon, 22 Apr 2002 15:03:51 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:63454 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id <S314452AbSDVTDq>;
	Mon, 22 Apr 2002 15:03:46 -0400
Message-ID: <3CC45E8D.68566324@isg.de>
Date: Mon, 22 Apr 2002 21:03:41 +0200
From: Peter Niemayer <niemayer@isg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, jari.ruusu@pp.inet.fi
Subject: mounting loop-device on a 2048 byte/sector medium fails
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first I thought this was some loop-AES specific issue, but now I know
it isn't: When I try to mount a filesystem on a loop device which
is in turn using a 2048 byte/sector medium (a magneto-optical drive
in my case), the mount fails though mkfs & fsck are happy.

The following script (tests done with kernel 2.4.18):

----------------------------------------------------------------------
#!/bin/sh

echo -n "blockdev /dev/sdb result: "
blockdev --getbsz /dev/sdb

losetup /dev/loop0 /dev/sdb

echo
echo -n "blockdev /dev/loop0 result: "
blockdev --getbsz /dev/loop0

echo
echo "mkfs output:"
mkfs -t ext2 /dev/loop0

echo
echo "fsck output:"
fsck.ext2 -f /dev/loop0

echo
echo "mount output:"

mount -t ext2 /dev/loop0 /mnt/floppy
------------------------------------------------------------------------

works just fine when the medium inserted into the MO-drive is a 512 byte/sector
medium, but when I put a 2048 byte/sector medium in the drive, this is the
resulting output:

------------------------------------------------------------------------
blockdev /dev/sdb result: 2048

blockdev /dev/loop0 result: 2048

mkfs output:
mke2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
77600 inodes, 155176 blocks
7758 blocks (5.00%) reserved for the super user
First data block=0
5 block groups
32768 blocks per group, 32768 fragments per group
15520 inodes per group
Superblock backups stored on blocks: 
        32768, 98304

Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 31 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.

fsck output:
e2fsck 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/loop0: 11/77600 files (0.0% non-contiguous), 2446/155176 blocks

mount output:
mount: wrong fs type, bad option, bad superblock on /dev/loop0,
       or too many mounted file systems
------------------------------------------------------------------------

Any idea?


Regards,

Peter Niemayer
