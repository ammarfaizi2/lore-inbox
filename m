Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUEKMrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUEKMrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbUEKMrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:47:51 -0400
Received: from relay.azr.nl ([156.83.252.225]:36860 "EHLO relay.azr.nl")
	by vger.kernel.org with ESMTP id S264704AbUEKMra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:47:30 -0400
From: "Jerome Borsboom" <j.borsboom@erasmusmc.nl>
To: linux-kernel@vger.kernel.org
Date: Tue, 11 May 2004 14:47:12 +0200
MIME-Version: 1.0
Subject: 2.6.6 Oops with v1 quota on ext3
Message-ID: <40A0E770.22863.F1E3C4@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

With kernel 2.6.6 on i686 we get kernel Oopses in the v1 quota 
code (see below). I have tracked it down to  release_dqblk  not 
being defined in the quota_format_ops for v1 quota. 
Dquot_release calls release_dqblk which is not defined for v1 
and hence the oops.


Greetz,
Jerome Borsboom

---------
Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246   (2.6.6SMP) 
EIP is at 0x0
eax: c02a45d8   ebx: f7bc9aa4   ecx: f7bc9aa4   edx: f7bc9aa0
esi: f73e50b0   edi: f73e5090   ebp: f7bc9a00   esp: f74b1ea4
ds: 007b   es: 007b   ss: 0068
Process smbd (pid: 381, threadinfo=f74b0000 task=f74b3950)
Stack: c01875c6 f73e5090 00000000 f74b0000 f73e5090 00328016 00000001 c0187ba5 
       f73e5090 f7bc9a00 00328016 f74b1f80 00000000 f7516de4 c0188a3b f73e5090 
       f7516de4 f762d214 c01a55fe f7516de4 00000042 f7516de4 f7bc9a00 c0198a52 
Call Trace:
 [dquot_release+134/176] dquot_release+0x86/0xb0
 [dqput+213/496] dqput+0xd5/0x1f0
 [dquot_drop+107/128] dquot_drop+0x6b/0x80
 [ext3_dquot_drop+62/112] ext3_dquot_drop+0x3e/0x70
 [ext3_free_inode+146/1136] ext3_free_inode+0x92/0x470
 [ext3_mark_inode_dirty+80/96] ext3_mark_inode_dirty+0x50/0x60
 [ext3_delete_inode+236/272] ext3_delete_inode+0xec/0x110
 [ext3_delete_inode+0/272] ext3_delete_inode+0x0/0x110
 [generic_delete_inode+382/400] generic_delete_inode+0x17e/0x190
 [sys_unlink+136/336] sys_unlink+0x88/0x150
 [sys_fcntl64+92/160] sys_fcntl64+0x5c/0xa0
 [syscall_call+7/11] syscall_call+0x7/0xb

Code:  Bad EIP value.

