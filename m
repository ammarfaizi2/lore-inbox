Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314295AbSEFJzm>; Mon, 6 May 2002 05:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSEFJzl>; Mon, 6 May 2002 05:55:41 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:7116 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S314295AbSEFJzj>;
	Mon, 6 May 2002 05:55:39 -0400
Date: Mon, 6 May 2002 11:55:38 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: _reliable_ way to get the dev for a mount point?
Message-ID: <Pine.GSO.4.30.0205051830060.28842-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all!

I found that in a chrooted environment the /proc/mounts file is
messed up badly. For example, if I do a
 chroot /path/to/somewhere
then in the chrooted environment's proc/mounts file will truncate
the /path/to/somewhere string from those mount point it can, and leaves
the rest as they are. (something like s|/path/to/somewhere|| )
Consequently you will have at least two devices showns as mounted to /.
But it can get worse (i know its extreme), if the directory of the
chrooted environment is overmounted.

For example, here's an output from inside the chroot environment:
# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
none /dev devfs rw 0 0
none /proc proc rw 0 0
none /proc/bus/usb usbdevfs rw 0 0
none /root/chroot1/proc proc rw 0 0
/dev/cdrom / iso9660 ro 0 0
none /proc proc rw 0 0
/dev/hda2 / ext3 rw 0 0

As you can see, there are 3 devices shown as mounted to / (in reality,
only 2 in the chrooted env), and you cannot know from this which of these
3 is your real rootdir.


So, my question is there a way to get back the device for a directory,
_reliably_. (I want to know which devices holds the files my process sees
under an arbitrary /path/to/somewhere).

Thanks,
-- 
Balazs Pozsar


