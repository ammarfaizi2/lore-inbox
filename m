Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131127AbRCGRy5>; Wed, 7 Mar 2001 12:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131128AbRCGRys>; Wed, 7 Mar 2001 12:54:48 -0500
Received: from tmpsmtp705.honeywell.com ([199.64.7.105]:18693 "HELO
	tmpsmtp705.honeywell.com") by vger.kernel.org with SMTP
	id <S131127AbRCGRyh>; Wed, 7 Mar 2001 12:54:37 -0500
Date: Wed, 7 Mar 2001 17:53:04 +0000 (UTC)
From: matthew.copeland@honeywell.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.3.95.1010307121716.1838A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0103071747230.13775-100000@fisb.gaa.aro.allied.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Question. How come you show a lost+found directory in the ramdisk??
> mke2fs version 1.19 doesn't create one on a ram disk.
> 
> Script started on Wed Mar  7 12:22:20 2001
> # mke2fs -Fq /dev/ram0 1440
> mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> # mount /dev/ram0 /mnt
> # ls -la /mnt
> total 0
> # umount /mnt
> # exit
> exit
> 
> Script done on Wed Mar  7 12:23:21 2001


That's interesting.  Mine does.  I wonder if the version difference
between mke2fs 1.18 aand 1.19 is what is causing that?  I even tried it
with the exact same arguments as in your script and I still got a
lost+found.  (I am assuming that in Red Hat 6.2 they didn't change the
mke2fs code at all.)

Matthew M. Copeland


Script started on Wed Mar  7 11:49:24 2001
[root@testgrndstn /root]# dd if=/dev/zero of=/dev/ram1 bs=1k count=4096
4096+0 records in
4096+0 records out
[root@testgrndstn /root]# mke2fs -qm0 /dev/ram1 4096
mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
[root@testgrndstn /root]# mount /dev/ram1 /test
[root@testgrndstn /root]# ls -als /test
total 17
   1 drwxr-xr-x    3 root     root         1024 Mar  7 11:49 .
   4 drwxr-xr-x   30 root     root         4096 Mar  7 11:47 ..
  12 drwxr-xr-x    2 root     root        12288 Mar  7 11:49 lost+found
[root@testgrndstn /root]# exit
exit


