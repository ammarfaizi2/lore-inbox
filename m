Return-Path: <linux-kernel-owner+w=401wt.eu-S965506AbWLPU71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965506AbWLPU71 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965507AbWLPU71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:59:27 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:41816 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965506AbWLPU70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:59:26 -0500
Subject: OOPS: 2.6.20-rc1 in __find_get_block()
From: Ben Collins <ben.collins@ubuntu.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Daniel Holbach <daniel.holbach@ubuntu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 16 Dec 2006 15:59:20 -0500
Message-Id: <1166302760.6748.482.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This occurred on a X40 (amd64 running x86 kernel) after a few minutes of
uptime. Cc'd Daniel, since he originally reported the bug.

Kernel is SMP, voluntary-preempt.

[  287.328000] invalid opcode: 0000 [#1]
[  287.328000] SMP 
[  287.328000] CPU:    0
[  287.328000] EIP:    0060:[__find_get_block+376/400]    Not tainted VLI
[  287.328000] EFLAGS: 00010046   (2.6.20-1-generic #3)
[  287.328000] EIP is at __find_get_block+0x178/0x190
[  287.328000] eax: 00000096   ebx: 00001000   ecx: 00001000   edx: 00520050
[  287.328000] esi: 000000a4   edi: 00520050   ebp: df8c6900   esp: f1f15c78
[  287.328000] ds: 007b   es: 007b   ss: 0068
[  287.328000] Process gcalctool (pid: 5411, ti=f1f14000 task=f2127560 task.ti=f1f14000)
[  287.328000] Stack: 00520050 00000000 00000001 00000001 00000000 00000002 00000000 000280d2 
[  287.328000]        c03e2c2c 00000246 00000040 00001000 000000a4 00520050 dfdc0a00 c01957b3 
[  287.328000]        00001000 00000000 c015ae7f 00000044 00000010 00520050 00000000 df8c6900 
[  287.328000] Call Trace:
[  287.328000]  [__getblk+35/688] __getblk+0x23/0x2b0
[  287.328000]  [pg0+944672526/1068770304] __ext3_get_inode_loc+0x11e/0x340 [ext3]
[  287.328000]  [pg0+944673143/1068770304] ext3_reserve_inode_write+0x27/0x80 [ext3]
[  287.328000]  [pg0+944673267/1068770304] ext3_mark_inode_dirty+0x23/0x50 [ext3]
[  287.328000]  [pg0+944685961/1068770304] ext3_dirty_inode+0x79/0x90 [ext3]
[  287.328000]  [__mark_inode_dirty+52/400] __mark_inode_dirty+0x34/0x190
[  287.328000]  [__link_path_walk+3074/3696] __link_path_walk+0xc02/0xe70
[  287.328000]  [link_path_walk+69/192] link_path_walk+0x45/0xc0
[  287.328000]  [do_path_lookup+131/448] do_path_lookup+0x83/0x1c0
[  287.328000]  [__path_lookup_intent_open+81/160] __path_lookup_intent_open+0x51/0xa0
[  287.328000]  [path_lookup_open+32/48] path_lookup_open+0x20/0x30
[  287.328000]  [open_namei+90/1536] open_namei+0x5a/0x600
[  287.328000]  [do_filp_open+51/96] do_filp_open+0x33/0x60
[  287.328000]  [do_sys_open+78/240] do_sys_open+0x4e/0xf0
[  287.328000]  [sys_open+28/32] sys_open+0x1c/0x20
[  287.328000]  [syscall_call+7/11] syscall_call+0x7/0xb
[  287.328000]  [phys_startup_32+-1209614444/-1073741824] 0xb7f6bf94
[  287.328000]  =======================
[  287.328000] Code: 24 08 e8 ac f4 ff ff e9 20 ff ff ff 89 d8 e8 a0 f4 ff ff eb 8b 89 d6 8d 56 ff 8b 04 97 85 d2 89 04 b7 75 f1 89 1f e9 f0 fe ff ff <0f> 0b eb fe 0f 0b eb fe 0f 0b eb fe 8d b6 00 00 00 00 8d bf 00 
[  287.328000] EIP: [__find_get_block+376/400] __find_get_block+0x178/0x190 SS:ESP 0068:f1f15c78

