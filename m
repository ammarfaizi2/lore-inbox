Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSKFGUb>; Wed, 6 Nov 2002 01:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbSKFGUb>; Wed, 6 Nov 2002 01:20:31 -0500
Received: from rj.SGI.COM ([192.82.208.96]:32234 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S265649AbSKFGU0>;
	Wed, 6 Nov 2002 01:20:26 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 dirty ext2 mount error 
In-reply-to: Your message of "Tue, 05 Nov 2002 21:46:19 -0800."
             <3DC8ACAB.8C0DB37D@digeo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 17:26:51 +1100
Message-ID: <21861.1036564011@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Nov 2002 21:46:19 -0800, 
Andrew Morton <akpm@digeo.com> wrote:
>Keith Owens wrote:
>> 
>> The root partition was originally ext3.  fstab now contains
>> 
>> /dev/sda1               /                       ext2    defaults        1 1
>> 
>> Booting 2.4.20-rc1 (ext3 as a module, not loaded yet) with a dirty / gets
>> 
>> EXT2-fs: sd(8,1): couldn't mount because of unsupported optional features (4).
>> Drop back to 2.4.18 and it works, automatically running fsck.ext2 -a /dev/sda1.
>> 
>
>You sure?  That would be a bug in 2.4.18...
>
>ext2 does not know how to mount a needs-recovery ext3 filesystem.  It
>is flagged as an incompatible feature (4 -> EXT3_FEATURE_INCOMPAT_RECOVER).

Unclean shutdown, reboot.

LILO boot: 2.4.20-rc1
Loading 2.4.20-rc1........................
Linux version 2.4.20-rc1 (kaos@sherman) (gcc version 3.2 20020822 (Red Hat Linux Rawhide 3.2-4)) #10 SMP Wed Nov 6 16:10:31 EST 2002
Kernel command line: auto BOOT_IMAGE=2.4.20-rc1 ro root=801 BOOT_FILE=/lib/modules/2.4.20-rc1/bzImage console=tty0 console=ttyS0,38400 mem=127M
EXT2-fs: sd(8,1): couldn't mount because of unsupported optional features (4).
Kernel panic: VFS: Unable to mount root fs on 08:01
 
Entering kdb (current=0xc11f4000, pid 1) on processor 1 due to KDB_ENTER()
[1]kdb> reboot

Come up on 2.4.18-14 from RH.  It detects ext3 and cleans the journal,
even though fstab says ext2.  Then ext2 does fsck.ext2 -a /dev/sda1.  I
guess the question is why ext3 is being used when fstab says ext2?
Especially when that stuffs up booting into other kernels that do not
have ext3 support at all.

LILO boot: 
Loading linux............................
Linux version 2.4.18-14smp (bhcompile@stripples.devel.redhat.com) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 SMP Wed Sep 4 12:34:47 EDT 2002
Freeing initrd memory: 258k freed
VFS: Mounted root (ext2 filesystem).
Red Hat nash version 3.4.28 starting
Loading scsi_mod module
SCSI subsystem driver Revision: 1.00
Loading sd_mod module
Loading jbd module
Journalled Block Device driver loaded
Loading ext3 module
Mounting /proc filesysteEXT3-fs: INFO: recovery required on readonly filesystem.
m
Creating blocEXT3-fs: write access will be enabled during recovery.
k devices
Creating root device
Mounting root filesystem
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sd(8,1): orphan cleanup on readonly fs
EXT3-fs: sd(8,1): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 240k freed
INIT: version 2.84 booting
               Welcome to Red Hat Linux
               Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Unmounting initrd:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (utc): Wed Nov  6 16:25:57 EST 2002 [  OK  ]
Setting hostname snowy:  [  OK  ]
Initializing USB controller (usb-uhci):  [  OK  ]
Mounting USB filesystem:  [  OK  ]
Initializing USB HID interface:  [  OK  ]
Initializing USB keyboard:  [  OK  ]
Initializing USB mouse:  [  OK  ]
Your system appears to have shut down uncleanly
Press Y within 1 seconds to force file system integrity check...
Checking root filesystem
/12: clean, 23509/66264 files, 130447/265041 blocks
[/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/sda1 

