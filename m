Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSGLMvD>; Fri, 12 Jul 2002 08:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSGLMvC>; Fri, 12 Jul 2002 08:51:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316185AbSGLMu4>; Fri, 12 Jul 2002 08:50:56 -0400
Date: Fri, 12 Jul 2002 08:53:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: ext2 'remount' problem
Message-ID: <Pine.LNX.3.95.1020712085149.271A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I discovered this repeatable anomaly using Linux Version 2.4.18
and mount version "mount-2.10o".

If file-systems are mounted upon boot with 'defaults' as options

like /etc/fstab...

# device			directory	type	options	freq pass
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
/dev/sdb1			/		ext2	defaults  0   1
/dev/sdc1			/alt		ext2	defaults  0   2
/dev/sdb2			none		swap	defaults  0	2
/dev/sdc2			none		swap	defaults  0	2
/dev/sdc3			/home/users	ext2	defaults  0	2	
none				/proc		proc	defaults  0	2
/dev/sda1			/dos/drive_C	msdos	defaults  0     2
/dev/sda5			/dos/drive_D	msdos	defaults  0     2


Then I execute:

mount -o remount,rw,noatime /
mount -o remount,rw,noatime /alt
mount -o remount,rw,noatime /home/users


The result is (correctly)

cat /proc/mounts

/dev/root.old /initrd ext2 rw 0 0
/dev/root / ext2 rw,noatime 0 0
/dev/sdc1 /alt ext2 rw,noatime 0 0
/dev/sdc3 /home/users ext2 rw,noatime 0 0
none /proc proc rw 0 0
/dev/sda1 /dos/drive_C msdos rw 0 0
/dev/sda5 /dos/drive_D msdos rw 0 0

Now, if I shut down the system, properly dismounting all the drives,
then I reboot, the drives that were re-mounted end up being fscked
due to 'was not cleanly unmounted' inference. Nothing wrong is found.

Now, if I mount the drives "noatime" from the start, i.e., from
/etc/fstab upon startup, there are no such errors upon re-boot.

There is something going wrong during 'remount' that makes e2fsck
'think' that the drives were not cleanly dismounted.

Is this a known problem, fixed in later versions?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

