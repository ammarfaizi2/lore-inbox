Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131080AbRCGRZO>; Wed, 7 Mar 2001 12:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131128AbRCGRZK>; Wed, 7 Mar 2001 12:25:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131080AbRCGRYv>; Wed, 7 Mar 2001 12:24:51 -0500
Date: Wed, 7 Mar 2001 12:23:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Galbraith <mikeg@wen-online.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103071752030.2732-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.3.95.1010307121716.1838A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Mike Galbraith wrote:

> On Wed, 7 Mar 2001, Richard B. Johnson wrote:
> 
> > After attempting to run 2.4.2, and killing all my hard disks, I
> > have finally gotten 2.4.1 back up. There is a continual problem
> > that even exists on 2.4.1, that will show if you execute this.
> > However, unmount your hard disks before you execute this simple
> > harmless script.
> >
> >
> > dd if=/dev/zero of=/dev/ram0 bs=1k count=1440
> > /sbin/mke2fs -Fq /dev/ram0 1440
> > mount -t ext2 /dev/ram0 /mnt
> > dd if=/dev/zero of=/mnt/foo bs=1k count=1000
> > ls -la /mnt
> > umount /mnt
> >
> > The first time you execute it, fine. It runs. The second time, you
> > get:
> >
> > Mar  7 10:29:00 chaos last message repeated 11 times
> > Mar  7 10:29:00 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 631
> > Mar  7 10:30:32 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 41
> 
> Hmmm.. no problem here.
> 
> Script started on Wed Mar  7 17:31:28 2001
> [root]:# uname -a
> Linux el-kaboom 2.4.2 #5 Wed Mar 7 17:16:17 CET 2001 i686 unknown
> [root]:# cat ./testo
> dd if=/dev/zero of=/dev/ram0 bs=1k count=1440
> /sbin/mke2fs -Fq /dev/ram0 1440
> mount -t ext2 /dev/ram0 /mnt
> dd if=/dev/zero of=/mnt/foo bs=1k count=1000
> ls -la /mnt
> umount /mnt
> [root]:# ./testo
> 1440+0 records in
> 1440+0 records out
> mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> 1000+0 records in
> 1000+0 records out
> total 1019
> drwxr-xr-x   3 root     root         1024 Mar  7 17:31 .
> drwxr-xr-x  23 root     root         1024 Feb 28 07:13 ..
> -rw-r--r--   1 root     root      1024000 Mar  7 17:31 foo
> drwxr-xr-x   2 root     root        12288 Mar  7 17:31 lost+found
> [root]:# ./testo
> 1440+0 records in
> 1440+0 records out
> mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> 1000+0 records in
> 1000+0 records out
> total 1019
> drwxr-xr-x   3 root     root         1024 Mar  7 17:31 .
> drwxr-xr-x  23 root     root         1024 Feb 28 07:13 ..
> -rw-r--r--   1 root     root      1024000 Mar  7 17:31 foo
> drwxr-xr-x   2 root     root        12288 Mar  7 17:31 lost+found
> [root]:# ./testo
> 1440+0 records in
> 1440+0 records out
> mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> 1000+0 records in
> 1000+0 records out
> total 1019
> drwxr-xr-x   3 root     root         1024 Mar  7 17:31 .
> drwxr-xr-x  23 root     root         1024 Feb 28 07:13 ..
> -rw-r--r--   1 root     root      1024000 Mar  7 17:31 foo
> drwxr-xr-x   2 root     root        12288 Mar  7 17:31 lost+found
> [root]:# exit
> exit
> 
> Script done on Wed Mar  7 17:31:50 2001
> 
> I'd sweat bullets over system integrity if _I_ got this reply ;-)
> Something is seriously amiss.

Well now the denial phase sets in. This system has run fine for
two years. It ran until I tried to use new kernels.

Question. How come you show a lost+found directory in the ramdisk??
mke2fs version 1.19 doesn't create one on a ram disk.

Script started on Wed Mar  7 12:22:20 2001
# mke2fs -Fq /dev/ram0 1440
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
# mount /dev/ram0 /mnt
# ls -la /mnt
total 0
# umount /mnt
# exit
exit

Script done on Wed Mar  7 12:23:21 2001


Also, check your logs. The errors reported don't go out to stderr.
They go to whatever you have set up for kernel errors.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


