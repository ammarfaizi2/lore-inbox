Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281609AbRLQRFB>; Mon, 17 Dec 2001 12:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281663AbRLQREv>; Mon, 17 Dec 2001 12:04:51 -0500
Received: from [64.209.222.100] ([64.209.222.100]:60423 "HELO
	mx1.gc.ny.otec.com") by vger.kernel.org with SMTP
	id <S281609AbRLQREm>; Mon, 17 Dec 2001 12:04:42 -0500
Date: Mon, 17 Dec 2001 12:03:55 -0500 (EST)
From: dan kelley <dkelley@otec.com>
X-X-Sender: <djk@nixon.bos.otec.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.17rc1 reiserfs/aacraid
Message-ID: <Pine.LNX.4.33.0112171156510.30691-100000@nixon.bos.otec.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi-

with the above combination, i'm experiencing some strange behavior.  i
have the following layout:

root@mail:/home/djk > df -T
Filesystem    Type   1k-blocks      Used Available Use% Mounted on
/dev/sda5     ext2     7566400     77008   7105040   2% /
/dev/sda1     ext2       54416      5750     45857  12% /boot
/dev/sdb6 reiserfs     8329408    200324   8129084   3% /opt
/dev/sdb5 reiserfs     9437828   1162232   8275596  13% /usr
/dev/sda7 reiserfs     9253120    112272   9140848   2% /var
shmfs          shm      127552         0    127552   0% /dev/shm

everything you see is mounted at boot, with the 3 resiserfs partitions
being mounted with a standard suse 7.2 boot (/etc/init.d/boot):

mount -av -t nonfs,noproc,nodevpts

they system comes up ok, but i'm unable to unmount any of the reiserfs
partitions:

root@mail:/home/djk > umount -f /opt
umount2: Device or resource busy
umount: /opt: device is busy

what's weird is that it looks like the kernel is stuck on the mount of the
partition:

root@mail:/home/djk > fuser -v /opt

                     USER        PID ACCESS COMMAND
/opt                 root     kernel mount  /opt


same thing for the other two reiserfs partitions.

if i remove any of the resier partitions from /etc/fstab, i'm able to
mount them and umount them without a problem once the system is up.

so, on first glance, there appears to be some type of weird interaction
between the new aacraid code and reiser.

thanks-

dan

