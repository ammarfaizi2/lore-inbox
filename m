Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266104AbRGLMPy>; Thu, 12 Jul 2001 08:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266103AbRGLMPo>; Thu, 12 Jul 2001 08:15:44 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:22426 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id <S266097AbRGLMPc>; Thu, 12 Jul 2001 08:15:32 -0400
Date: Thu, 12 Jul 2001 14:16:54 +0200
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Subject: vfat: attempt to access beyond end of device
Message-ID: <20010712141653.A483@c239-1.fem.tu-ilmenau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wrote this mail to chaffee@bmrc.cs.berkeley.edu as suggested
in Documentation/filesystems/vfat.txt, but it seems, this
address is not valid (550 <chaffee@bmrc.cs.berkeley.edu>...
Host unknown), so I try here :)

I have a 76Gig FAT32 Partition and mount it under Linux using
the vfat filesystem.

The filesystem is filled up to 85% at the moment and I
experience problems in writing new files on it under Linux.

Filesystem            Size  Used Avail Use% Mounted on
/dev/hdc1              76G   65G   12G  85% /data

When I try to write new files on it, I get:
kernel: attempt to access beyond end of device
kernel: 16:01: rw=0, want=2081231810, limit=80035798
kernel: dev = 16:01, ino = -2120058812
kernel: Filesystem panic (dev 16:01).
kernel:   msdos_write_inode: unable to read i-node block
kernel:   File system has been set read-only
kernel: attempt to access beyond end of device
kernel: 16:01: rw=0, want=2081231810, limit=80035798
kernel: dev = 16:01, ino = -2120058812
kernel: Filesystem panic (dev 16:01).
kernel:   msdos_write_inode: unable to read i-node block

or (with 2.2.19):
kernel: attempt to access beyond end of device
kernel: 16:01: rw=0, want=2080939906, limit=80035798
kernel: dev 16:01 blksize=512 blocknr=-133087484 sector=-133087484 size=512 count=1
kernel: dev = 16:01, ino = -2129399739
kernel: Filesystem panic (dev 16:01).
kernel:   msdos_write_inode: unable to read i-node block
kernel:   File system has been set read-only
kernel: attempt to access beyond end of device
kernel: 16:01: rw=0, want=2080939906, limit=80035798
kernel: dev 16:01 blksize=512 blocknr=-133087484 sector=-133087484 size=512 count=1
kernel: dev = 16:01, ino = -2129399739
kernel: Filesystem panic (dev 16:01).
kernel:   msdos_write_inode: unable to read i-node block

Copying the same files under Windows works fine and I'm able
to access them under Linux after copying them under Windows.

I found, that this ever happen, if the Filesystem is filled
up to 12G free space - last time i removed some other files
and defragmented the filesystem and then everything worked
fine up to this magic 65G border. Now it happens again.

Windows scandisk and Linux dosfsck don't report any errors
on the filesystem (of course, after the error they do, but
not before), but the write error is reproduceable for me.

I tried to copy a large file from the disk to itself - first
under Windows, next under Linux and this both worked fine, but
copying other files to other directories doesn't work
either.

It seems, when I copy some files under Windows, I'm able to
copy some more files under Linux too (something around 50
or 100 Megs) and then the problem occures again.

I'm using a 2.4.6 kernel at the moment, but the same problem
occured with 2.4.5 and 2.2.19 kernel too.

I guess, it's something like a bit overflow in some variable
while creating new meta structures or something, dunno what
vfat has there :)

Can you help me / can I help you to trace this down?


Thanks for your work.


regards,
   Mario
-- 
Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>

So long and thanks for all the books.
