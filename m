Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbSLKHww>; Wed, 11 Dec 2002 02:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267014AbSLKHww>; Wed, 11 Dec 2002 02:52:52 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:64525 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S267005AbSLKHwv>; Wed, 11 Dec 2002 02:52:51 -0500
Date: Wed, 11 Dec 2002 00:00:33 -0800
From: TomF <TomF@sjpc.org>
To: linux-kernel@vger.kernel.org
Subject: mounting udf DVD-RAM changes owner
Message-Id: <20021211000033.3b9fe22a.TomF@sjpc.org>
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running Redhat 8.0 plus Win4Lin 4.0.7 on a Pentium III 600Mhz with 768MB RAM, 4 SCSI hard drives, an IDE hard drive, a Panasonic LF-D201 SCSI DVD-RAM, an HP deskjet 6122, and an HP Scanjet 7450C.  The Redhat kernel is 2.4.18-14, and the Win4Lin kernel is a patched version of the Redhat kernel.  I have DVD-RAM cartridges formatted FAT32 under Windows XP, and others formatted by udftools-1.0.0b2/mkudffs.  The fstab entry of interest is

/dev/scd0               /mnt/dvd             	auto	noauto,users,kudzu,rw,exec,uid=Tom,umask=000 0 0

Before I mount a udf cartridge, I get

[Tom@localhost Tom]$ ls -l /mnt
...
drwxr-xr-x    2 Tom      root         4096 Nov  5 11:20 dvd

[Tom@localhost Tom]$ mount /mnt/dvd
[Tom@localhost Tom]$ ls -l /mnt
...
drwxr-xr-x    4 root     root          140 Dec  6 19:13 dvd

[Tom@localhost Tom]$ umount /mnt/dvd
[Tom@localhost Tom]$ ls -l /mnt
...
drwxr-xr-x    2 Tom      root         4096 Nov  5 11:20 dvd

If I then mount a FAT32 cartridge, I get

[Tom@localhost Tom]$ mount /mnt/dvd
[Tom@localhost Tom]$ ls -l /mnt
...
drwxrwxrwx    3 Tom      Tom         16384 Dec 31  1969 dvd
...
[Tom@localhost Tom]$ mount
...
/dev/scd0 on /mnt/dvd type vfat (rw,nosuid,nodev,uid=500,umask=000)


Each time I mount a udf cartridge, I have to do su to chown it before I can write to it in user mode.  Both the ownership and the permissions go back to the same root valuse, ignoring the fstab entry, until I do this. The behavior is the same for the Redhat kernel and the Win4Lin kernel. 

I can get around this problem by adding myself to the root group, I think, but changing the permissions does not help.  I found no clues in the mkudffs man page or in the linux-kernel archives.

Is there some trick for configuring to get around this problem?  Is this a bug?
