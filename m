Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281663AbRKUHy2>; Wed, 21 Nov 2001 02:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281662AbRKUHyT>; Wed, 21 Nov 2001 02:54:19 -0500
Received: from velli.mail.jippii.net ([195.197.172.114]:61608 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S281663AbRKUHyF>; Wed, 21 Nov 2001 02:54:05 -0500
Message-ID: <6893478.1006329318464.JavaMail.ground12@jippii.fi>
Date: Wed, 21 Nov 2001 09:55:18 +0200 (EET)
From: Eric M <ground12@jippii.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Jippii! webmail (www.jippii.com)
X-Originating-IP: 213.139.166.70
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried changing my root and /usr partitions from ext2 to reiserfs and noticed some weird messages on boot.

Partitions on my ide-drive are like this:
   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       521   4184901    c  Win95 FAT32 (LBA)
/dev/hda2           524       654   1052257+  83  Linux
/dev/hda3           655       785   1052257+  82  Linux swap
/dev/hda4           786      5606  38724682+   5  Extended
/dev/hda5           786      1308   4200966   83  Linux
/dev/hda6          1309      5606  34523653+  83  Linux

Where hda2 is root and hda5 is /usr. The windows partition was empty at the time and i use lilo on the MBR. Lilo is version 22.1, kernel version 2.4.15-pre1. Anyway, i took backups of the root and /usr partitions with cp -a to another partition, booted from a bootdisk with reiserfs support, ran mkreiserfs and copied stuff back with cp -a. Checked that everything went back alright, ran lilo and booted.

Machine booted ok and everything seemed to be ok, but i noticed a few weird messages in boot messages right before mounting the root-partition:
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0

Other reiserfs mounts didn't give this message. it doesn't seem serious but a little disturbing still.

Also, I noticed some weird interactions with the bttv-driver. I have a bt878 based tv-card.
The bttv module and all other modules it requires loaded without hickups, didn't see anything unusual in their log-messages, but as soon as i tried starting any program that uses the video-device, I got this message:
kernel: bttv: vmalloc_32(4259840) failed

As soon as i changed my root and /usr partitions back to ext2 the same way I changed to reiserfs before, these problems disappeared. Nothing else on my computer changed in between these filesystem changes. Any ideas on what might cause this?
E.
