Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131134AbRCGSHh>; Wed, 7 Mar 2001 13:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131137AbRCGSH1>; Wed, 7 Mar 2001 13:07:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131134AbRCGSHT>; Wed, 7 Mar 2001 13:07:19 -0500
Date: Wed, 7 Mar 2001 13:06:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: matthew.copeland@honeywell.com
cc: Mike Galbraith <mikeg@wen-online.de>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.4.21.0103071747230.13775-100000@fisb.gaa.aro.allied.com>
Message-ID: <Pine.LNX.3.95.1010307130426.2243B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001 matthew.copeland@honeywell.com wrote:

> 
> > Question. How come you show a lost+found directory in the ramdisk??
> > mke2fs version 1.19 doesn't create one on a ram disk.
> > 
> > Script started on Wed Mar  7 12:22:20 2001
> > # mke2fs -Fq /dev/ram0 1440
> > mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> > # mount /dev/ram0 /mnt
> > # ls -la /mnt
> > total 0
> > # umount /mnt
> > # exit
> > exit
> > 
> > Script done on Wed Mar  7 12:23:21 2001
> 
> 
> That's interesting.  Mine does.  I wonder if the version difference
> between mke2fs 1.18 aand 1.19 is what is causing that?  I even tried it
> with the exact same arguments as in your script and I still got a
> lost+found.  (I am assuming that in Red Hat 6.2 they didn't change the
> mke2fs code at all.)
> 
> Matthew M. Copeland
> 
> 
> Script started on Wed Mar  7 11:49:24 2001
> [root@testgrndstn /root]# dd if=/dev/zero of=/dev/ram1 bs=1k count=4096
> 4096+0 records in
> 4096+0 records out
> [root@testgrndstn /root]# mke2fs -qm0 /dev/ram1 4096
> mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> [root@testgrndstn /root]# mount /dev/ram1 /test
> [root@testgrndstn /root]# ls -als /test
> total 17
>    1 drwxr-xr-x    3 root     root         1024 Mar  7 11:49 .
>    4 drwxr-xr-x   30 root     root         4096 Mar  7 11:47 ..
>   12 drwxr-xr-x    2 root     root        12288 Mar  7 11:49 lost+found
> [root@testgrndstn /root]# exit
> exit
> 
> 

Okay, on my system mke2fs doesn't make a lost+found on /dev/ram0, but
it does on /dev/ram1.


Script started on Wed Mar  7 13:03:52 2001
[9;0]# sh -v xxx.xxx

cp /dev/zero /dev/ram0
cp: /dev/ram0: No space left on device
mke2fs /dev/ram0 1440
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
184 inodes, 1440 blocks
72 blocks (5.00%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
184 inodes per group

Writing inode tables: 0/1done                            
Writing superblocks and filesystem accounting information: done
mount /dev/ram0 /mnt
ls -la /mnt
total 0
umount /mnt
mke2fs /dev/ram1 1440
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
184 inodes, 1440 blocks
72 blocks (5.00%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
184 inodes per group

Writing inode tables: 0/1done                            
Writing superblocks and filesystem accounting information: done
mount /dev/ram1 /mnt
ls -la /mnt
total 17
drwxr-xr-x   3 root     root         1024 Mar  7 13:03 .
drwxr-xr-x  26 root     root         4096 Mar  7 11:44 ..
drwxr-xr-x   2 root     root        12288 Mar  7 13:03 lost+found

# exit
exit

Script done on Wed Mar  7 13:04:22 2001



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


