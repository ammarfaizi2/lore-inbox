Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130661AbRCTTXx>; Tue, 20 Mar 2001 14:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130617AbRCTTXn>; Tue, 20 Mar 2001 14:23:43 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:30435 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S130616AbRCTTXf>; Tue, 20 Mar 2001 14:23:35 -0500
Message-Id: <5.0.2.1.2.20010320110527.022dfe28@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 20 Mar 2001 11:15:31 -0800
To: linux-kernel@vger.kernel.org (Linux Kernel)
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Rebooting a system with a bad filesystem (2.4.2 + ReiserFS)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I have a system here with the following setup:

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda3             19072868   6260156  11843848  35% /
/dev/hda1               198313     18161    169898  10% /boot
/dev/md0             525461076  89626136 435834940  18% /raid

/raid is the reiserfs volume.  / is ext2.

  The only thing on /raid is some pcbackup stuff. The system entirely runs 
from the root drive (ext2 filesystem).

Lately, reiserfs has been giving me problems. If I try to do anything on 
/raid - like vi a text file, the kernel will oops.  But the system will 
stay up.  All the services are there, and I can login.

However, I cannot unmount the partition, or do anythinh else.  Even if I 
call sync, it never returns.  I can't even reboot the system, or shutdown 
my nfs services.  Since all of the stuff is on the root drive, shouldn't 
linux be able to cope with such a situation?  I know that filesystems do 
get corrupted every now and then, especially if they are in the beta 
stage.  But such a malfunction should not keep the whole system from being 
shutdown.

The only way now is to hit the magic reset button.  With this, I loose a 
lot of data.  I dont know when sync was called last, but when I tried to 
call it manually, it never returned.

All the processes that are dealing with the /raid partition, are in STATE 
D,  uninterruptible sleep, and cannot be killed.

root       828 46.7 11.0 29628 28172 ?       D    02:00 258:15 
/opt/legato/usr/sbin/save -s lester.arraycomm.com -g Linux Servers -LL -f - 
-m bertha.arraycomm.com -l full -q -W 78 -N /raid /raid
root      1599  0.0  0.2  1452  548 pts/4    D    10:40   0:00 umount /dev/md0
root      1634  0.0  0.2  1452  548 pts/6    D    10:45   0:00 umount /dev/md0

I'd appreciate any help.  Thank you.

Jasmeet.

