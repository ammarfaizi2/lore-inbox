Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbTBDMqM>; Tue, 4 Feb 2003 07:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTBDMqM>; Tue, 4 Feb 2003 07:46:12 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:31627 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S267224AbTBDMqK>; Tue, 4 Feb 2003 07:46:10 -0500
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19: Strange raid1 resync problem with raid1 on top of  multipath raids
Date: Tue, 4 Feb 2003 13:55:42 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302041355.42073.krienke@uni-koblenz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running smp Kernel 2.4.19 (from SuSE: k_smp-2.4.19-210) on a machine that 
is connected by a fibrechannel fabric to several hardware raid (5) devices. 
There are two paths to each partition on the hardware raids. I want to have a 
mirror on two of the hardware raid5 devices (I know this is very redundant). 
Since each hardware raid can be reached along two different paths (across two 
fc-switches) I would like to use a multipath config.

So I configured a raid1 device on top of two multipath raid devices like shown 
below in a part of /etc/raidtab. Generally things work just fine. However 
there is one big problem: The resync speed for the raid1 device is only about 
1MByte/sec. Because of the size of the array (~900GBytes) resyncing would 
take about 30Days! If I omit the multipath configuration and just specify a 
simple raid1 across the two hardwareraid disks, resync speed is at about 
60MBytes/sec which is normal.

Is this a known problem? Is there a patch to get things right?

Thanks very much
Rainer

---------------------------------------------------------------
/etc/raidtab
The devicenames are aliases from scsidev
so do not wonder. sw0, sw1 represent
the fc-switches by which the raid devices are
connected to the host. There is one path over sw0 
to a disk and another over sw1 to the same disk.
---------------------------------------------------------------
raiddev                 /dev/md5
raid-level              multipath
nr-raid-disks           1
nr-spare-disks          1
chunk-size              4
device                  /dev/scsi/sw0d0l0-p1
raid-disk               0
device                  /dev/scsi/sw1d0l0-p1
spare-disk              1

raiddev                 /dev/md6
raid-level              multipath
nr-raid-disks           1
nr-spare-disks          1
chunk-size              4
device                  /dev/scsi/sw0d1l0-p1
raid-disk               0
device                  /dev/scsi/sw1d1l0-p1
spare-disk              1

raiddev /dev/md7
raid-level      1
nr-raid-disks   2
nr-spare-disks  0
chunk-size      4
persistent-superblock 1
device          /dev/md5
raid-disk       0
device          /dev/md6
raid-disk       1

-- 
---------------------------------------------------------------------------
Rainer Krienke, Universitaet Koblenz, Rechenzentrum
Universitaetsstrasse 1, 56070 Koblenz, Tel: +49 261287 -1312, Fax: -1001312
Mail: krienke@uni-koblenz.de, Web: http://www.uni-koblenz.de/~krienke
Get my public PGP key: http://www.uni-koblenz.de/~krienke/mypgp.html
---------------------------------------------------------------------------

