Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSGOShh>; Mon, 15 Jul 2002 14:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317586AbSGOShg>; Mon, 15 Jul 2002 14:37:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317582AbSGOShb> convert rfc822-to-8bit; Mon, 15 Jul 2002 14:37:31 -0400
Date: Mon, 15 Jul 2002 14:40:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: DervishD <raul@pleyades.net>
cc: mvolaski@aecom.yu.edu, linux-kernel@vger.kernel.org
Subject: Re: Mount corrupts an ext2 filesystem on a RAM disk
In-Reply-To: <3D3316D3.mail1J41H5VK0@viadomus.com>
Message-ID: <Pine.LNX.3.95.1020715143606.232A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, DervishD wrote:

>     Hi Maurice :)
> 
> >Also, later on I learned that one must "cd" into the mounted ramdisk
> >to cause the corruption.
> 
>     I've reproduced all your steps and my ramdisk didn't get
> corrupted. See below.
> 
> >I do the following to setup a ram disk on /dev/ram0...
> >dd if=/dev/zero of=/dev/ram0 bs=1k count=4096
> >mkfs.ext2 /dev/ram0 -m 0 -N 4096
> 
>     Identical commands issued...
> 
> >I mount it and already the lost+found directory is not there.
> 
>     Mine is OK. The lost+found is there. I don't suffer any of the
> other problems you tell, neither.
> 
>     Maybe you have bad ram chips, or a damaged mke2fs (unlikely), but
> the kernel seems to work OK. I've tested with 2.4.18 and 2.4.17.
> 
>     Raúl
> -

It also works okay here. Maybe, just maybe, you booted with initrd,
but did't unmount it before you started mucking with it `umount /initrd`
in the script below.



Script started on Mon Jul 15 13:08:16 2002
# cat xxx.xxx
umount /initrd 2>/dev/null
umount /mnt 2>/dev/null
dd if=/dev/zero of=/dev/ram0 bs=1k count=4096
mkfs.ext2 /dev/ram0 -m 0 -N 4096
fsck -f /dev/ram0
mount /dev/ram0 /mnt
ls /mnt
cat </dev/zero >/mnt/foo
ls -la /mnt
umount /mnt
fsck -f /dev/ram0

# sh xxx.xxx
4096+0 records in
4096+0 records out
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
4096 inodes, 4096 blocks
0 blocks (0.00%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
4096 inodes per group

Writing inode tables: 0/1done                            
Writing superblocks and filesystem accounting information: done
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/ram0: 11/4096 files (0.0% non-contiguous), 530/4096 blocks
lost+found
cat: write error: No space left on device
total 3580
drwxr-xr-x   3 root     root         1024 Jul 15 13:08 .
drwxr-xr-x  24 root     root         4096 Jul 15 04:09 ..
-rw-r--r--   1 root     root      3633152 Jul 15 13:08 foo
drwxr-xr-x   2 root     root        12288 Jul 15 13:08 lost+found
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/ram0: 12/4096 files (0.0% non-contiguous), 4093/4096 blocks
# exit
exit

Script done on Mon Jul 15 13:08:28 2002


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

