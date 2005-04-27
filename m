Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVD0LrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVD0LrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 07:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVD0LrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 07:47:13 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:53400
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S261454AbVD0LrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 07:47:06 -0400
Date: Wed, 27 Apr 2005 13:46:48 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Evms-devel@lists.sourceforge.net
Subject: RFH: ext3 on EVMS on SW-RAID1 problem
Message-ID: <20050427114648.GA17153@titan.lahn.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Evms-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and help!

One of our university fileservers shows strange problems since last
friday. Syslog show the following messages:
	attempt to access beyond end of device
	dm-8: rw=0, want=8589934592, limit=262142
The strange thing: If I mount a disk-image of that volume via loop,
everything works fine!

The server was running Debian sarge with an unpatched 2.6.11.6 than, but
is running an 2.6.11.7 now and still shows the same problem.
EVMS is version 2.5.2-1 and DevMapper is version 1.01.00-4.

moradin:/var/tmp# dd if=/dev/evms/bsp2005 of=/var/tmp/bsp2005.e3
262142+0 records in
262142+0 records out
134216704 bytes transferred in 5.012082 seconds (26778633 bytes/sec)
moradin:/var/tmp# mount -o loop /var/tmp/bsp2005.e3 /mnt
moradin:/var/tmp# stat /mnt/i386-gnu-linux/tools/lib/gcc-lib/mips-linux/3.3.2/include/stddef.h
  File: `/mnt/i386-gnu-linux/tools/lib/gcc-lib/mips-linux/3.3.2/include/stddef.h'
  Size: 12695           Blocks: 28         IO Block: 4096   regular file
Device: 700h/1792d      Inode: 24840       Links: 1
Access: (0640/-rw-r-----)  Uid: ( 1000/  pmhahn)   Gid: (19992/ bsp2005)
Access: 2005-04-27 13:06:16.000000000 +0200
Modify: 2005-04-13 15:21:57.000000000 +0200
Change: 2005-04-22 08:35:09.000000000 +0200
moradin:/var/tmp# md5sum /mnt/i386-gnu-linux/tools/lib/gcc-lib/mips-linux/3.3.2/include/stddef.h
3a5f8185367677ce39f9f8d2a72a2705  /mnt/i386-gnu-linux/tools/lib/gcc-lib/mips-linux/3.3.2/include/stddef.h
moradin:~# umount /mnt

moradin:~# mount /dev/evms/bsp2005 /mnt
moradin:~# stat /mnt/i386-gnu-linux/tools/lib/gcc-lib/mips-linux/3.3.2/include/stddef.h
  File: `/mnt/i386-gnu-linux/tools/lib/gcc-lib/mips-linux/3.3.2/include/stddef.h'
  Size: 12695           Blocks: 28         IO Block: 4096   regular file
Device: fd08h/64776d    Inode: 24840       Links: 1
Access: (0640/-rw-r-----)  Uid: ( 1000/  pmhahn)   Gid: (19992/ bsp2005)
Access: 2005-04-27 13:06:16.000000000 +0200
Modify: 2005-04-13 15:21:57.000000000 +0200
Change: 2005-04-22 08:35:09.000000000 +0200
moradin:~# md5sum /mnt/i386-gnu-linux/tools/lib/gcc-lib/mips-linux/3.3.2/include/stddef.h
error processing /mnt/i386-gnu-linux/tools/lib/gcc-lib/mips-linux/3.3.2/include/stddef.h: failed in buffer_read(fd): mdfile: Input/output error
moradin:~# umount /mnt

bsp2005 is an ext3-filesystem, from which a snapshot bsp2005_snap is
created. They both live in a lvm-region, which is based on a
Software-RAID1 using two partitions of two SCSI discs:
	 lvm/svs/bsp2005#origin#
	   lvm/svs/bsp2005
	     md/md0
	       sda4
		 sda
	       sdb4
		 sdb

Is something wrong with this setup or is it a known problem? Since the
same solution was working last year without problems, I'm very confused
about this strange error behaviour.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
