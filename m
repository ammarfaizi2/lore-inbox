Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317850AbSGVSWG>; Mon, 22 Jul 2002 14:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317853AbSGVSWF>; Mon, 22 Jul 2002 14:22:05 -0400
Received: from [216.167.57.166] ([216.167.57.166]:14857 "EHLO
	liveglobalbid.com") by vger.kernel.org with ESMTP
	id <S317850AbSGVSU1>; Mon, 22 Jul 2002 14:20:27 -0400
Message-ID: <3D3C4DA7.5DC4550C@liveglobalbid.com>
Date: Mon, 22 Jul 2002 12:23:35 -0600
From: Roe Peterson <roe@liveglobalbid.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.27 raid1 bug...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay, I've isolated a problem with raid1/md under 2.5.27...

Scenario:

    /dev/hda2 and /dev/hdb2 are unused partitions.

/etc/raidtab:
raiddev  /dev/md0
raid-level 1
nr-raid-disks 2
chunk-size 64k
persistent-superblock 1
nr-spare-disks 0
 device /dev/hda2
 raid-disk 0
 device /dev/hdb2
 raid-disk 1

mkraid /dev/md0

Fails with a kernel panic.  A bit of searching finds that this chunk of
code (md.c, about line 850):
     rdev = list_entry(&mddev->disks.next, mdk_rdev_t, same_set);
     sb = rdev->sb;

     memset(sb, 0, sizeof(*sb));

Is failing.  sb is == 1 !!

Anyone got any ideas?





