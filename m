Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131084AbRCGPtt>; Wed, 7 Mar 2001 10:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131086AbRCGPtj>; Wed, 7 Mar 2001 10:49:39 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48769 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131084AbRCGPt3>; Wed, 7 Mar 2001 10:49:29 -0500
Date: Wed, 7 Mar 2001 10:48:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Ramdisk (and other) problems with 2.4.2
Message-ID: <Pine.LNX.3.95.1010307103537.18034B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After attempting to run 2.4.2, and killing all my hard disks, I
have finally gotten 2.4.1 back up. There is a continual problem
that even exists on 2.4.1, that will show if you execute this.
However, unmount your hard disks before you execute this simple
harmless script. 


dd if=/dev/zero of=/dev/ram0 bs=1k count=1440
/sbin/mke2fs -Fq /dev/ram0 1440 
mount -t ext2 /dev/ram0 /mnt
dd if=/dev/zero of=/mnt/foo bs=1k count=1000
ls -la /mnt
umount /mnt

The first time you execute it, fine. It runs. The second time, you
get:

Mar  7 10:29:00 chaos last message repeated 11 times
Mar  7 10:29:00 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 631 
Mar  7 10:30:32 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 41 
Mar  7 10:30:32 chaos last message repeated 11 times
Mar  7 10:30:32 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 53 
Mar  7 10:30:32 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 310 
Mar  7 10:30:32 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 614 
Mar  7 10:30:32 chaos last message repeated 4 times
Mar  7 10:30:32 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 619 
Mar  7 10:30:32 chaos last message repeated 11 times
Mar  7 10:30:32 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 631 
Mar  7 10:34:25 chaos sendmail[17986]: f27FYJh17986: from=<linux-kernel-owner@vger.kernel.org>, size=1830, class=-60, nrcpts=1, msgid=<200103071529.f27FTjO26978@aslan.scsiguy.com>, bodytype=8BITMIME, proto=ESMTP, daemon=MTA, relay=vger.kernel.org [199.183
.24.194]
Mar  7 10:34:26 chaos sendmail[17994]: f27FYJh17986: to=<root@chaos.analogic.com>, delay=00:00:07, xdelay=00:00:01, mailer=local, pri=138660, dsn=2.0.0, stat=Sent
Mar  7 10:34:46 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 41 
Mar  7 10:34:46 chaos last message repeated 11 times
Mar  7 10:34:46 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 53 
Mar  7 10:34:46 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 310 
Mar  7 10:34:58 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 41 
Mar  7 10:34:58 chaos last message repeated 11 times
Mar  7 10:34:58 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 53 
Mar  7 10:34:58 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 310 
Mar  7 10:35:06 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 41 
Mar  7 10:35:06 chaos last message repeated 11 times
Mar  7 10:35:06 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 53 
Mar  7 10:35:06 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 310 
Mar  7 10:38:58 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 41 
Mar  7 10:38:58 chaos last message repeated 11 times
Mar  7 10:38:58 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 53 
Mar  7 10:38:58 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 310 


...and no files are generated in the ramdisk ... and, If you don't
reboot soon, you will have file-system corruption all throughout your
hard disks(s) including those which are not mounted (really). Some
offset gets screwed so umounted disks are written. Reboot with the
reset switch.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


