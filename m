Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSKXURw>; Sun, 24 Nov 2002 15:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSKXURw>; Sun, 24 Nov 2002 15:17:52 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:61060
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261609AbSKXURv>; Sun, 24 Nov 2002 15:17:51 -0500
Date: Sun, 24 Nov 2002 15:28:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Patrick Mochel <mochel@osdl.org>
Subject: Unable to mount root device under .49 (possibly earlier than .47)
Message-ID: <Pine.LNX.4.50.0211241510130.1462-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.5.49 (zwane@montezuma.mastecende.com) (gcc version 3.2
20020903 (Red Hat Linux 8.0 3.2-7)) #17 SMP Sat Nov 23 15:39:24 EST 2002

What i get at boot is;

kernel /vmlinuz ro root=/dev/hda1
...
VFS: Cannot open root device "hda1" or 00:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 00:00

in init/do_mounts.c:/try_name() i get -ENOENT for sys_stat(/sys/block/hda)

i finally hacked in the ROOT_DEV to make it boot and /sys shows;

root@mondecino /sys {0} find -name hda\*
./hda
./hda/hda2
./hda/hda1

root@mondecino /sys {0} ls -l block
total 0

All the block devices are in the toplevel directory of /sys. I have
another SCSI based (/dev/sda1 root device) test box (I use the same
kernel on all boxes) which shows the following and has all its block
devices in /sys/block;

root@linux /sys {1} find -name hda\*
./block/hda
./block/hda/hda1
root@linux /sys {0} find -name sda\*
./block/sda
./block/sda/sda2
./block/sda/sda1

The odd part is that the failing test box's drive used to be in another
box, which used to boot in .48

If you need any more info please give me a holla.

	Zwane
-- 
function.linuxpower.ca
