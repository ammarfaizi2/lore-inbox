Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264782AbSJVRMJ>; Tue, 22 Oct 2002 13:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264783AbSJVRMJ>; Tue, 22 Oct 2002 13:12:09 -0400
Received: from mail104.mail.bellsouth.net ([205.152.58.44]:6585 "EHLO
	imf04bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S264782AbSJVRMH>; Tue, 22 Oct 2002 13:12:07 -0400
Date: Tue, 22 Oct 2002 13:18:09 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: [2.5.44] poisoned oops in VM when unmounting ramfs
Message-ID: <Pine.LNX.4.43.0210221257360.2047-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this oops on a 2.5.44 system (single CPU, preempt enabled, as was
slab debugging) when unmounting a full ramfs partition.

This is 100% reproduceable for me; mount ramfs, run dbench in that mount
point, the system will run out of ram as dbench fills up the ramfs
partition, and kernel will OOM kill dbench and your shell. Login again,
and unmount the ramfs partition, oops.


VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice
day...
Unable to handle kernel paging request at virtual address 5a5a5a6e
 printing eip:
c014afa0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c014afa0>]    Not tainted
EFLAGS: 00010206
EIP is at iput+0x24/0x68
eax: 5a5a5a5a   ebx: c97fa67c   ecx: c137c000   edx: c137dd68
esi: c10c3258   edi: c137de18   ebp: c97fa700   esp: c137ddb4
ds: 0068   es: 0068   ss: 0068
Process kswapd0 (pid: 5, threadinfo=c137c000 task=c13d38c0)
Stack: c97fa67c c01332f4 c97fa67c c97fa700 c137de00 c137c000 c10c3258 c012a108
       c10c3258 c137de00 c137de98 c137c000 c1177690 c033b75c 00000001 00000000
       00000000 c1146b98 c115ce98 00000000 00000000 00000000 00000000 00000000
Call Trace:
 [<c01332f4>] generic_vm_writeback+0x38/0x40
 [<c012a108>] shrink_list+0x23c/0x448
 [<c0129a8d>] __pagevec_release+0x11/0x1c
 [<c012a953>] refill_inactive_zone+0x363/0x4ec
 [<c0129a8d>] __pagevec_release+0x11/0x1c
 [<c012a4c2>] shrink_cache+0x1ae/0x2dc
 [<c012ab48>] shrink_zone+0x6c/0x74
 [<c012ad4e>] balance_pgdat+0x8e/0xec
 [<c012aea7>] kswapd+0xfb/0x105
 [<c012adac>] kswapd+0x0/0x105
 [<c0110c04>] autoremove_wake_function+0x0/0x38
 [<c0110c04>] autoremove_wake_function+0x0/0x38
 [<c0105499>] kernel_thread_helper+0x5/0xc

Code: 8b 40 14 85 c0 74 06 53 ff d0 83 c4 04 68 b0 c6 33 c0 8d 43

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461



