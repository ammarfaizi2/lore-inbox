Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbUCXTd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUCXTd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:33:56 -0500
Received: from mail.solcon.nl ([212.45.33.11]:11679 "EHLO mail.solcon.nl")
	by vger.kernel.org with ESMTP id S263083AbUCXTdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:33:54 -0500
Subject: 2.6.4: Oops when mounting HFS on ppc32
From: Michel Roelofs <huender.k@solcon.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1080156832.2867.4.camel@maan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Mar 2004 20:33:53 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.24.0.7; VDF 6.24.0.69
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: plain 2.6.4 from ftp.nl.kernel.org

When mounting an hfs filesystem on my ppc32 (powertower pro 250, 604e
cpu) I got the following:

kernel BUG in grow_buffers at fs/buffer.c:1191!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C005D21C LR: C005D1DC SP: D8013C50 REGS: d8013ba0 TRAP: 0700    Not
tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = d9ac6a00[1246] 'mount' Last syscall: 21 
GPR00: 000001FF D8013C50 D9AC6A00 00000000 00000000 00000003 00000000
00000000 
GPR08: 0000001C 00000000 00000000 00000200 22004444 100289FC 00000000
00000000 
GPR16: 00000000 00000000 00000000 100DB688 00000000 00000000 7FFFFC56
00000000 
GPR24: 00000000 7FFFFC60 00000000 00000200 00000000 DBFF3520 00000000
DB73A520 
Call trace:
 [c005d880] __getblk+0x5c/0x64
 [c005d8e0] __bread+0x10/0x40
 [c00cfdf8] hfs_mdb_get+0xac/0x6a0
 [c00d1248] hfs_fill_super+0xc4/0x1a8
 [c0062c58] get_sb_bdev+0x120/0x178
 [c00d1344] hfs_get_sb+0x18/0x28
 [c0062f28] do_kern_mount+0x64/0x120
 [c007cbe8] do_add_mount+0x9c/0x1d0
 [c007cf70] do_mount+0x148/0x178
 [c007d480] sys_mount+0xe8/0x15c
 [c000785c] ret_from_syscall+0x0/0x44

The mount then fails, with the message "Trace/breakpoint trap".

