Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWAKPNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWAKPNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWAKPNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:13:12 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:19944 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932212AbWAKPNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:13:11 -0500
Date: Wed, 11 Jan 2006 16:13:08 +0100
From: Sander <sander@humilis.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.15-mm2: Kernel BUG at fs/sysfs/symlink.c:87
Message-ID: <20060111151308.GA30047@favonius>
Reply-To: sander@humilis.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Uptime: 15:54:25 up 55 days,  5:16, 30 users,  load average: 4.33, 4.27, 4.02
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got the following when I tried to create raid1 over nine sata disks.
One on onboard NVidia and eight on a Promise SX8.

Both the motherboard (Tyan K8SE) and the Promise SX8 are flashed with
the latest bios, FWIW.

NCQ is disabled in the Promise controller (although the current firmware
should be able to handle it).

OS is up to date Debian Sid in an initramfs which I use to install the
system.

Please let me know if this is of any use, if so, whom I should contact,
and if more info is needed.

Btw, this system is fresh out of the box, so hardware can be a problem
too.

I'll try plain 2.6.15 now.

	Kind regards, Sander

PS, I had to create the /dev/sx8 directory and the nodes (0, 1, 0p1,
1p1, etc) for the disks and partitions by hand (mknod). Is there a more
easy way? It seems MAKEDEV in Debian Sid doesn't know how to. Do I miss
something? (likely, but I did my google homework ;-)


[ 1059.591796] Kernel BUG at fs/sysfs/symlink.c:87
[ 1059.591820] invalid opcode: 0000 [1] SMP
[ 1059.591845] CPU 1
[ 1059.591865] Modules linked in:
[ 1059.591888] Pid: 982, comm: mdadm Not tainted 2.6.15-mm2 #1
[ 1059.591915] RIP: 0010:[<ffffffff80191903>] <ffffffff80191903>{sysfs_create_link+37}
[ 1059.591948] RSP: 0018:ffff810138d8fbf8  EFLAGS: 00010202
[ 1059.591990] RAX: ffff810138845300 RBX: ffff81013fc74618 RCX: 0000000000000034
[ 1059.592020] RDX: ffffffff80401c01 RSI: ffff810138845350 RDI: ffff81013fc74618
[ 1059.592050] RBP: ffffffff80401ca7 R08: 000000000000000b R09: 0000000807aa308c
[ 1059.592080] R10: ffff81013fc74618 R11: fffffffffffffff3 R12: 0000000000000000
[ 1059.592111] R13: ffff810138d8fc58 R14: ffff81013af70018 R15: ffff810138845350
[ 1059.592142] FS:  00002aaaaae01ae0(0000) GS:ffffffff805c5080(0000) knlGS:0000000000000000
[ 1059.592187] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1059.592214] CR2: 00007fffffcf7dd8 CR3: 000000013828c000 CR4: 00000000000006e0
[ 1059.592244] Process mdadm (pid: 982, threadinfo ffff810138d8e000, task ffff810138cb30d0)
[ 1059.592288] Stack: 0000000000000034 ffff81013fc74618 ffff81013fc745c0 ffff81013af70000
[ 1059.592320]        ffff810138d8fc58 ffff81013af70018 ffff81013fc42a40 ffffffff8033d5cd
[ 1059.592365]        ffff810138d8fd18 0000000000000000
[ 1059.592390] Call Trace:<ffffffff8033d5cd>{bind_rdev_to_array+493} <ffffffff8033ea27>{md_ioctl+3652}
[ 1059.592440]        <ffffffff8027d86a>{blkdev_driver_ioctl+91} <ffffffff8027df81>{blkdev_ioctl+1699}
[ 1059.592492]        <ffffffff801475e9>{invalidate_mapping_pages+183} <ffffffff801198f5>{flat_send_IPI_allbutself+20}
[ 1059.592547]        <ffffffff80116ded>{__smp_call_function+101} <ffffffff80164133>{invalidate_bh_lru+0}
[ 1059.592596]        <ffffffff80168412>{block_ioctl+25} <ffffffff80171f59>{do_ioctl+33}
[ 1059.592645]        <ffffffff801721f8>{vfs_ioctl+597} <ffffffff8017224d>{sys_ioctl+60}
[ 1059.592691]        <ffffffff8010d7da>{system_call+126}
[ 1059.592733]
[ 1059.592734] Code: 0f 0b 68 73 6c 3f 80 c2 57 00 49 8b 7c 24 10 41 bd f4 ff ff
[ 1059.592811] RIP <ffffffff80191903>{sysfs_create_link+37} RSP <ffff810138d8fbf8>
[ 1059.592996]

-- 
Humilis IT Services and Solutions
http://www.humilis.net
