Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbUJZWSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUJZWSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 18:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUJZWSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 18:18:51 -0400
Received: from smtp07.auna.com ([62.81.186.17]:15312 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261507AbUJZWR7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 18:17:59 -0400
Date: Tue, 26 Oct 2004 22:17:55 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: RAID0: WrongLevel ?
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1098829075l.6518l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have a RAID0 setup on top of three IDE drives. mdadm monitor sends me
mesages with:

DeviceDisappeared
/dev/md0
Wrong-Level

The RAID seems to be working well. Any pointer on what does this mean ?

Boot info:

md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdd1 ...
md:  adding hdd1 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md0
md: bind<hda1>
md: bind<hdc1>
md: bind<hdd1>
md: running: <hdd1><hdc1><hda1>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdd1
raid0:   comparing hdd1(117218176) with hdd1(117218176)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdc1
raid0:   comparing hdc1(117218176) with hdd1(117218176)
raid0:   EQUAL
raid0: looking at hda1
raid0:   comparing hda1(245111616) with hdd1(117218176)
raid0:   NOT EQUAL
raid0:   comparing hda1(245111616) with hdc1(117218176)
raid0:   NOT EQUAL
raid0:   comparing hda1(245111616) with hda1(245111616)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking hda1 ... contained as device 0
  (245111616) is smallest!.
raid0: checking hdc1 ... nope.
raid0: checking hdd1 ... nope.
raid0: zone->nb_dev: 1, size: 127893440
raid0: current zone offset: 245111616
raid0: done.
raid0 : md_size is 479547968 blocks.
raid0 : conf->hash_spacing is 351654528 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.


Runtime info:

annwn:~# cat /proc/partitions
major minor  #blocks  name

   3     0  245117376 hda
   3     1  245111706 hda1
  22     0  117220824 hdc
  22     1  117218241 hdc1
  22    64  117220824 hdd
  22    65  117218241 hdd1

annwn:~# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5] [multipath] [raid6] 
md0 : active raid0 hdd1[2] hdc1[1] hda1[0]
      479547968 blocks 64k chunks
      
unused devices: <none>

annwn:~# mdadm -D /dev/md0
/dev/md0:
        Version : 00.90.01
  Creation Time : Mon Sep 13 17:57:08 2004
     Raid Level : raid0
     Array Size : 479547968 (457.33 GiB 491.06 GB)
   Raid Devices : 3
  Total Devices : 3
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Mon Sep 13 17:57:08 2004
          State : clean
 Active Devices : 3
Working Devices : 3
 Failed Devices : 0
  Spare Devices : 0

     Chunk Size : 64K

           UUID : c7c5ec26:ae5a99f9:49fec7a1:7e0dcc69
         Events : 0.12

    Number   Major   Minor   RaidDevice State
       0       3        1        0      active sync   /dev/hda1
       1      22        1        1      active sync   /dev/hdc1
       2      22       65        2      active sync   /dev/hdd1

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #4


