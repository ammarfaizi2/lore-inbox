Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSDISqr>; Tue, 9 Apr 2002 14:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310517AbSDISqq>; Tue, 9 Apr 2002 14:46:46 -0400
Received: from [216.196.223.237] ([216.196.223.237]:23689 "HELO sin.sloth.org")
	by vger.kernel.org with SMTP id <S292855AbSDISqq>;
	Tue, 9 Apr 2002 14:46:46 -0400
Date: Tue, 9 Apr 2002 14:46:39 -0400
From: Geoffrey Gallaway <geoffeg@sin.sloth.org>
To: linux-kernel@vger.kernel.org
Subject: Ramdisks and tmpfs problems
Message-ID: <20020409144639.A14678@sin.sloth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am attempting to create a central NFS server with a single slackware 8
installation that many boxes can use as their root disks. I got bootp kernel
level autoconfiguration working and the test box sucessfully mounts the root
(/) NFS share. I'm using floppy disks with kernels on diskless machines.

The problem occurs for /var, /tmp and /etc. Because each machine will need
it's own /var, /tmp and /etc I've been trying to create a ramdisk or tmpfs
filesystem for those partitions on each box. I've been using the system
initialization scripts to setup these directories and dynamically rewrite
important files (HOSTNAME, etc) in /etc.

Originally I started playing with ram disks but when I try to create a new
ramdisk with "mke2fs /dev/ram0 16384" mke2fs says:
mke2fs: Filesystem larger then apparent filesystem size.
Proceed anyway? (y,n) y
Warning: could not erase sector 2: Invalid arguement
Warning: could not erase sector 0: Attempt to write block from filesystem
resulted in short write
mke2fs: Invalid arguement zeroing block 16320 at end of filesystem

So no go with ram disks (this is kernel 2.4.18 on a 3 gig RAM dual PIII
1gig, BTW). So now to try tmpfs. Since I need to copy the existing files in
/etc off to tmpfs I have to create a "temporary" tmpfs, copy /etc off to it
then create another tmpfs on top of the existing /etc and copy from the
"temporary" tempfs back to the new /etc. I came up with the following 
commands:
mount -w -n -t tmpfs -o defaults tmpfs /mnt
cp -axf /etc /mnt
mount -w -t tmpfs -o defaults tmpfs /etc
cp -axf /mnt/etc/* /etc/
umount /mnt
# -- Reapeat for /var and /tmp --

Again, I put these commands in slackware's init scripts and it looks like
everything is working fine until the login prompt appears, at which time the
machine immediatly uncleanly reboots, eveytime without fail.

Anyone know what could be going on? I'm out of options as far as RAM-based
filesystems. :)

Thanks,
Geoffeg
