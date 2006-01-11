Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751724AbWAKTUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbWAKTUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbWAKTUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:20:54 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:45246 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751411AbWAKTUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:20:54 -0500
Date: Wed, 11 Jan 2006 20:20:55 +0100
From: Sander <sander@humilis.net>
To: Sander <sander@humilis.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Kernel BUG at fs/sysfs/symlink.c:87 happens with 2.6.15 too
Message-ID: <20060111192055.GB19209@favonius>
Reply-To: sander@humilis.net
References: <20060111151308.GA30047@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111151308.GA30047@favonius>
X-Uptime: 16:32:28 up 55 days,  5:54, 30 users,  load average: 2.35, 3.43, 3.77
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote (ao):
# I'll try plain 2.6.15 now.

The same thing happens. I try to create a raid1 over nine disks (eight
on Promise SX8):

mdadm -C -l1 -n9 /dev/md0 /dev/sda1 /dev/sx8/0p1 /dev/sx8/1p1 /dev/sx8/2p1 /dev/sx8/3p1 /dev/sx8/4p1 /dev/sx8/5p1 /dev/sx8/6p1 /dev/sx8/7p1

It Segfaults and gives this:

Difference with 2.6.15-mm2 is that 2.6.15 keeps on running.

I'll enable some debug options now. Any advice on what I can try besides
this? Am I doing something wrong?


[ 2281.547827] md: bind<sda1>
[ 2281.547877] md: bind<sx8/0p1>
[ 2281.547902] ----------- [cut here ] --------- [please bite here ] ---------
[ 2281.547931] Kernel BUG at fs/sysfs/symlink.c:87
[ 2281.547955] invalid operand: 0000 [1] SMP
[ 2281.547980] CPU 1
[ 2281.548000] Modules linked in:
[ 2281.548023] Pid: 874, comm: mdadm Not tainted 2.6.15 #1
[ 2281.548049] RIP: 0010:[<ffffffff8018fb07>] <ffffffff8018fb07>{sysfs_create_link+37}
[ 2281.548082] RSP: 0018:ffff81013fcc7bf8  EFLAGS: 00010202
[ 2281.548123] RAX: ffff81013fc9e700 RBX: ffff81013a55add8 RCX: 0000000000000034
[ 2281.548153] RDX: ffffffff80370001 RSI: ffff81013fc9e750 RDI: ffff81013a55add8
[ 2281.548183] RBP: ffffffff80370043 R08: 000000000000000b R09: 0000000807aa308c
[ 2281.548214] R10: ffff81013a55add8 R11: ffff81013a55add8 R12: 0000000000000000
[ 2281.548244] R13: ffff81013fcc7c58 R14: ffff81013a481c18 R15: ffff81013fc9e750
[ 2281.548275] FS:  00002aaaaae01ae0(0000) GS:ffffffff804f7880(0000) knlGS:0000000000000000
[ 2281.548319] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 2281.548346] CR2: 00007fffffdd29c8 CR3: 000000013a4c8000 CR4: 00000000000006e0
[ 2281.548376] Process mdadm (pid: 874, threadinfo ffff81013fcc6000, task ffff81013b2948e0)
[ 2281.548420] Stack: 0000000000000034 ffff81013a55add8 ffff81013a55ad80 ffff81013a481c00
[ 2281.548452]        ffff81013fcc7c58 ffff81013a481c18 ffff81013fc42440 ffffffff802ba1a3
[ 2281.548499]        0000000000000000 0000808000000000
[ 2281.548524] Call Trace:<ffffffff802ba1a3>{bind_rdev_to_array+441} <ffffffff802bb2ef>{md_ioctl+3217}
[ 2281.548577]        <ffffffff801ec3ee>{blkdev_driver_ioctl+91} <ffffffff801ecae1>{blkdev_ioctl+1663}
[ 2281.548629]        <ffffffff8014914e>{pagevec_lookup+23} <ffffffff80149ceb>{invalidate_mapping_pages+188}
[ 2281.548681]        <ffffffff80119664>{flat_send_IPI_allbutself+20} <ffffffff80116c50>{__smp_call_function+101}
[ 2281.548733]        <ffffffff80161e34>{invalidate_bh_lru+0} <ffffffff80166287>{block_ioctl+25}
[ 2281.548784]        <ffffffff80170179>{do_ioctl+33} <ffffffff80170431>{vfs_ioctl+622}
[ 2281.548833]        <ffffffff80170486>{sys_ioctl+60} <ffffffff8010d6ce>{system_call+126}
[ 2281.548882]
[ 2281.548916]
[ 2281.548917] Code: 0f 0b 68 ea ae 36 80 c2 57 00 49 8b 44 24 10 48 8d b8 c0 00
[ 2281.548994] RIP <ffffffff8018fb07>{sysfs_create_link+37} RSP <ffff81013fcc7bf8>
[ 2281.549178]

 

