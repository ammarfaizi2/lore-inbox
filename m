Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280563AbRKYAQQ>; Sat, 24 Nov 2001 19:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280583AbRKYAQI>; Sat, 24 Nov 2001 19:16:08 -0500
Received: from mail-smtp.uvsc.edu ([161.28.224.157]:54621 "HELO
	MAIL-SMTP.uvsc.edu") by vger.kernel.org with SMTP
	id <S280563AbRKYAPx> convert rfc822-to-8bit; Sat, 24 Nov 2001 19:15:53 -0500
Message-Id: <sbffd600.008@MAIL-SMTP.uvsc.edu>
X-Mailer: Novell GroupWise Internet Agent 5.5.4.1
Date: Sat, 24 Nov 2001 17:16:46 -0700
From: "Tyler BIRD" <birdty@uvsc.edu>
To: <jeff_l@iprimus.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Problems booting linux kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel panics because it's unable to mount the root filesystem
which you have said is on the /dev/hdb2 partition

Check out the BootDisk Howto

It appears that end_request is returning an error code which means
that the disk device driver can't access the disk.  

When you re-run lilo with your new configuration
there should be something simmilar to

name=New Linux
root=/dev/hdb2
image=/boot/bzImage

you also might want to install lilo
on your new master drive.  
boot=/dev/hdb
so you can make sure that hdb is recognized as
the new master IDE Drive

you might also want to set the ramdisk work
which contains the major minor numbers of the root device
to boot from with rdev

rdev /boot/bzImage /dev/hdb2
this would configure the compressed kernel
on /dev/hda? in the file /boot/bzImage to try to mount the
root filesystem from /dev/hdb2
your slave hard disk.  So thus I believe you wouldn't even have
to change jumpers this way and keep lilo on 
your old disk boot sector.

Tyler

>>> Jeff <jeff_l@iprimus.com.au> 11/23/01 08:52PM >>>
Greetings,
	I have two eide hard drives arranged as master and slave on my primary
ide controller.  The 20G seagate is the master and it has LILO as the 
bootloader.  This drive also has an old RH 6.1 install on it that I hardly
use.  A 30G quantum is the slave and it has linux that I built from sources.  
This latter drive and OS is the one I use mostly.  
	Now I want to configure the 30G drive as the master and I want to use
the 20G (current master) for other things.

	My 30G drive has a / (root) partition (currently /dev/hdb2) and a /boot 
partition (currently /dev/hdb1).  I couldn't get LILO to start properly when I
installed it on my 30G drive so I've switched to GRUB.  (I'll switch back to 
LILO if need be and I get good advice.)   I can get GRUB to start my kernel 
but my kernel panics when trying to mount file systems.  Here is a transcript 
of the kernel output:

attempt to access beyond end of device
03:42: rw=0, want=1, liimt=1
EXT2-fs: unable to read superblock
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
attempt to access beyond end of device
03:42: rw=0, want=33, limit=1
isofs_read_super: bread failed, dev=03:42, iso_blknum=16, block=32
Kernel panic: VFS: Unable to mount root fs on 03:42

When I switch everything back to the way it was this kernel can be started 
without a problem.

In switching the drives' master/slave status around I have (of course) done 
the following:
* changed jumper settings on both drives
* edited /etc/fstab on the 30G drive (the one I want to boot as master).
* modified the bios settings (got bios to autodetect drives in new
  configuration).

Why does my kernel panic?  How do I fix the problem so that I can boot the 
linux kernel on my 30G drive when the drive is configured as master instead 
of slave?

Please help,
		Jeff
    
-- 
===============================================================================
I never saw a wild thing
sorry for itself.
A small bird will drop frozen dead from a bough
without ever having felt sorry for itself.
	-- "Self-Pity" by David Herbert Lawrence (1885-1930)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

