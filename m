Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbTLNA1O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 19:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbTLNA1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 19:27:14 -0500
Received: from nevyn.them.org ([66.93.172.17]:14720 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265316AbTLNA1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 19:27:11 -0500
Date: Sat, 13 Dec 2003 19:27:09 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: RAID5 recovery quirk (?) on 2.6.0-test9
Message-ID: <20031214002708.GA836@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My desktop, a dual P3 running 2.6.0-test9, just had a lockup.  I don't
have any useful information on the lockup (I was running the glibc
testsuite, I think?), but I noticed something really interesting when
the machine came back up.

My root is ext3, and reported that it was recovering from journal.  But
it's also on the md array - and md didn't need to reconstruct.  This
could be a feature, but it's one I've never seen happen before - how
did it know it didn't need to reconstruct?

The lockup was total as far as I can tell, and I had to use the
physical reset switch.

Here's a bit of the log:

md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1824.000 MB/sec
   8regs_prefetch:  1464.000 MB/sec
   32regs    :   960.000 MB/sec
   32regs_prefetch:   892.000 MB/sec
   pIII_sse  :  1972.000 MB/sec
   pII_mmx   :  2476.000 MB/sec
   p5_mmx    :  2644.000 MB/sec
raid5: using function: pIII_sse (1972.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27

md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdg2 ...
md:  adding hdg2 ...
md:  adding hde2 ...
md:  adding hdc2 ...
md: created md0
md: bind<hdc2>
md: bind<hde2>
md: bind<hdg2>
md: running: <hdg2><hde2><hdc2>
raid5: device hdg2 operational as raid disk 1
raid5: device hde2 operational as raid disk 2
raid5: device hdc2 operational as raid disk 0
raid5: allocated 3147kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hdc2
 disk 1, o:1, dev:hdg2
 disk 2, o:1, dev:hde2
md: ... autorun DONE.

EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
hub 1-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:07.2-1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: md0: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 16351637
ext3_orphan_cleanup: deleting unreferenced inode 18056861
ext3_orphan_cleanup: deleting unreferenced inode 5619863
ext3_orphan_cleanup: deleting unreferenced inode 13502232
ext3_orphan_cleanup: deleting unreferenced inode 13502231
ext3_orphan_cleanup: deleting unreferenced inode 13502230
ext3_orphan_cleanup: deleting unreferenced inode 13502213
ext3_orphan_cleanup: deleting unreferenced inode 12853529
ext3_orphan_cleanup: deleting unreferenced inode 6684899
EXT3-fs: md0: 9 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.



-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
