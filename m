Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBEIGz>; Mon, 5 Feb 2001 03:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129039AbRBEIGq>; Mon, 5 Feb 2001 03:06:46 -0500
Received: from 209.102.21.2 ([209.102.21.2]:33806 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129028AbRBEIGk>;
	Mon, 5 Feb 2001 03:06:40 -0500
Message-ID: <3A7E1942.5090903@goingware.com>
Date: Mon, 05 Feb 2001 03:08:50 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OK to mount multiple FS in one dir?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was groping around my FAT/NTFS directories from Linux, mounting and 
unmounting them into
/mnt, and was suprised at some point that I got the message "/dev/sda5 
already mounted or
/mnt busy".  (I'm using a SCSI disk, use hda* for IDE).

Upon further examination, I found that I'd accidentally mounted 
/dev/sda1 (VFAT) on /mnt
while /dev/sda5 (NTFS) was still mounted there.  The NTFS files remained 
invisible until
I'd unmounted /dev/sda1 and then I could see them again.

This is with the 2.4.1 kernel on a Pentium III machine with an Adaptec 
29160 SCSI
controller.

I found I could mount three partitions on /mnt, and they'd all show up 
as mounted at
/mnt in the "mount" command, but if I unmounted one of them (only tried 
with the currently
visible one), then it appeared that there were no filesystems mounted 
there, but I could
continue umounting until the other two were gone.

I'm suprised this works.  Note that the kernel rejected an attempt to 
mount a filesystem
that was already mounted, but not to mount a filesystem at a point that 
was already in use.
It looks like there is a stack of mounts on the mount point.

Looking at Documentation/Changes, I see that I need util-linux 2.10o.  I 
had 2.10l.  But I
had the 2.10r util-linux sources on my machine and installed mount and 
umount from it, and
I find that it gets it right mostly when I mount and unmount multiple 
things, with the
exception that if /dev/sda5 was mounted before /dev/sda1, then if I give 
the command
"umount /dev/sda5", sda1 is the one that gets unmounted rather than 
sda5, so it takes the
most recently mounted filesystem rather than the one you specify.

Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
