Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTJMAtl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 20:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTJMAtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 20:49:41 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:27612 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261270AbTJMAtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 20:49:39 -0400
Date: Mon, 13 Oct 2003 01:49:36 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test6] kernel BUG at mm/filemap.c:320!
Message-ID: <Pine.HPX.4.58L.0310130059150.27943@punch.eng.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This following bug was triggered by running rpm - it printed the list of
failed dependencies for my install command, but never returned to the
shell prompt.

The kernel is 2.6.0-test6 with the evms 2.1.1 patches applied
(md-multipath.patch, bd_claim.patch). The kernel thread that died is for a
RAID5 array made from partitions of 4 IDE disks. This array is divided to
several chunks for ext2 and reiserfs filesystems. The machine on which
this runs is a 2-way SMP box.

The machine is still alive, and I can log into it provided I don't touch
any filesystems on md1. If there are useful experiments that I can do
before rebooting, let me know.

ksymoops 2.4.9 on i686 2.4.20-20.8.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

kernel BUG at mm/filemap.c:320!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<c013dedf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c1340878   ecx: 00000017   edx: c15012dc
esi: 00000001   edi: dffc33a0   ebp: 00000001   esp: c1743ef0
ds: 007b   es: 007b   ss: 0068
Stack: c1340878 c3531960 c017c66f dfa28000 dffc33a0 dffc33a0 c044de60 00000000
       c02bc7fe dffc33a0 00000000 00000000 01625378 dfd9e400 dfdc8160 00000001
       dfad3284 d20ecd50 c03fba00 dab4b3a0 dfe160a0 dffcbe64 dffcbe60 00000000
Call Trace:
 [<c017c66f>] mpage_end_io_read+0x5f/0x80
 [<c02bc7fe>] handle_stripe+0x7fe/0xdd0
 [<c02bd183>] raid5d+0x73/0x110
 [<c02c4a3c>] md_thread+0xcc/0x1a0
 [<c01205c0>] default_wake_function+0x0/0x30
 [<c02c4970>] md_thread+0x0/0x1a0
 [<c01092e9>] kernel_thread_helper+0x5/0xc
Code: 0f 0b 40 01 de 65 36 c0 8d 42 04 39 42 04 75 08 8b 5c 24 04


>>EIP; c013dedf <unlock_page+1f/50>   <=====

>>ebx; c1340878 <__crc___neigh_event_send+21336/10f52f>
>>edx; c15012dc <__crc_xfrm_policy_register_afinfo+d286b/412b13>
>>edi; dffc33a0 <__crc_journal_unlock_updates+2789c4/6e926b>
>>esp; c1743ef0 <__crc_xfrm_policy_register_afinfo+31547f/412b13>

Trace; c017c66f <mpage_end_io_read+5f/80>
Trace; c02bc7fe <handle_stripe+7fe/dd0>
Trace; c02bd183 <raid5d+73/110>
Trace; c02c4a3c <md_thread+cc/1a0>
Trace; c01205c0 <default_wake_function+0/30>
Trace; c02c4970 <md_thread+0/1a0>
Trace; c01092e9 <kernel_thread_helper+5/c>

Code;  c013dedf <unlock_page+1f/50>
00000000 <_EIP>:
Code;  c013dedf <unlock_page+1f/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013dee1 <unlock_page+21/50>
   2:   40                        inc    %eax
Code;  c013dee2 <unlock_page+22/50>
   3:   01 de                     add    %ebx,%esi
Code;  c013dee4 <unlock_page+24/50>
   5:   65 36 c0 8d 42 04 39      rorb   $0x4,%ss:%gs:0x42390442(%ebp)
Code;  c013deeb <unlock_page+2b/50>
   c:   42 04
Code;  c013deed <unlock_page+2d/50>
   e:   75 08                     jne    18 <_EIP+0x18>
Code;  c013deef <unlock_page+2f/50>
  10:   8b 5c 24 04               mov    0x4(%esp,1),%ebx

Peter