2.6.15-mm2:
# [ 1059.591796] Kernel BUG at fs/sysfs/symlink.c:87
# [ 1059.591820] invalid opcode: 0000 [1] SMP
# [ 1059.591845] CPU 1
# [ 1059.591865] Modules linked in:
# [ 1059.591888] Pid: 982, comm: mdadm Not tainted 2.6.15-mm2 #1
# [ 1059.591915] RIP: 0010:[<ffffffff80191903>] <ffffffff80191903>{sysfs_create_link+37}
# [ 1059.591948] RSP: 0018:ffff810138d8fbf8  EFLAGS: 00010202
# [ 1059.591990] RAX: ffff810138845300 RBX: ffff81013fc74618 RCX: 0000000000000034
# [ 1059.592020] RDX: ffffffff80401c01 RSI: ffff810138845350 RDI: ffff81013fc74618
# [ 1059.592050] RBP: ffffffff80401ca7 R08: 000000000000000b R09: 0000000807aa308c
# [ 1059.592080] R10: ffff81013fc74618 R11: fffffffffffffff3 R12: 0000000000000000
# [ 1059.592111] R13: ffff810138d8fc58 R14: ffff81013af70018 R15: ffff810138845350
# [ 1059.592142] FS:  00002aaaaae01ae0(0000) GS:ffffffff805c5080(0000) knlGS:0000000000000000
# [ 1059.592187] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
# [ 1059.592214] CR2: 00007fffffcf7dd8 CR3: 000000013828c000 CR4: 00000000000006e0
# [ 1059.592244] Process mdadm (pid: 982, threadinfo ffff810138d8e000, task ffff810138cb30d0)
# [ 1059.592288] Stack: 0000000000000034 ffff81013fc74618 ffff81013fc745c0 ffff81013af70000
# [ 1059.592320]        ffff810138d8fc58 ffff81013af70018 ffff81013fc42a40 ffffffff8033d5cd
# [ 1059.592365]        ffff810138d8fd18 0000000000000000
# [ 1059.592390] Call Trace:<ffffffff8033d5cd>{bind_rdev_to_array+493} <ffffffff8033ea27>{md_ioctl+3652}
# [ 1059.592440]        <ffffffff8027d86a>{blkdev_driver_ioctl+91} <ffffffff8027df81>{blkdev_ioctl+1699}
# [ 1059.592492]        <ffffffff801475e9>{invalidate_mapping_pages+183} <ffffffff801198f5>{flat_send_IPI_allbutself+20}
# [ 1059.592547]        <ffffffff80116ded>{__smp_call_function+101} <ffffffff80164133>{invalidate_bh_lru+0}
# [ 1059.592596]        <ffffffff80168412>{block_ioctl+25} <ffffffff80171f59>{do_ioctl+33}
# [ 1059.592645]        <ffffffff801721f8>{vfs_ioctl+597} <ffffffff8017224d>{sys_ioctl+60}
# [ 1059.592691]        <ffffffff8010d7da>{system_call+126}
# [ 1059.592733]
# [ 1059.592734] Code: 0f 0b 68 73 6c 3f 80 c2 57 00 49 8b 7c 24 10 41 bd f4 ff ff
# [ 1059.592811] RIP <ffffffff80191903>{sysfs_create_link+37} RSP <ffff810138d8fbf8>
# [ 1059.592996]
