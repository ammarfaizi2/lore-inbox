Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRLGPIp>; Fri, 7 Dec 2001 10:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRLGPIh>; Fri, 7 Dec 2001 10:08:37 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:18444 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S281780AbRLGPHF>; Fri, 7 Dec 2001 10:07:05 -0500
Date: Fri, 7 Dec 2001 16:07:02 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ramdisk size bug in 2.4.17-pre2
Message-ID: <20011207150702.GD26310@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like the ramdisk driver in 2.4.17-pre2 doesn't honor the
rd_size parameter:

  root@arthur:/tmp #uname -a
  Linux arthur 2.4.17-pre2 #1 Sat Dec 1 00:47:24 CET 2001 i686 unknown
  root@arthur:/tmp #cat /proc/sys/kernel/tainted 
  0
  root@arthur:/tmp #modinfo rd
  filename:    /lib/modules/2.4.17-pre2/kernel/drivers/block/rd.o
  description: <none>
  author:      <none>
  license:     "GPL"
  parm:        rd_size int, description "Size of each RAM disk in kbytes."
  parm:        rd_blocksize int, description "Blocksize of each RAM disk in bytes."
  root@arthur:/tmp #modprobe rd rd_size=8192
  RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

So I would expect that each ramdisk is 8192kB. But:

  root@arthur:/tmp #dd if=/dev/zero of=/dev/ram1 bs=1k count=16384
  16384+0 records in
  16384+0 records out

IOW: writing 16MB to a 8MB ramdisk happily succeeds.

The last time I tried this was with 2.4.10-ac10, which didn't have this
bug.


Erik
[who will investigate further but is currently -ENOTIME]

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
