Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313746AbSDHT3q>; Mon, 8 Apr 2002 15:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313747AbSDHT3p>; Mon, 8 Apr 2002 15:29:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14720 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313746AbSDHT3o>; Mon, 8 Apr 2002 15:29:44 -0400
Date: Mon, 8 Apr 2002 15:27:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Lang <david.lang@digitalinsight.com>
cc: Bill Davidsen <davidsen@tmr.com>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
In-Reply-To: <Pine.LNX.4.44.0204081205330.27634-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.3.95.1020408152040.1241A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, David Lang wrote:

> On Mon, 8 Apr 2002, Richard B. Johnson wrote:
> 
> > On Mon, 8 Apr 2002, David Lang wrote:
> >
> > > watch out for the write cycle limits of your flash. they're pretty low
> > > power (at least compared to anything mechanical) but if you're not careful
> > > you can go through their write capability pretty fast.
> > >
> > > David Lang
> > >
> > >
> > >
> >
> > Upon boot, you can mount a ram-disk off from /tmp. That will reduce
> > the activity when using the usual editors, vi, vim, emacs, and pico,
> > which all create temp files on /tmp.
> 
> yes, you also need to mount the flash with noatime. even then you want to
> be careful about things like autosave.
> 
> David Lang

I'm not talking about flash. I'm talking about creating a RAM-Disk
upon startup, using RAM, and mounting it off from /tmp.

Script started on Mon Apr  8 15:22:47 2002
# mke2fs /dev/ram 4096
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
1024 inodes, 4096 blocks
204 blocks (4.98%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
1024 inodes per group

Writing inode tables: 0/1 done                            
Writing superblocks and filesystem accounting information: done
# mount /dev/ram /tmp
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   4390520  11369448  28% /
/dev/sdc1              6356624   3113264   2920456  52% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282192    766080  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/dev/ram1                 3963        13      3746   0% /tmp
# ls -la /tmp
total 17
drwxr-xr-x   3 root     root         1024 Apr  8 15:23 .
drwxr-xr-x  24 root     root         4096 Apr  8 11:00 ..
drwxr-xr-x   2 root     root        12288 Apr  8 15:23 lost+found
# rmdir /tmp/lost+found
# cp * /tmp
cp: cdrom.root: omitting directory
cp: platinum-rel-V1.05: omitting directory
cp: platinum.2000: omitting directory
cp: platinum.old: omitting directory
cp: platinum.saved: omitting directory
cp: tar.gz: omitting directory
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   4390520  11369448  28% /
/dev/sdc1              6356624   3113264   2920456  52% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282192    766080  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/dev/ram1                 3963      1915      1844  51% /tmp
# ls /tmp
2Alex.mail	 config.gz   friday.pdf      reboot.tar.gz    timer.tar.gz
Allocate.sh	 copy.iso    get_cdmusic.sh  reject_probe.sh  unix2dos.c
ME.TXT		 cp.iso      gettime.sh      resume.txt       windows.bad
WhereIs.PowerPC  dos2unix.c  grok.sh	     security.sh      zzz.c
backup.cdr	 eject.c     junk.c	     sockperf.c
backup.iso	 fifo.c      launch.tar      test_ramdisk.sh
bomb.tar.gz	 fpu.c	     new.xinitrc     testpoll.c
buffer.sh	 fpu_test.c  platinum.spc    testrd.sh
# umount /tmp
# exit
exit

Script done on Mon Apr  8 15:24:39 2002


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

