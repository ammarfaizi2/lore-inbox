Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbSKBTNm>; Sat, 2 Nov 2002 14:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSKBTNm>; Sat, 2 Nov 2002 14:13:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:51640 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261391AbSKBTNl>;
	Sat, 2 Nov 2002 14:13:41 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 2 Nov 2002 20:19:22 +0100 (MET)
Message-Id: <UTC200211021919.gA2JJMk20461.aeb@smtp.cwi.nl>
To: marcelo@connectiva.com.br, pasky@pasky.ji.cz
Subject: Re: [PATCH] [2.4.19] Extended /proc/partitions
Cc: Andries.Brouwer@cwi.nl, hch@lst.de, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From pasky@machine.sinus.cz  Sat Nov  2 18:18:06 2002
	From: Petr Baudis <pasky@pasky.ji.cz>

	This patch extends contents of /proc/partitions by starting
	offset of each partition. This can be terribly useful if you
	by some mistake over-dd'd the partition table on a disk,
	but the system is still up. I know that you can also
	dig this out by some ioctl()s, but this can make life a lot easier
	for those who don't know C or can't dig the ioctl codes from
	the kernel source code.

(0) When it is too late, many people realize that they could have
made a backup, either with dd to some file, or with
	# sfdisk -d /dev/hda
both to file and printer.

(1) These ioctls are used by existing programs. So, for example,
	# hdparm -g /dev/hda5
will give you the starting offset (in 512-byte sectors) of /dev/hda5.
Even better may be a command like
	# blockdev --report

(2) Several programs, like mount, *fdisk, blockdev, read
/proc/partitions. Changing the format will break all of these.
So, it is best not to change anything, but if you do, only add
fields at the end.

(2a) Maybe /proc/partitions is already extended with disk statistics.
Certainly some vendors do so, and it is rumoured that stock 2.4.20
will (optionally) do so.

Given this uncertainty about what comes after the currently present
fields, it is now impossible to add anything new, unless all programs
using /proc/partitions also parse the header line.
It is best to consider /proc/partitions frozen. Linux 2.5 has
driverfs, and although "cat /proc/partitions" is much more convenient
than searching around in driverfs (sysfs), no doubt blockdev will be
changed so as to report on sysfs, when that exists and is mounted.

Andries
