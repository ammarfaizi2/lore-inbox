Return-Path: <linux-kernel-owner+w=401wt.eu-S1750842AbXAPOUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbXAPOUK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 09:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbXAPOUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 09:20:10 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:9543 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750842AbXAPOUI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 09:20:08 -0500
Date: Tue, 16 Jan 2007 14:19:59 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Turbo Fredriksson <turbo@bayour.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird harddisk behaviour
Message-ID: <20070116141959.GC476@deepthought>
References: <87bqkzp0et.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87bqkzp0et.fsf@pumba.bayour.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 02:27:06PM +0100, Turbo Fredriksson wrote:
> A couple of weeks ago my 400Gb SATA disk crashed. I just
> got the replacement, but I can't seem to be able to create
> a filesystem on it!
> 
> This is a PPC (Pegasos), running 2.6.15-27-powerpc (Ubuntu Dapper v2.6.15-27.50).
Hi Turbo,

 I think you have mac partitions (the first item is the partition
map itself - very different from the dos partitions common on x86).

 Certainly, fdisk from util-linux doesn't know about mac disks, and
I thought the same was true for cfdisk and sfdisk.  Many years ago
there was mac-fdisk, I think also known as pdisk, but nowadays the
common tool for partitioning mac disks is probably parted.

> root@pegasos:~# mke2fs -v -j /dev/sdb1
> mke2fs 1.38 (30-Jun-2005)
> Filesystem label=
> OS type: Linux
> Block size=4096 (log=2)
> Fragment size=4096 (log=2)
> 48840704 inodes, 97677200 blocks
> 4883860 blocks (5.00%) reserved for the super user
> First data block=0
> 2981 block groups
> 32768 blocks per group, 32768 fragments per group
> 16384 inodes per group
> Superblock backups stored on blocks:
>         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
>         4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968
> 
> Writing inode tables: done
> Creating journal (32768 blocks): done
> Writing superblocks and filesystem accounting information: done
> 
> This filesystem will be automatically checked every 36 mounts or
> 180 days, whichever comes first.  Use tune2fs -c or -i to override.
> root@pegasos:~# e2fsck /dev/sdb1
> e2fsck 1.38 (30-Jun-2005)
> e2fsck: Filesystem revision too high while trying to open /dev/sdb1
> The filesystem revision is apparently too high for this version of e2fsck.
> (Or the filesystem superblock is corrupt)
> 
> 
> The superblock could not be read or does not describe a correct ext2
> filesystem.  If the device is valid and it really contains an ext2
> filesystem (and not swap or ufs or something else), then the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
>     e2fsck -b 8193 <device>
> 

> root@pegasos:~# dmesg | tail -n1
> [154695.371073] EXT3-fs: sdb1: couldn't mount because of unsupported optional features (20000).
> ----- s n i p -----
> 
> I tried using fdisk instead. Note that fdisk finds a different
> partition table than cfdisk above!
> 
> ----- s n i p -----
> root@pegasos:~# fdisk -l /dev/sdb
> /dev/sdb
>         #                    type name                  length   base      ( size )  system
> /dev/sdb1    Apple_partitiooma}amamamamamama Apple                     63 @ 1         ( 31.5k)  Unknown
> /dev/sdb2    Apple_gee_e_e_e_e_e_ o%Gï¿½%@~%Gï¿½%@o%Gï¿½%@.%Gï¿½%@.%Gï¿½%@.%Gï¿½%@.%Gï¿½%@     781434611 @ 781397715 (372.6G)  Unknown
> 
 Well, that certainly looks like an apple partition map has been
there at some time - you definitely can't use fdisk from util-linux
on it.

> Block size=512, Number of Blocks=781422768
> DeviceType=0x0, DeviceId=0x0
> 
> root@pegasos:~# dd if=/dev/zero of=/dev/sdb count=10000
> 10000+0 records in
> 10000+0 records out
> 5120000 bytes (5.1 MB) copied, 0.366181 seconds, 14.0 MB/s
> root@pegasos:~# fdisk -l /dev/sdb
> root@pegasos:~# cfdisk -P s /dev/sdb
> FATAL ERROR: No partition table.
>

 And I think that just says that cfdisk is looking for a dos
partition table.  Please try parted.

Ken
-- 
das eine Mal als Trag�die, das andere Mal als Farce
