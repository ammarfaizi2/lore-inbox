Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUBMN4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 08:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267002AbUBMN4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 08:56:49 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:7599 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S266786AbUBMN4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 08:56:47 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.0, BUG() in JFS
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Fri, 13 Feb 2004 08:56:46 -0500
Message-ID: <9cf1xozw09t.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got this oops this morning.  This machine is running 2.6.0... is
this something that's been fixed already?

...
ERROR: (device sdb1): stack overrun in dtSearch!
ERROR: (device sdb1): stack overrun in dtSearch!
BUG at fs/jfs/jfs_dtree.c:3326 assert((btstack)->top != &((btstack)->stack[MAXTREEHEIGHT]))
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_dtree.c:3326!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<f8cbd29d>]    Not tainted
EFLAGS: 00010282
EIP is at dtReadFirst+0x183/0x20e [jfs]
eax: 0000005f   ebx: ef4e7000   ecx: 00000097   edx: c03bbd1c
esi: f2dae19c   edi: 0d0000bc   ebp: 00000000   esp: d25d5e20
ds: 007b   es: 007b   ss: 0068
Process updatedb (pid: 1669, threadinfo=d25d4000 task=f2886080)
Stack: f8cc9980 f8cc999c 00000cfe f8cc90e0 00000000 db8149a4 f4774564 00000000
       f2dae084 00001000 f8cbcebe f2dae2a0 d25d5ed4 00000002 00000001 00000000
       0002707c 00000004 00100000 00100000 f2dae084 d25d5ea0 00000000 00000001
Call Trace:
 [<f8cbcebe>] jfs_readdir+0x934/0xb90 [jfs]
 [<c0247d47>] inode_has_perm+0x65/0x98
 [<c0170c02>] vfs_readdir+0xae/0xb0
 [<c0170f32>] filldir64+0x0/0x148
 [<c01710f5>] sys_getdents64+0x7b/0xc1
 [<c0170f32>] filldir64+0x0/0x148
 [<c010abeb>] syscall_call+0x7/0xb

Code: 0f 0b fe 0c 9c 99 cc f8 e9 58 ff ff ff 8b 54 24 30 8b 02 89

