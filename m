Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSJKK6W>; Fri, 11 Oct 2002 06:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSJKK6W>; Fri, 11 Oct 2002 06:58:22 -0400
Received: from pizza.arcologie.net ([62.146.77.10]:55765 "EHLO
	pizza.arcologie.net") by vger.kernel.org with ESMTP
	id <S262395AbSJKK6U>; Fri, 11 Oct 2002 06:58:20 -0400
Subject: Software-Raid: mark non-fresh disk as clean?
From: Falk Brockerhoff <falk@brockerhoff.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Oct 2002 13:08:42 +0200
Message-Id: <1034334523.2361.15.camel@fairlight>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i have a problem with my raid-array. I hope I'm at the right place (here
in this list) and that you can help me.

I've a simple question: how can I mark the "non-fresh" disks /dev/hde1
and /dev/hdg1 as "clean"? I didn't found anything at the web or in the
list archive. I'm using kernel 2.4.18 with builtin software-raid
support.

Regards,

Falk

/etc/raidtab
raiddev /dev/md0
        raid-level              5
        nr-raid-disks           4
        persistent-superblock   1
        parity-algorithm        left-symmetric
        chunk-size              8

        device                  /dev/hde1
        raid-disk               0
        device                  /dev/hdg1
        raid-disk               1
        device                  /dev/hdi1
        raid-disk               2
        device                  /dev/hdk1
        raid-disk               3

/proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5] [multipath] 
read_ahead not set
unused devices: <none>

/var/log/syslog:
Oct 11 11:15:10 storage kernel:  [events: 00000010]
Oct 11 11:15:10 storage kernel:  [events: 0000000c]
Oct 11 11:15:10 storage kernel:  [events: 0000001f]
Oct 11 11:15:10 storage kernel:  [events: 0000001f]
Oct 11 11:15:10 storage kernel: md: autorun ...
Oct 11 11:15:10 storage kernel: md: considering hdk1 ...
Oct 11 11:15:10 storage kernel: md:  adding hdk1 ...
Oct 11 11:15:10 storage kernel: md:  adding hdi1 ...
Oct 11 11:15:10 storage kernel: md:  adding hdg1 ...
Oct 11 11:15:10 storage kernel: md:  adding hde1 ...
Oct 11 11:15:10 storage kernel: md: created md0
Oct 11 11:15:10 storage kernel: md: bind<hde1,1>
Oct 11 11:15:10 storage kernel: md: bind<hdg1,2>
Oct 11 11:15:10 storage kernel: md: bind<hdi1,3>
Oct 11 11:15:10 storage kernel: md: bind<hdk1,4>
Oct 11 11:15:10 storage kernel: md: running: <hdk1><hdi1><hdg1><hde1>
Oct 11 11:15:10 storage kernel: md: hdk1's event counter: 0000001f
Oct 11 11:15:10 storage kernel: md: hdi1's event counter: 0000001f
Oct 11 11:15:10 storage kernel: md: hdg1's event counter: 0000000c
Oct 11 11:15:10 storage kernel: md: hde1's event counter: 00000010
Oct 11 11:15:10 storage kernel: md: superblock update time inconsistency
-- using the most recent one
Oct 11 11:15:10 storage kernel: md: freshest: hdk1
Oct 11 11:15:10 storage kernel: md: kicking non-fresh hdg1 from array!
Oct 11 11:15:10 storage kernel: md: unbind<hdg1,3>
Oct 11 11:15:10 storage kernel: md: export_rdev(hdg1)
Oct 11 11:15:10 storage kernel: md: kicking non-fresh hde1 from array!
Oct 11 11:15:10 storage kernel: md: unbind<hde1,2>
Oct 11 11:15:10 storage kernel: md: export_rdev(hde1)
Oct 11 11:15:10 storage kernel: md0: removing former faulty hde1!
Oct 11 11:15:10 storage kernel: md0: former device hdg1 is unavailable,
removing from array!
Oct 11 11:15:10 storage kernel: md0: max total readahead window set to
744k
Oct 11 11:15:10 storage kernel: md0: 3 data-disks, max readahead per
data-disk: 248k
Oct 11 11:15:10 storage kernel: raid5: device hdk1 operational as raid
disk 3
Oct 11 11:15:10 storage kernel: raid5: device hdi1 operational as raid
disk 2
Oct 11 11:15:10 storage kernel: raid5: not enough operational devices
for md0 (2/4 failed)
Oct 11 11:15:10 storage kernel: RAID5 conf printout:
Oct 11 11:15:10 storage kernel:  --- rd:4 wd:2 fd:2
Oct 11 11:15:10 storage kernel:  disk 0, s:0, o:0, n:0 rd:0 us:1
dev:[dev 00:00]
Oct 11 11:15:10 storage kernel:  disk 1, s:0, o:0, n:1 rd:1 us:1
dev:[dev 00:00]
Oct 11 11:15:10 storage kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1
dev:hdi1
Oct 11 11:15:10 storage kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1
dev:hdk1
Oct 11 11:15:10 storage kernel: raid5: failed to run raid set md0
Oct 11 11:15:10 storage kernel: md: pers->run() failed ...
Oct 11 11:15:10 storage kernel: md :do_md_run() returned -22
Oct 11 11:15:10 storage kernel: md: md0 stopped.
Oct 11 11:15:10 storage kernel: md: unbind<hdk1,1>
Oct 11 11:15:10 storage kernel: md: export_rdev(hdk1)
Oct 11 11:15:10 storage kernel: md: unbind<hdi1,0>
Oct 11 11:15:10 storage kernel: md: export_rdev(hdi1)
Oct 11 11:15:10 storage kernel: md: ... autorun DONE.


