Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317983AbSGWHla>; Tue, 23 Jul 2002 03:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSGWHla>; Tue, 23 Jul 2002 03:41:30 -0400
Received: from hermes.domdv.de ([193.102.202.1]:4114 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S317983AbSGWHl3>;
	Tue, 23 Jul 2002 03:41:29 -0400
Message-Id: <m17WuLN-003oZpC@zeus.domdv.de>
Date: Tue, 23 Jul 2002 09:45:28 +0200 (CEST)
From: Andreas Steinmetz <ast@domdv.de>
Subject: Re[2]: mkinitrd problem
To: Thunder from the hill <thunder@ngforever.de>,
       Daniel Lim <Daniel.Lim@dpws.nsw.gov.au>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
References: <Pine.LNX.4.44.0207230033280.3241-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0207230033280.3241-100000@hawkeye.luckynet.adm>
Organization: D.O.M. Datenverarbeitung GmbH
X-Mailer: Mahogany 0.64 'Sparc', compiled for Linux 2.4.15 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reminds me that at least in 2.4.16 you have to expicitly release the loop
device after an unmount:

pcast2:/tmp # dd if=/dev/zero of=tst bs=1024 count=1440
1440+0 records in
1440+0 records out
pcast2:/tmp # mke2fs tst
mke2fs 1.26 (3-Feb-2002)
tst is not a block special device.
Proceed anyway? (y,n) y
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

Writing inode tables: done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 29 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
pcast2:/tmp # mount -o loop /tmp/tst /mnt/tmp
pcast2:/tmp # umount /mnt/tmp
pcast2:/tmp # losetup -d /dev/loop0
pcast2:/tmp # losetup -d /dev/loop0
ioctl: LOOP_CLR_FD: No such device or address
pcast2:/tmp #

Note the two "losetup -d" commands above. The first one succeeds so umount
didn't release the loop device.


On Tue, 23 Jul 2002 00:34:28 -0600 (MDT) Thunder from the hill <thunder@ngforever.de> wrote:

> Hi,
> 
> On Tue, 23 Jul 2002, Daniel Lim wrote:
> > # mkinitrd /boot/initrd-2.4.9-34.img 2.4.9-34
> > All of your loopback devices are in use!
> 
> Yes, if all your loopback devices are in use, you'll have to umount
> some. 
> cat /proc/mounts, and there umount some of the filesystems with the loop 
> option.
> 
>                                                         Regards,
>                                                         Thunder



