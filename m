Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266706AbUBQWt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266709AbUBQWt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:49:57 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:12698 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266706AbUBQWtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:49:25 -0500
Date: Tue, 17 Feb 2004 22:47:00 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: nbd oops on unload.
Message-ID: <20040217224700.GE6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modprobe nbd ; rmmod nbd  was enough to reproduce this one..
(2.6.3rc4)

		Dave

nbd: registered device at major 43
Unable to handle kernel paging request at virtual address 6b6b6baf
 printing eip:
c01d3206
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c01d3206>]    Not tainted
EFLAGS: 00010202
EIP is at kobject_hotplug+0x24/0x30
eax: c02e9ff3   ebx: c36530d4   ecx: c36530d4   edx: 6b6b6b6b
esi: c1f4f190   edi: 00000000   ebp: 00000000   esp: c44c5f24
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 7597, threadinfo=c44c4000 task=c40b4650)
Stack: c01d3486 c36530d4 c01d349d c3653084 c0224536 c3653084 c02276d0 c1f4f190
       c7c103dc c022857a c1f4f190 c0191001 c1f4f190 c7c12990 c7c0e4a4 c7c0fd80
       00000000 c031acd8 c013a805 0064626e 00000000 c2cd62d8 c2cd62d8 b80d1000
Call Trace:
 [<c01d3486>] kobject_del+0xf/0x1e
 [<c01d349d>] kobject_unregister+0x8/0x10
 [<c0224536>] elv_unregister_queue+0xf/0x1d
 [<c02276d0>] blk_unregister_queue+0x1b/0x36
 [<c022857a>] unlink_gendisk+0x8/0x19
 [<c0191001>] del_gendisk+0x45/0xc8
 [<c7c0e4a4>] nbd_cleanup+0x26/0x55 [nbd]
 [<c013a805>] sys_delete_module+0x168/0x18a
 [<c014ff4d>] unmap_vma_list+0xe/0x17
 [<c01503f9>] do_munmap+0x17d/0x189
 [<c010b697>] syscall_call+0x7/0xb
 
Code: 83 7a 44 00 74 05 e9 9f fd ff ff c3 53 31 d2 89 c3 c7 40 18

