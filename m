Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269433AbUICAit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269433AbUICAit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269434AbUICAOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:14:01 -0400
Received: from smtp07.auna.com ([62.81.186.17]:31961 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S269403AbUICAIQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:08:16 -0400
Date: Fri, 03 Sep 2004 00:05:37 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: md RAID over SATA performance
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
X-Mailer: Balsa 2.2.4
Message-Id: <1094169937l.17931l.0l@werewolf.able.es>
X-Balsa-Fcc: file:///home/magallon/mail/sentbox
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I am buildin an array with a linux box, and I run 2.6.8.1 (not stock, but
the mandrake cooker version).

Disks are 6 SATA drives, plugged to a couple of Promise FastTrak S150 TX4
cards.

Problem is that i get really poor performance. A single drive gives about
57 Mb/s, and a raid1 with two just gives about 64 Mb/s (measured with
hdparm -tT). With the six drives:

nada:~/soft/kernel# hdparm -tT /dev/sda

/dev/sda:
 Timing buffer-cache reads:   844 MB in  2.01 seconds = 419.96 MB/sec
 Timing buffered disk reads:  174 MB in  3.01 seconds =  57.84 MB/sec
nada:~/soft/kernel# hdparm -tT /dev/md0

/dev/md0:
 Timing buffer-cache reads:   884 MB in  2.00 seconds = 441.63 MB/sec
 Timing buffered disk reads:  310 MB in  3.01 seconds = 103.07 MB/sec

The real goal is to build a raid5 system, but I just tested with raid1.

Any ideas/suggestions ?

TIA

More info:

nada:~/soft/kernel# mdadm --detail /dev/md0
/dev/md0:
        Version : 00.90.01
  Creation Time : Fri Sep  3 01:52:22 2004
     Raid Level : raid0
     Array Size : 1470669312 (1402.54 GiB 1505.97 GB)
   Raid Devices : 6
  Total Devices : 6
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Fri Sep  3 01:52:22 2004
          State : clean
 Active Devices : 6
Working Devices : 6
 Failed Devices : 0
  Spare Devices : 0

     Chunk Size : 128K

           UUID : c7373f10:3d04436b:a7d2bbce:8317b56f
         Events : 0.14

    Number   Major   Minor   RaidDevice State
       0       8        1        0      active sync   /dev/sda1
       1       8       17        1      active sync   /dev/sdb1
       2       8       33        2      active sync   /dev/sdc1
       3       8       49        3      active sync   /dev/sdd1
       4       8       65        4      active sync   /dev/sde1
       5       8       81        5      active sync   /dev/sdf1

nada:~/soft/kernel# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266] (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:07.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 RAID bus controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 62)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Beta 1) for i586
Linux 2.6.8.1-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #8


