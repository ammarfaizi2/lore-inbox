Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269760AbUJMRbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269760AbUJMRbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 13:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbUJMRbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 13:31:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269760AbUJMRbg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 13:31:36 -0400
Date: Wed, 13 Oct 2004 13:31:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.8 Hates DOS partitions
Message-ID: <Pine.LNX.4.61.0410131329110.3818@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello DOS haters!

I used to boot my system as:

aic7xxx	[SCSI 0]
 	/dev/sda  LILO boot record
 	/dev/sda1 DOS drive C:
 	/dev/sda5 DOS drive D:
         [SCSI 1]
 	/dev/sdb1 ext2 root "/"
 	/dev/sdb2 swap-file
 	[SCSI 2]
 	/dev/sdc1 ext3 fs
 	/dev/sdc2 swap-file
 	/dev/sdc3 ext3 fs


/dev/sdb1			/		ext2	rw,noatime  0   1
/dev/sdc1			/alt		ext2	rw,noatime  0   2
/dev/sdb2			none		swap	defaults    0	2
/dev/sdc2			none		swap	defaults    0	2
/dev/sdc3			/home/users	ext2	rw,noatime  0	2 
none				/proc		proc	defaults  0	2
/dev/sda1			/dos/drive_C	msdos	defaults  0     2
/dev/sda5			/dos/drive_D	msdos	defaults  0     2


Then I added a completely different hard-disk to
boot the following:

LABEL=/ (/dev/hda2)     /                       ext3    defaults        1 1
none                    /dev/pts                devpts  gid=5,mode=666  0 0
none                    /dev/shm                tmpfs   defaults        0 0
none                    /proc                   proc    defaults        0 0
none                    /sys                    sysfs   defaults        0 0
/dev/sdb1		/home/project		ext2	defaults	0 0
/dev/sda1		/dos/drive_C		msdos	defaults	0 0
/dev/sda5		/dos/drive_D		msdos	defaults	0 0
/dev/hda3               swap                    swap    defaults        0 0
/dev/sdb2               swap                    swap    defaults        0 0
/dev/sdc2               swap                    swap    defaults        0 0

Only the DOS partitions and the swap are used in this new configuration.
This is a new "Fedora Linux 2" installation on a completely
different IDE hard disk, in which I have to enable boot disks in
the BIOS to boot the new system.

Immediately after installing the new system I reverted (in the BIOS)
to the original to make sure that I was still able to boot the old
system and the DOS partition. Everything was fine.

Then I installed linux-2.6.8 after building a new kernel with
the old ".config" file used as `make oldconfig`. Everything was
fine after that, also.

I have now run for about a week and I can't boot the DOS partition
anymore! I can boot from a DOS diskette and DOS sees 'C:', but
not 'D:'. DOS 'thinks' that C: is bootable but I get "Missing 
operating system" when it attempts to boot. I have executed
`fdisk /mbr`, and `sys C:`, as well as Norton's `ndd`. Everything
seems to 'think' that the system should boot. However, it
doesn't.

I can boot Linux from an emergency floppy and re-run LILO to
make my first SCSI bootable. It will boot Linux, but not
DOS. I can also boot DOS from a floppy and access the
"C:" partition, but not the "D:" one.

It looks like the new operating system, linux-2.6.8, has
done something bad when it used my SCSI disks for swap.

I can copy everything  from C: and D: from within Linux
and then re-do the DOS partitions, BUT.... bad stuff
will happen again unless the cause is found. I never
had any such problem with linux-2.4.26 and below. I
could even execute dosemu and run DOS compilers, editors,
and assemblers. Not anymore. DOSEMU-1.3.1 won't even
compile with the new 'C' compiler, but that's another
problem.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

