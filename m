Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266675AbUBFIBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 03:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUBFIBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 03:01:19 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:34209 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S266675AbUBFIBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 03:01:15 -0500
Date: Fri, 6 Feb 2004 10:01:12 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
Subject: raid5 + 2.6.2 [kernel BUG at drivers/md/raid5.c:1202!] (fwd)
Message-ID: <Pine.LNX.4.58.0402061000540.753@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I build a raid5 array on 4 loop devices (associated with 4 files):
3 + 1 spare.

drivers/md/raid5.c:
1021			if (uptodate != disks)
1202				BUG();


I started the array ok.
I mounted the reiserfs filesystem fine.
I then ran: mdadm -f /dev/md0 /dev/loop5 to test a failing device.
When it tried to resynced (dmesg follows):

raid5: Disk failure on loop5, disabling device. Operation continuing on 2 devices
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, o:1, dev:loop4
 disk 1, o:0, dev:loop5
 disk 2, o:1, dev:loop6
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, o:1, dev:loop4
 disk 2, o:1, dev:loop6
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, o:1, dev:loop4
 disk 1, o:1, dev:loop7
 disk 2, o:1, dev:loop6
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 200000
KB/sec) for reconstruction.
md: using 128k window, over a total of 51136 blocks.
kernel BUG at drivers/md/raid5.c:1202!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0265736>]    Tainted: P
EFLAGS: 00010297
EIP is at handle_stripe+0xa06/0xd70
eax: 00000001   ebx: 00000001   ecx: 00000003   edx: c7a7bb78
esi: 00000000   edi: 00000001   ebp: ffffffff   esp: cad1fe38
ds: 007b   es: 007b   ss: 0068
Process md0_resync (pid: 1490, threadinfo=cad1e000 task=ca348cc0)
Stack: c011b8a7 cb73f2a0 cad1fe64 c011b6de cb73f2a0 072ce23c cfcc6240 ca348cc0
       00000002 c0263b80 cf124e40 00000010 00000046 cb73f2a0 cad1e000 000017e1
       00000001 00000001 00000000 00000000 00000001 00000000 00000000 00000002
Call Trace:
 [<c011b8a7>] try_to_wake_up+0xa7/0x160
 [<c011b6de>] recalc_task_prio+0x8e/0x1b0
 [<c0263b80>] get_active_stripe+0x30/0x2a0
 [<c0265deb>] sync_request+0xcb/0x110
 [<c0272fac>] md_do_sync+0x1ec/0x760
 [<c0170aff>] iput+0x3f/0x80
 [<c016d9e2>] dput+0x22/0x210
 [<c0271f46>] md_thread+0xb6/0x190
 [<c011c7a0>] default_wake_function+0x0/0x20
 [<c0271e90>] md_thread+0x0/0x190
 [<c0107289>] kernel_thread_helper+0x5/0xc

Thank you very much!
---
Catalin(ux) BOIE
catab@deuroconsult.ro
