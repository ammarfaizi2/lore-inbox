Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279717AbRKMOp4>; Tue, 13 Nov 2001 09:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279728AbRKMOpq>; Tue, 13 Nov 2001 09:45:46 -0500
Received: from sirppi.helsinki.fi ([128.214.205.27]:19724 "EHLO
	sirppi.helsinki.fi") by vger.kernel.org with ESMTP
	id <S279717AbRKMOph>; Tue, 13 Nov 2001 09:45:37 -0500
Date: Tue, 13 Nov 2001 16:45:35 +0200 (EET)
From: Robert A H Holmberg <rahholmb@cc.helsinki.fi>
To: <linux-kernel@vger.kernel.org>
Subject: Odd partition overlapping problem
Message-ID: <Pine.OSF.4.30.0111131627170.14606-100000@sirppi.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a dual-boot setup with win98 and linux. I primarily use linux, but
I want to keep windows around for some inportant productivity
applications, mostly games.  My partition table is as follows:

<snip>
[root@localhost documents]# fdisk /dev/hda

The number of cylinders for this disk is set to 3736.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hda: 255 heads, 63 sectors, 3736 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       523   4200966    c  Win95 FAT32 (LBA)
/dev/hda2           524       525     16065   83  Linux
/dev/hda3           526      2647  17044965   83  Linux
/dev/hda4          2648      3736   8747392+   5  Extended
/dev/hda5          2648      2713    530113+  82  Linux swap
/dev/hda6          2714      3736   8217216    c  Win95 FAT32 (LBA)

Command (m for help):
</snip>

/dev/hda3 is my linux root partition (hda2 is /boot)  and hda6 is D: in
windows. Somehow, that I can't figure out hda3 overlaps hda6. I see this
by writing some data to hda3, booting to windows and finding out that my
D: is no longer considered "formatted". If I format D: and boot back to
linux, some of my files that I just wrote are corrupted. Since fdisk shows
no overlap and there is tha swap partition between these two partitions, I
can't figure out how this happens (other than, that somewhere there is a
bug and these two partitions DO overlap) and more importantly, for me, how
to stop this from happening without reinstalling my whole system.

My question is, can anyone here give me any ideas of how to debug this
problem? I use Linux 2.4.14 and reiserfs on hda3. I partitioned the drive
with linux fdisk, since I don't trust dos fdisk. My fdisk version is
2.10s .

Please cc to me, I'm not on the list,

Robert Holmberg

