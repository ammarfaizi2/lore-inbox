Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267279AbRGKLgD>; Wed, 11 Jul 2001 07:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbRGKLfy>; Wed, 11 Jul 2001 07:35:54 -0400
Received: from [194.213.32.142] ([194.213.32.142]:15620 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267279AbRGKLfs>;
	Wed, 11 Jul 2001 07:35:48 -0400
Message-ID: <20010710232603.A242@bug.ucw.cz>
Date: Tue, 10 Jul 2001 23:26:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: viro@math.psu.edu
Subject: Filesystem can be marked clear when it is not
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Long time ago I noticed that forced reboot from multiuser (/ mounted
rw long time ago) sometimes does not force filesystem check. It
happened again today...

So I remounted r/o and fsck-ed. And hey, they are errors: [zero dtimes
are ok, but bitmap differences really are not].

I *think* that we do not force ordering of "mark filesystem unclean"
and writes to filesystem. And we really *should* force that
ordering... Quick and dirty solution would be to sync just after we
mark filesystem dirty...

								Pavel

root@bug:~# fsck -f /dev/hda1
Parallelizing fsck version 1.18 (11-Nov-1999)
e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Deleted inode 480986 has zero dtime.  Fix<y>? yes

Deleted inode 481006 has zero dtime.  Fix<y>? yes

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong for group #2 (37, counted=42).
Fix<y>? yes

Free blocks count wrong (14705, counted=14710).
Fix<y>? yes

Inode bitmap differences:  -480986 -481006
Fix<y>? yes

Free inodes count wrong for group #15 (24936, counted=24938).
Fix<y>? yes

Free inodes count wrong (755991, counted=755993).
Fix<y>? yes


/dev/hda1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/hda1: 173863/929856 files (10.6% non-contiguous), 915044/929754
blocks
root@bug:~#


-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
