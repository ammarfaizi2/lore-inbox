Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275756AbRJNQ2E>; Sun, 14 Oct 2001 12:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275743AbRJNQ1z>; Sun, 14 Oct 2001 12:27:55 -0400
Received: from cogito.cam.org ([198.168.100.2]:65296 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S275739AbRJNQ1n>;
	Sun, 14 Oct 2001 12:27:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: Chris Mason <mason@suse.com>, Alexander Viro <viro@math.psu.edu>,
        Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Subject: Re: mount hanging 2.4.12
Date: Sun, 14 Oct 2001 11:55:20 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110140133580.3903-100000@weyl.math.psu.edu> <2101790000.1003067296@tiny>
In-Reply-To: <2101790000.1003067296@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011014155520.EB2DC290B5@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 14, 2001 09:48 am, Chris Mason wrote:
> On Sunday, October 14, 2001 01:46:19 AM -0400 Alexander Viro
>
> <viro@math.psu.edu> wrote:
> > On Sun, 14 Oct 2001, Alexander Viro wrote:
> >> 	Deadlocks on lock_super().  I don't see any changes in that
> >> area, though...
> >
> > Erm, wait...  What patches do you have applied?  After a second look
> > at your objdump it seems that you've got spinlocks turned into
> > semaphores. What the hell is going on there?
>
> Ed, does this hang happen without the new reiserfs snapshot locking patch
> applied?

Hi with the vfs locking patch removed it works.

oscar# mount /fuji
usb-uhci.c: interrupt, status 3, frame# 1622
SCSI device sda: 131072 512-byte hdwr sectors (67 MB)
sda: Write Protect is on
 sda: sda1
oscar# ls /fuji
dcim
oscar# umount /fuji
oscar# umount /fuji
umount: /fuji: not mounted
oscar# mount /fuji
usb-uhci.c: interrupt, status 2, frame# 1448
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
mount: wrong fs type, bad option, bad superblock on /dev/sda1,
       or too many mounted file systems
SCSI device sda: 131072 512-byte hdwr sectors (67 MB)
sda: Write Protect is on
 sda: sda1
oscar# cat /proc/mounts
/dev/root.old /initrd ext2 rw 0 0
/dev/root / reiserfs rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/lv/misc /misc reiserfs rw 0 0
/dev/hda2 /boot ext2 rw 0 0
/dev/hda1 /w98 vfat ro 0 0
none /proc/bus/usb usbdevfs rw 0 0
tmpfs /tmp tmpfs rw 0 0
/dev/hda4 /root2 ext2 ro 0 0
oscar# mount /fuji
oscar# ls /fuji
dcim
oscar#

Chris, what I suspect is happening is that the mount with the error leaves
the sem locked.  After this any mount commant hangs - not just ones for the
USB card read (ie. loop mount to build an initrd fails too..)

Ed
