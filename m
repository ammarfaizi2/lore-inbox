Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTGCNWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 09:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTGCNWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 09:22:21 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:57027 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262942AbTGCNWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 09:22:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.74-mm1: kernel BUG@include/linux/list.h:148
Date: Thu, 3 Jul 2003 23:40:50 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307032340.50406.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this on bootup with devfs and preempt enabled.

------------[ cut here ]------------
kernel BUG at include/linux/list.h:148!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0114cd8>]    Not tainted VLI
EFLAGS: 00010016
EIP is at remove_wait_queue+0x1c/0x5c
eax: cf93c000   ebx: cf19be28   ecx: 00000000   edx: cf93deac
esi: cf93dea0   edi: 00000246   ebp: cf6cb180   esp: cf93de5c
ds: 007b   es: 007b   ss: 0068
Process initlog (pid: 20, threadinfo=cf93c000 task=cfcc4080)
Stack: cf19be24 cf93c000 cf93dea0 c01894de cf6cb180 cf93df4c cffef200 cf93df0c
       cf93c000 cf19be20 cffde200 cfe1d500 00000000 cfcc4080 c01138cc 00000000
       00000000 00000000 cfcc4080 c01138cc cf19be28 cf19be28 c014c048 cf6cb180
Call Trace:
 [<c01894de>] devfs_d_revalidate_wait+0x152/0x178
 [<c01138cc>] default_wake_function+0x0/0x20
 [<c01138cc>] default_wake_function+0x0/0x20
 [<c014c048>] do_lookup+0x60/0x88
 [<c014c5c9>] link_path_walk+0x559/0x7fc
 [<c014cb55>] path_lookup+0x139/0x140
 [<c014cc78>] __user_walk+0x28/0x40
 [<c01489ad>] vfs_stat+0x19/0x48
 [<c0153fd6>] dput+0x1a/0x210
 [<c0148f67>] sys_stat64+0x13/0x30
 [<c01410db>] fput+0x13/0x14
 [<c013fcdd>] filp_close+0x51/0x5c
 [<c013fd47>] sys_close+0x5f/0x88
 [<c0108dc9>] error_code+0x2d/0x38
 [<c0108c1f>] syscall_call+0x7/0xb

Code: 40 08 a8 08 74 05 e8 d0 eb ff ff 5b 5e 5f c3 57 56 53 89 d6 9c 5f fa b8 
00 e0 ff ff 21 e0 ff 40 14 8d 56 0c 8b 5a 04 39 13 74 08 <0f> 0b 94 00 20 d7 
2d c0 8b 4e 0c 39 51 04 74 08 0f 0b 95 00 20
 <6>note: initlog[20] exited with preempt_count 1

