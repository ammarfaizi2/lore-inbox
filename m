Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269501AbUICBIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269501AbUICBIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269480AbUICAzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:55:52 -0400
Received: from smtp06.auna.com ([62.81.186.16]:22227 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S269490AbUICAzB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:55:01 -0400
Date: Fri, 03 Sep 2004 00:54:56 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: buildin a RAID5 md vith 6 drives
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.4
Message-Id: <1094172896l.17931l.2l@werewolf.able.es>
X-Balsa-Fcc: file:///home/magallon/mail/sentbox
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I tried to build a RAID5 array with 6 drivres, just with:


mdadm --create --verbose --run \
        /dev/md0 --level=5 --chunk=256 \
        --raid-devices=6 \
        /dev/sda1 /dev/sdb1 /dev/sdc1 \
        /dev/sdd1 /dev/sde1 /dev/sdf1

And the raid looks in an strange state:

nada:~# mdadm -D /dev/md0
/dev/md0:
        Version : 00.90.01
  Creation Time : Fri Sep  3 02:17:28 2004
     Raid Level : raid5
     Array Size : 1225557760 (1168.78 GiB 1254.97 GB)
    Device Size : 245111552 (233.76 GiB 250.99 GB)
   Raid Devices : 6
  Total Devices : 6
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Fri Sep  3 02:42:32 2004
          State : clean, degraded, recovering
 Active Devices : 5
Working Devices : 6
 Failed Devices : 0
  Spare Devices : 1

         Layout : left-symmetric
     Chunk Size : 256K

 Rebuild Status : 8% complete

           UUID : fd6fcad0:21da140b:072a82b1:11b3db21
         Events : 0.30

    Number   Major   Minor   RaidDevice State
       0       8        1        0      active sync   /dev/sda1
       1       8       17        1      active sync   /dev/sdb1
       2       8       33        2      active sync   /dev/sdc1
       3       8       49        3      active sync   /dev/sdd1
       4       8       65        4      active sync   /dev/sde1
       5       0        0        -      removed

       6       8       81        5      spare rebuilding   /dev/sdf1

Why does it think a drive has been removed, and the last drive is a spare ?
Isn't raid5 symmetric over all drives ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Beta 1) for i586
Linux 2.6.8.1-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #8


