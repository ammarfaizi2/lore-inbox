Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTLRV0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 16:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265324AbTLRV0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 16:26:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18309 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265295AbTLRV0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 16:26:09 -0500
Date: Thu, 18 Dec 2003 16:29:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Kurt Roeckx <Q@ping.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 truncate bug in 2.6.0?
In-Reply-To: <20031218210713.GA21777@ping.be>
Message-ID: <Pine.LNX.4.53.0312181628030.13755@chaos>
References: <20031218210713.GA21777@ping.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Kurt Roeckx wrote:

> When writing to the file, and the filesystem (ext3) is full, it
> seems to block count gets wrong.
>
> I ran an e2fsck on the fs and found no problems.  Then I mounted
> it again, wrote a file until the fs was full, unmounted and ran
> e2fsck again, and get this:
>
> e2fsck 1.32 (09-Nov-2002)
> Pass 1: Checking inodes, blocks, and sizes
> Inode 276481, i_blocks is 681584, should be 681582.  Fix<y>?
>
> If my memory is any good, their was a simular problem in 2.4

No such problem on 2.4.22, SMP, with SCSI disks.

Script started on Thu Dec 18 16:21:28 2003
# cat /dev/zero >/home/users/foo
cat: write error: No space left on device
# umount /home/users
# fsck /dev/sdc3
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/sdc3: clean, 91715/286272 files, 572315/572315 blocks
# fsck -f /dev/sdc3
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/sdc3: 91715/286272 files (0.2% non-contiguous), 572315/572315 blocks
# mount -a
# rm /home/users/foo
# umount /home/users
# fsck -f /dev/sdc3
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/sdc3: 91714/286272 files (0.2% non-contiguous), 463734/572315 blocks
# mount -a
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5866060   9893908  37% /
/dev/sdc1              6356624   1217040   4816680  20% /alt
/dev/sda1              1048272    280928    767344  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/dev/sdc3              2253284   1818960    319864  85% /home/users
# exit
exit
Script done on Thu Dec 18 16:26:49 2003


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


