Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTLWQQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLWQQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:16:49 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:16857 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261974AbTLWQQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:16:37 -0500
Date: Tue, 23 Dec 2003 08:16:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: builderbert@snet.net
Subject: [Bug 1736] New: 2.6.0 raid Qlogic 1020 raid1 bio too	big device sdb1 (128 > 64)
Message-ID: <109310000.1072196189@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1736

           Summary: 2.6.0 raid Qlogic 1020 raid1 bio too big device sdb1
                    (128 > 64)
    Kernel Version: 2.6.0
            Status: NEW
          Severity: normal
             Owner: io_md@kernel-bugs.osdl.org
         Submitter: builderbert@snet.net


Distribution: Debian 3.0 stable

Hardware Environment:
Pentium Pro 200
QLogic ISP 1020 SCSI
Seagate MAE3043LP 4 gig scsi

Software Environment:
raidtools2 0.90

Problem Description:

Making a raid1 array under 2.6.0 will produce a bio too big device sdb1 (128 >
64) error.

I am playing with a raid1 array on this rather old (but rather stable) box.
Using this raidtab,

raiddev /dev/md0
        raid-level      1
        nr-raid-disks   2
        nr-spare-disks  0
        chunk-size     2
        persistent-superblock 1
        device          /dev/sdb1
        raid-disk       0
        device          /dev/sdc1
        raid-disk       1

upon booting after doing a mkraid /dev/md0 in 2.4, the following was found in 
/var/log/messages:

Dec 23 09:53:12 debian kernel: md: Autodetecting RAID arrays.
Dec 23 09:53:12 debian kernel: md: autorun ...
Dec 23 09:53:12 debian kernel: md: considering sdc1 ...
Dec 23 09:53:12 debian kernel: md:  adding sdc1 ...
Dec 23 09:53:12 debian kernel: md:  adding sdb1 ...
Dec 23 09:53:12 debian kernel: md: created md0
Dec 23 09:53:12 debian kernel: md: bind<sdb1>
Dec 23 09:53:12 debian kernel: md: bind<sdc1>
Dec 23 09:53:12 debian kernel: md: running: <sdc1><sdb1>
Dec 23 09:53:12 debian kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Dec 23 09:53:12 debian kernel: md: ... autorun DONE.
Dec 23 09:53:12 debian kernel: md: syncing RAID array md0
Dec 23 09:53:12 debian kernel: md: minimum _guaranteed_ reconstruction speed:
1000 KB/sec/disc.
Dec 23 09:53:12 debian kernel: md: using maximum available idle IO bandwith (but
not more than 200000 KB/sec) for reconstruct\
ion.
Dec 23 09:53:12 debian kernel: md: using 128k window, over a total of 4192832
blocks.
Dec 23 09:53:12 debian kernel: bio too big device sdb1 (128 > 64)
Dec 23 09:53:12 debian kernel: ^IOperation continuing on 1 devices
Dec 23 09:53:12 debian kernel: bio too big device sdc1 (128 > 64)
Dec 23 09:53:12 debian kernel: md: md0: sync done.
Dec 23 09:53:12 debian kernel:  printing eip:
Dec 23 09:53:12 debian kernel: c0167c54
Dec 23 09:53:12 debian kernel: Oops: 0000 [#1]
Dec 23 09:53:12 debian kernel: CPU:    0
Dec 23 09:53:12 debian kernel: EIP:    0060:[bdevname+4/36]    Not tainted
Dec 23 09:53:12 debian kernel: EFLAGS: 00010256
Dec 23 09:53:12 debian kernel: EIP is at bdevname+0x4/0x24
Dec 23 09:53:12 debian kernel: eax: 00000000   ebx: c7cfac80   ecx: c114d8c0  
edx: 00000000
Dec 23 09:53:12 debian kernel: esi: c114d8c0   edi: c7cfac80   ebp: c02ad5a4  
esp: c7e41f24
Dec 23 09:53:12 debian kernel: ds: 007b   es: 007b   ss: 0068
Dec 23 09:53:12 debian kernel: Process md0_raid1 (pid: 11, threadinfo=c7e40000
task=c7e43940)
Dec 23 09:53:12 debian kernel: Stack: c01d45ca 00000000 c7e41f60 00000000
00000000 c7e8ac80 c114d8c0 c7cfac80
Dec 23 09:53:12 debian kernel:        c02ad5a4 c7e43310 c7e41f70 c0114828
c114d8c0 00000002 c7e87100 c7e43330
Dec 23 09:53:12 debian kernel:        c01da73b c7e8ac80 c7e8ac80 c7e7a6c0
c7e7a6c8 c7e8ac80 c7e7a6c0 c01d492d
Dec 23 09:53:12 debian kernel: Call Trace:
Dec 23 09:53:12 debian kernel:  [sync_request_write+74/828]
sync_request_write+0x4a/0x33c
Dec 23 09:53:12 debian kernel:  [recalc_task_prio+320/336]
recalc_task_prio+0x140/0x150
Dec 23 09:53:12 debian kernel:  [md_check_recovery+103/564]
md_check_recovery+0x67/0x234
Dec 23 09:53:12 debian kernel:  [raid1d+113/288] raid1d+0x71/0x120
Dec 23 09:53:12 debian kernel:  [md_thread+232/296] md_thread+0xe8/0x128
Dec 23 09:53:12 debian kernel:  [md_thread+0/296] md_thread+0x0/0x128
Dec 23 09:53:12 debian kernel:  [default_wake_function+0/28]
default_wake_function+0x0/0x1c

After recreating the partitions in fdisk, a mkraid /dev/md0 will produce the
'bio too big device sdc1 (128 > 64)' error, and the disk sync process will stall.


