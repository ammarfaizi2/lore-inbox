Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRCGRCn>; Wed, 7 Mar 2001 12:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRCGRCd>; Wed, 7 Mar 2001 12:02:33 -0500
Received: from www.wen-online.de ([212.223.88.39]:10760 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130820AbRCGRCW>;
	Wed, 7 Mar 2001 12:02:22 -0500
Date: Wed, 7 Mar 2001 18:01:50 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.3.95.1010307103537.18034B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0103071752030.2732-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Richard B. Johnson wrote:

> After attempting to run 2.4.2, and killing all my hard disks, I
> have finally gotten 2.4.1 back up. There is a continual problem
> that even exists on 2.4.1, that will show if you execute this.
> However, unmount your hard disks before you execute this simple
> harmless script.
>
>
> dd if=/dev/zero of=/dev/ram0 bs=1k count=1440
> /sbin/mke2fs -Fq /dev/ram0 1440
> mount -t ext2 /dev/ram0 /mnt
> dd if=/dev/zero of=/mnt/foo bs=1k count=1000
> ls -la /mnt
> umount /mnt
>
> The first time you execute it, fine. It runs. The second time, you
> get:
>
> Mar  7 10:29:00 chaos last message repeated 11 times
> Mar  7 10:29:00 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 631
> Mar  7 10:30:32 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 41

Hmmm.. no problem here.

Script started on Wed Mar  7 17:31:28 2001
[root]:# uname -a
Linux el-kaboom 2.4.2 #5 Wed Mar 7 17:16:17 CET 2001 i686 unknown
[root]:# cat ./testo
dd if=/dev/zero of=/dev/ram0 bs=1k count=1440
/sbin/mke2fs -Fq /dev/ram0 1440
mount -t ext2 /dev/ram0 /mnt
dd if=/dev/zero of=/mnt/foo bs=1k count=1000
ls -la /mnt
umount /mnt
[root]:# ./testo
1440+0 records in
1440+0 records out
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
1000+0 records in
1000+0 records out
total 1019
drwxr-xr-x   3 root     root         1024 Mar  7 17:31 .
drwxr-xr-x  23 root     root         1024 Feb 28 07:13 ..
-rw-r--r--   1 root     root      1024000 Mar  7 17:31 foo
drwxr-xr-x   2 root     root        12288 Mar  7 17:31 lost+found
[root]:# ./testo
1440+0 records in
1440+0 records out
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
1000+0 records in
1000+0 records out
total 1019
drwxr-xr-x   3 root     root         1024 Mar  7 17:31 .
drwxr-xr-x  23 root     root         1024 Feb 28 07:13 ..
-rw-r--r--   1 root     root      1024000 Mar  7 17:31 foo
drwxr-xr-x   2 root     root        12288 Mar  7 17:31 lost+found
[root]:# ./testo
1440+0 records in
1440+0 records out
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
1000+0 records in
1000+0 records out
total 1019
drwxr-xr-x   3 root     root         1024 Mar  7 17:31 .
drwxr-xr-x  23 root     root         1024 Feb 28 07:13 ..
-rw-r--r--   1 root     root      1024000 Mar  7 17:31 foo
drwxr-xr-x   2 root     root        12288 Mar  7 17:31 lost+found
[root]:# exit
exit

Script done on Wed Mar  7 17:31:50 2001

I'd sweat bullets over system integrity if _I_ got this reply ;-)
Something is seriously amiss.

	-Mike

