Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbTECM7o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 08:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbTECM7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 08:59:44 -0400
Received: from smtp.terra.es ([213.4.129.129]:31943 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S263307AbTECM7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 08:59:41 -0400
Date: Sat, 3 May 2003 15:20:18 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: 2.5: ext3 warning messages
Message-Id: <20030503152018.0d3541bd.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After running the last nigh 2.5.67, i switched to 2.5.68-mm2 this morning;
I got the following messages:

May  3 13:11:19 estel kernel: Freeing unused kernel memory: 168k freed
May  3 13:11:19 estel kernel: Adding 530104k swap on /dev/hda6.  Priority:-1 extents:1
May  3 13:11:19 estel kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
May  3 13:11:19 estel kernel: EXT3-fs warning (device ide0(3,5)): ext3_unlink: Deleting nonexistent file (228996), 0
May  3 13:11:21 estel kernel: lp0: using parport0 (polling).
May  3 13:11:21 estel kernel: lp0: console ready
May  3 13:11:23 estel kernel: EXT3-fs warning (device ide0(3,5)): ext3_unlink: Deleting nonexistent file (229076), 0
May  3 13:11:33 estel kernel: Kernel logging (proc) stopped.
May  3 13:11:33 estel kernel: Kernel log daemon terminating.

I rebooted and run fsck: 
(copied at hand, so text format shouldn't be correct)

fsck 1.33 (21 Apr-2003)
Pass 1: Checking inodes, blocks and sizes
Deleted inode 228996 has zero dtime Fix<y>? (i always said yes)
Inodes that were part of a corrupted orphan linked list found
Inode 229076 was part of the orphaned inode list
Pass 2 (no messages)
Pass 3: Checking directory connectivity
Unconnected directory inode 133 4075 (/tmp/???)
Connect to /lost+found <y>?
Pass 4: checking reference counts
Inode 97537 ref count is 2, should be 3. Fix<y>?
Inode 1334075 ref count is 3, should be 2. Fix<y>?
Pass 5: Checking group summary information
Free blocks count wrong for group #82 (26444, counted=26443)
Fix<y>?
Free blocks count wrong (895230, counted=895229)
Fix<y>?
Free inodes count wrong for group #82 (13151, counted=13149)
Fix<y>?
Directories count wrong for group #82 (56, counted=57)
Fix<y>?
Free inodes count wrong (1590791, counted=1590789)
Fix<y>?

File system was modified, reboot etc.
376187 inodes used (19%)
15360 non-contiguous inodes (4,1%)
# of inodes with ind/dind/tind blocks 14308/457/0
3038672 blocks used (77%)
0 bad blocks
0 large files
334986 regular diles
 26589 directories
  2002 character devices files
  4463 block device files
     5 fifos
  3157 links
  8113 symbolic links (8113 fast symbolic links)
    20 sockets
------
379335 files


the filesystem is mounted without special options, no htree

in lost+found i've a #1334075 directory wich contains
srwxrwxrwx    1 diego    diego           0 2003-05-02 18:08 socket

>From the logs, it doesn't seem i switched off the system properly :-/

The filesystem now runs well without any warning.


Diego Calleja
