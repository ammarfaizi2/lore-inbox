Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUE3CBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUE3CBT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 22:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUE3CBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 22:01:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:45228 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261551AbUE3CBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 22:01:18 -0400
Subject: Ooops in 2.6.7-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085882129.2248.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 30 May 2004 11:55:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My laptop just got that (bk clone updated yesterday). 2.6.6-rc1 was stable over
3 weeks on this same box. It's a NULL dereference (DAR = 0)

May 30 11:35:27 gaston kernel: Oops: kernel access of bad area, sig: 11 [#1]
May 30 11:35:27 gaston kernel: NIP: C0046FBC LR: C00470D0 SP: ED6BFCA0 REGS: ed6bfbf0 TRAP: 0300    Not tainted
May 30 11:35:27 gaston kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
May 30 11:35:27 gaston kernel: DAR: 00000000, DSISR: 42000000
May 30 11:35:27 gaston kernel: TASK = ef5fa030[1589] 'XFree86' THREAD: ed6be000Last syscall: 3
May 30 11:35:27 gaston kernel: GPR00: 0000000C ED6BFCA0 EF5FA030 C060F9A0 EFB6E77C E949DE5C E949DE74 00200200
May 30 11:35:27 gaston kernel: GPR08: 00100100 D3F40A9C 00000000 C8FDA000 ED6BFEAC 101E2FE8 101E0000 101E0000
May 30 11:35:27 gaston kernel: GPR16: 00000001 00000001 FFFFFFA1 DEFD4620 00000000 00000000 CDE3B3A4 00000040
May 30 11:35:27 gaston kernel: GPR24: CDE3B494 C060F9BC C0390000 EFFF70C0 0000000C C060F9AC 00000003 C060F9A0
May 30 11:35:27 gaston kernel: NIP [c0046fbc] free_block+0x78/0x134
May 30 11:35:27 gaston kernel: LR [c00470d0] cache_flusharray+0x58/0xb0
May 30 11:35:27 gaston kernel: Call trace:
May 30 11:35:27 gaston kernel:  [c00470d0] cache_flusharray+0x58/0xb0
May 30 11:35:27 gaston kernel:  [c0047628] kfree+0x88/0xa4
May 30 11:35:27 gaston kernel:  [c01e78e0] skb_release_data+0xd4/0xfc
May 30 11:35:27 gaston kernel:  [c01e7920] kfree_skbmem+0x18/0x3c
May 30 11:35:27 gaston kernel:  [c01e79f8] __kfree_skb+0xb4/0x12c
May 30 11:35:27 gaston kernel:  [c023a2e4] unix_stream_recvmsg+0x218/0x48c
May 30 11:35:27 gaston kernel:  [c01e3da4] sock_aio_read+0xcc/0xe0
May 30 11:35:27 gaston kernel:  [c005cad4] do_sync_read+0x78/0xbc
May 30 11:35:27 gaston kernel:  [c005cc28] vfs_read+0x110/0x128
May 30 11:35:27 gaston kernel:  [c005ce64] sys_read+0x40/0x74
May 30 11:35:27 gaston kernel:  [c0007c90] ret_from_syscall+0x0/0x4c

I can look more in details later if it's not an already known problem

Ben.


