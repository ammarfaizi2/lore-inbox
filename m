Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263814AbUCPJ47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 04:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUCPJ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 04:56:59 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:64483 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S263814AbUCPJzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 04:55:09 -0500
Subject: [OOPS] Recovering ext3 - recovery.c: assertion failed, attempted
	to kill init
From: Kristian Soerensen <ks@cs.auc.dk>
To: Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079430906.19929.10.camel@homer.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 16 Mar 2004 10:55:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all :)

After (hard) power cycling a computer, running linux-2.6.3*, the
filsystem (ext3) sould be recovered at boot. However I get the following
message from the kernel. I have tried booting the redhat
kernel-2.4.20-30.9 - but with the same result.

* The kernel was patched with our Umbrella LSM module, but however _no_
changes were made to the filesystem.


Cheers,
KS.


-----------------------------------------------------------------------

Assertion failure in jread() at fs/jbd/recovery.c:140: "offset <
journal->j_maxlen"
----- [ cut here ] -----
kernel BUG at fs/jbd/recovery.c:140!
invalid operand: 0000 [#1]
CPU:	0
EIP:	0060:[<c019207c>]	Not tainted
EFLASGS: 00010286
EIP is at jread+0x114/0x121
eax: 00000057	exb: 6b6b6b2f	ecx: c0300db0	edx: 00000286
esi: df52cd80	edi: 6b6b6b2f	ebp: df721d44	esp: df721ce8
ds: 007b	es: 007b	ss: 0068
Process swapper (pid: 1, threadinfo df720000 task=df6ef900
Stack: c02d5ba0 c02c41af c02d3d49 0000008c c02d3d2e c039e5b0 6b6b6b2f
df52cd80
       df721d7c 2f6b6b6b c0192262 df721d44 df52cd80 6b6b6b2f c0117cb7
df721d44
       df721d44 00000000 00000002 00000000 00000000 00000000 c0117cb7
00000000
Call Trace:
[<c0192262>] 	do_one_pass+0x57/0x46b
[<c0117cb7>] 	autoremove_wake_function+0x0/0x4f
[<c0117cb7>] 	autoremove_wake_function+0x0/0x4f
[<c0192131>] 	journal_recover+0x60/0xc3
[<c01951c9>] 	journal_load+0x51/0x82
[<c018a414>] 	ext3_load_journal+0xd2/0x19c
[<c0189e30>] 	ext3_fill_super+0x9a9/0xb16
[<c014f9bf>] 	get_sb_bdev+0x127/0x159
[<c015f15e>] 	dput+0x22/0x21f
[<c01638c7>] 	alloc_vfsmnt+0x87/0xb6
[<c018ab83>] 	ext3_get_sb+0x2f/0x33
[<c0189487>] 	ext3_fill_super+0x0/0xb16
[<c014fc34>] 	do_kern_mount+0xa2/0x15a
[<c0164b3c>] 	do_add_mount+0x81/0x15b
[<c0164ea7>] 	do_mount+0x18f/0x1d8
[<c01bf74e>] 	__copy_from_user_ll+0x74/0x7a
[<c0164ca2>] 	copy_mount_options+0x8c/0x102
[<c01652c1>] 	sys_mount+0xd7/0x135
[<c0348db8>] 	do_mount_root+0x2f/0x9c
[<c0348e79>] 	mount_block_root+0x54/0x118
[<c03490d7>] 	mount_root+0x5e/0x66
[<c0349124>]	prepare_namespace+0x45/0x102
[<c01050c2>]	init+0x35/0x133
[<c010508d>] 	init+0x0/0x133
[<c0108a49>] 	kernel_thread_helper+0x5/0xb

Code: 0f 0b 8c 00 49 3d 2d c0 e9 05 ff ff ff 57 56 53 31 db 8b 7c
	<0>Kernel panic: Attempted to kill init!
	
-----------------------------------------------------------------------

