Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbUKJS5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbUKJS5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 13:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUKJS5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 13:57:12 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:53383 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262095AbUKJS5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 13:57:02 -0500
Subject: 2.6.9 CIFS oops
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Date: Wed, 10 Nov 2004 19:55:41 +0100
Message-Id: <1100112941.4678.26.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Does anyone have an idea how what the problem is ? When I mount a cifs
share then put this notebook to sleep and then later on try to acces
that share the task hangs... also umount does not work and a mount -
while the umount process hangs - then causes this oops (aswell as any
access to that share then...)

oopses from 2 sessions follow.

Soeren

====snip====
Machine check in kernel mode.
Caused by (from SRR1=141000): Transfer error ack signal
Oops: machine check, sig: 7 [#1]
NIP: 00012B5C LR: 000003A4 SP: DC971CA0 REGS: dc971bf0 TRAP: 0200    Not tainted
MSR: 00141000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = d863cdb0[10750] 'cifsd' THREAD: dc970000Last syscall: -1 
GPR00: 00000182 DC971CA0 D863CDB0 00000405 00000000 157BE000 9926234C 40000000 
GPR08: DB769000 00009032 42000000 1C971CA0 C0013908 1001BA00 100270B8 C04BCF14 
GPR16: DC971F80 D863CDB0 00000001 00000000 00000000 DC971FA0 00000037 C0390000 
GPR24: DA54B830 00000037 C0390000 CC1DC0CC 00000037 00000037 00000037 DC971FB8 
NIP [00012b5c] 0x12b5c
LR [000003a4] 0x3a4
Call trace:
 [24828248] 0x24828248
 [c02b0238] skb_copy_datagram_iovec+0x54/0x23c
 [c02d4f5c] tcp_recvmsg+0x538/0x6b8
 [c02acd94] sock_common_recvmsg+0x3c/0x60
 [c02a8e88] sock_recvmsg+0x114/0x11c
 [c02a8ec8] kernel_recvmsg+0x38/0x50
 [c0137e30] cifs_demultiplex_thread+0x544/0x85c
 [c000940c] kernel_thread+0x44/0x60
eth0: Link down
PHY ID: 2060e1, addr: 0
====snip====

====snip====
 CIFS VFS: Invalid size or format for SMB found with length 36 and pdu_lenght 65343
Received Data is: : dump of 37 bytes of data at 0xe37881c0

 0000ff3b ff534d42 2e000000 008001c8 . . ÿ ; ÿ S M B . . . . . . . È
 00000000 00000000 00000000 0100bd6b . . . . . . . . . . . . . . ½ k
 64000ec5 005a5a5a d . . Å .
 CIFS VFS: No response buffer
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0145A5C LR: C0145A00 SP: D3BADE20 REGS: d3badd70 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 6B6B6BD3, DSISR: 40000000
TASK = da0ca790[27610] 'ls' THREAD: d3bac000Last syscall: 197 
GPR00: 000102EB D3BADE20 DA0CA790 DDD04A9C DA1A5CCE 00000003 DFC35D4B C04C0000 
GPR08: C04C0000 6B6B6B6B 00000000 DFB53564 28000282 1002D000 100C0000 100A0000 
GPR16: 00000000 100F1F08 10020000 10020000 10020000 10020000 10020000 00000000 
GPR24: C04C0000 00000000 00000000 DFC35D48 000003D9 D80C37B8 DDD04A74 C658D544 
NIP [c0145a5c] cifs_revalidate+0xe8/0x3c8
LR [c0145a00] cifs_revalidate+0x8c/0x3c8
Call trace:
 [c0145d5c] cifs_getattr+0x20/0x54
 [c006f924] vfs_getattr+0x68/0xd8
 [c006fa9c] vfs_fstat+0x38/0x5c
 [c0070340] sys_fstat64+0x20/0x58
 [c0005fa0] ret_from_syscall+0x0/0x44
Oops: kernel access of bad area, sig: 11 [#2]
NIP: C0145A5C LR: C0145A00 SP: D3BADE20 REGS: d3badd70 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 6B6B6BD3, DSISR: 40000000
TASK = da0ca790[27611] 'ls' THREAD: d3bac000Last syscall: 197 
GPR00: 000111CA D3BADE20 DA0CA790 DDD04A9C DA1A5CCE 00000003 E1A322CF C04C0000 
GPR08: C04C0000 6B6B6B6B 00000000 DFB53564 28000282 1002D000 100C0000 100A0000 
GPR16: 00000000 10228408 10020000 10020000 10020000 10020000 10020000 00000000 
GPR24: C04C0000 00000000 00000000 E1A322CC 000003DA D80C37B8 DDD04A74 C658D544 
NIP [c0145a5c] cifs_revalidate+0xe8/0x3c8
LR [c0145a00] cifs_revalidate+0x8c/0x3c8
Call trace:
 [c0145d5c] cifs_getattr+0x20/0x54
 [c006f924] vfs_getattr+0x68/0xd8
 [c006fa9c] vfs_fstat+0x38/0x5c
 [c0070340] sys_fstat64+0x20/0x58
 [c0005fa0] ret_from_syscall+0x0/0x44
Oops: kernel access of bad area, sig: 11 [#3]
NIP: C0145A5C LR: C0145A00 SP: D4413DE0 REGS: d4413d30 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 6B6B6BD3, DSISR: 40000000
TASK = e76e1330[27544] 'bash' THREAD: d4412000Last syscall: 195 
GPR00: 00012132 D4413DE0 E76E1330 DDD04A9C DA1A5CCE 00000003 DFC3563F C04C0000 
GPR08: C04C0000 6B6B6B6B 00000000 DFB53564 22222482 100CC1D0 100C0000 100A0000 
GPR16: 00000000 10221FE8 24222482 100C0000 10205B88 10204368 100C0000 00000000 
GPR24: C04C0000 00000000 00000000 DFC3563C 000003DB D80C37B8 DDD04A74 C658D544 
NIP [c0145a5c] cifs_revalidate+0xe8/0x3c8
LR [c0145a00] cifs_revalidate+0x8c/0x3c8
Call trace:
 [c0145d5c] cifs_getattr+0x20/0x54
 [c006f924] vfs_getattr+0x68/0xd8
 [c006f9ec] vfs_stat+0x58/0x68
 [c0070290] sys_stat64+0x20/0x58
 [c0005fa0] ret_from_syscall+0x0/0x44
===snip===
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

