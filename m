Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUBRDCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUBRDCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:02:32 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:37792 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261606AbUBRDC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:02:29 -0500
Date: Wed, 18 Feb 2004 02:59:38 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: 2.6.3rc4 compaq hotplug driver go bang on rmmod.
Message-ID: <20040218025938.GA26304@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice this driver has got its pci_driver remove: method commented out.
Greg, whats the thinking behind that? Surely we can do something
better than the current ...

		Dave

cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.7
eip: c010a286
------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:120!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c010a2d8>]    Not tainted
EFLAGS: 00010082
EIP is at __down+0x52/0x165
eax: 0000000e   ebx: c7a08bcc   ecx: c02d2517   edx: 00000000
esi: 00000246   edi: c010a286   ebp: c2ccd2f0   esp: c2c8bf04
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1349, threadinfo=c2c8a000 task=c2ccd2f0)
Stack: c111acc0 c2c8bf20 c2c8bf58 00000000 c2ccd2f0 c01217e4 00000000 00000000
       c01c7089 00010000 00000000 c7a08bcc 00000000 00000100 00000000 c010a624
       c7a08bcc 00000077 00000000 c7a00a5d c7a08100 c79f996d c7a08100 00000000
Call Trace:
 [<c01217e4>] default_wake_function+0x0/0xc
 [<c01c7089>] task_has_capability+0x4c/0x54
 [<c010a624>] __down_failed+0x8/0xc
 [<c7a00a5d>] .text.lock.cpqphp_ctrl+0x119/0x148 [cpqphp]
 [<c79f996d>] unload_cpqphpd+0x190/0x1b3 [cpqphp]
 [<c7a02ccb>] cpqhpc_cleanup+0x1f/0x43 [cpqphp]
 [<c013a805>] sys_delete_module+0x168/0x18a
 [<c014ff4d>] unmap_vma_list+0xe/0x17
 [<c01503f9>] do_munmap+0x17d/0x189
 [<c010b697>] syscall_call+0x7/0xb
 
Code: 0f 0b 78 00 00 25 2d c0 f0 fe 4b 08 0f 88 96 03 00 00 83 4c

