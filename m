Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbULSB3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbULSB3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 20:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbULSB3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 20:29:12 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:1678 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261249AbULSB3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 20:29:05 -0500
Date: Sat, 18 Dec 2004 20:28:40 -0500 (EST)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: [BUG] XFS crash using Realtime Preemption patch
Message-ID: <Pine.LNX.4.60-041.0412182025220.5487@unix49.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

Using 2.6.10-rc3-mm1-V0.7.33-04 and TCFQ ver 17, I get the following crash 
while trying to sync the portage tree, though the system seems stable 
under interactive load (read: an rm command went OK prior to this crash).

Machine is a 933MHz transmeta laptop with IDE disk.

Any more information you need?
--nwf;

kernel BUG at kernel/rt.c:1210!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: hostap_pci hostap uhci_hcd rtc eth1394 ohci1394 
ieee1394 pcmc
ia 8139too mii yenta_socket pcmcia_core belkin_sa usbserial ehci_hcd 
i2c_core oh
ci_hcd usbcore tun crc32
CPU:    0
EIP:    0060:[<c01308ac>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-rc3-mm1-V0.7.33-04-tcfq17)
EIP is at up_write+0x8c/0xa0
eax: 00000019   ebx: c5693284   ecx: 00000000   edx: 00000000
esi: c56931f4   edi: c5ba8814   ebp: 00000000   esp: ce003d1c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process emerge (pid: 19312, threadinfo=ce003000 task=ce7ff470)
Stack: c0357cdb c035a116 000004ba 00000000 ce003000 d47c64b0 00000008 
c01d2d5c
        c56931f4 d47c64b0 c01d728c ce003d68 ce003d6c 00000000 00000000 
d6c3c96c
        00000000 d6c3cc00 00000002 c4eb7000 cb02e5e0 c5ba8814 cf67511c 
d6c3cc00
Call Trace:
  [<c01d2d5c>] xfs_iunlock+0x7c/0xa0 (32)
  [<c01d728c>] xfs_iflush+0x1cc/0x440 (12)
  [<c01d85a0>] xfs_inode_item_push+0x10/0x20 (60)
  [<c01ebd0a>] xfs_trans_push_ail+0x1aa/0x1e0 (8)
  [<c01ddadd>] xlog_grant_push_ail+0x14d/0x180 (68)
  [<c01dc9fc>] xfs_log_reserve+0x9c/0xc0 (60)
  [<c01f7569>] kmem_zone_alloc+0x39/0xa0 (8)
  [<c01ea89a>] xfs_trans_reserve+0x8a/0x1e0 (20)
  [<c01d56f6>] xfs_itruncate_finish+0x1a6/0x390 (40)
  [<c01ecd6b>] xfs_trans_ijoin+0x2b/0x80 (96)
  [<c01f266a>] xfs_inactive+0x3ea/0x4c0 (20)
  [<c0144f30>] truncate_inode_pages_range+0x100/0x350 (20)
  [<c02023e0>] vn_rele+0x50/0xe0 (24)
  [<c0202467>] vn_rele+0xd7/0xe0 (24)
  [<c017154a>] dput+0x8a/0x2a0 (4)
  [<c0200bbf>] linvfs_clear_inode+0xf/0x20 (20)
  [<c01738d8>] clear_inode+0x158/0x160 (8)
  [<c0145197>] truncate_inode_pages+0x17/0x20 (12)
  [<c017483f>] generic_delete_inode+0xef/0x110 (12)
  [<c013100a>] atomic_dec_and_spin_lock+0x1a/0x70 (8)
  [<c01749f7>] iput+0x57/0x90 (16)
  [<c016a5a1>] sys_unlink+0xc1/0x120 (24)
  [<c0102fb3>] syscall_call+0x7/0xb (84)
Code: 08 e8 d9 a7 fe ff e8 b4 34 fd ff eb a6 c7 04 24 db 7c 35 c0 b8 ba 04 
00 00
  89 44 24 08 b8 16 a1 35 c0 89 44 24 04 e8 b4 a7 fe ff <0f> 0b ba 04 16 a1 
35 c0
  eb 85 8d 76 00 8d bc 27 00 00 00 00 83
