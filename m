Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRACWjX>; Wed, 3 Jan 2001 17:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130319AbRACWjM>; Wed, 3 Jan 2001 17:39:12 -0500
Received: from 64.124.41.10.napster.com ([64.124.41.10]:55313 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129771AbRACWi5>; Wed, 3 Jan 2001 17:38:57 -0500
Message-ID: <3A53A9FB.A3D558D9@napster.com>
Date: Wed, 03 Jan 2001 14:38:51 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-pre able to mount SHM twice
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is probably due to the source being 'none', but the shm mount point
can be mounted twice at the same mount point.

Shouldn't mount(2) return -EBUSY in this case?


# cat /etc/mtab
/dev/hda4 / ext2 rw,errors=remount-ro,errors=remount-ro 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw,gid=5,mode=620 0 0
/dev/hda1 /boot ext2 rw 0 0
/dev/hda3 /mnt/win vfat rw 0 0
none /proc/bus/usb usbdevfs rw 0 0

# mount /dev/shm
# cat /etc/mtab
/dev/hda4 / ext2 rw,errors=remount-ro,errors=remount-ro 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw,gid=5,mode=620 0 0
/dev/hda1 /boot ext2 rw 0 0
/dev/hda3 /mnt/win vfat rw 0 0
none /proc/bus/usb usbdevfs rw 0 0
none /dev/shm shm rw 0 0

# mount /dev/shm
# cat /etc/mtab
/dev/hda4 / ext2 rw,errors=remount-ro,errors=remount-ro 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw,gid=5,mode=620 0 0
/dev/hda1 /boot ext2 rw 0 0
/dev/hda3 /mnt/win vfat rw 0 0
none /proc/bus/usb usbdevfs rw 0 0
none /dev/shm shm rw 0 0
none /dev/shm shm rw 0 0

# umount /dev/shm
# cat /etc/mtab
/dev/hda4 / ext2 rw,errors=remount-ro,errors=remount-ro 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw,gid=5,mode=620 0 0
/dev/hda1 /boot ext2 rw 0 0
/dev/hda3 /mnt/win vfat rw 0 0
none /proc/bus/usb usbdevfs rw 0 0

Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
