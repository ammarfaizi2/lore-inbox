Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUA1ROz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUA1ROz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:14:55 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:45216 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266136AbUA1ROw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:14:52 -0500
Date: Wed, 28 Jan 2004 09:14:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: relf@rambler.ru
Subject: [Bug 1964] New: HPFS crash on writing 
Message-ID: <51200000.1075310070@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1964

           Summary: HPFS crash on writing
    Kernel Version: 2.6.1
            Status: NEW
          Severity: high
             Owner: fs_other@kernel-bugs.osdl.org
         Submitter: relf@rambler.ru


Distribution: Debian unstable, kernel 2.6.1
Problem Description: HPFS driver crashes on attempt to write. Reproduced on two
different systems/partitions.

Steps to reproduce: mount some HPFS partition, try to write something on it.
You'll get something like

kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000002c
kernel:  printing eip:
kernel: c01e3919
kernel: *pde = 00000000
kernel: Oops: 0002 [#1]
kernel: CPU:    0
kernel: EIP:    0060:[hpfs_lock_2inodes+41/112]    Not tainted
kernel: EFLAGS: 00010283
kernel: EIP is at hpfs_lock_2inodes+0x29/0x70
kernel: eax: 015eed65   ebx: f5b8d084   ecx: 0000002c   edx: 015dbffc
kernel: esi: f5b8d084   edi: ebff5b00   ebp: 00000000   esp: eedd3eb4
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process mc (pid: 610, threadinfo=eedd2000 task=f401a6f0)
kernel: Stack: 00000000 c01ed687 f59d2cc4 f5b8d084 ebff5b80 0000000b f5294000
0000000b
kernel:        f59d2c80 ebff5b80 0000000b 0000000b eedd3f88 c0173abf f586ad40
ebff5b68
kernel:        eedd3f88 f7f7b37c 090dcff9 eedd2000 e9f6bf30 00000000 ebff5b00
f5294000
kernel: Call Trace:
kernel:  [hpfs_unlink+135/1120] hpfs_unlink+0x87/0x460
kernel:  [__d_lookup+351/368] __d_lookup+0x15f/0x170
kernel:  [cached_lookup+35/144] cached_lookup+0x23/0x90
kernel:  [permission+47/80] permission+0x2f/0x50
kernel:  [vfs_unlink+205/400] vfs_unlink+0xcd/0x190
kernel:  [sys_unlink+204/320] sys_unlink+0xcc/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel:
kernel: Code: f0 ff 0d 2c 00 00 00 0f 88 7f 07 00 00 f0 ff 0d 2c 00 00 00

