Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVBDMj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVBDMj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVBDMj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:39:59 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:39423 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S261177AbVBDMjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:39:55 -0500
Date: Fri, 4 Feb 2005 13:39:54 +0100
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Hangs with 2.6.10-ac11
Message-ID: <20050204123953.GY5588@os.inf.tu-dresden.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing hangs with kernel 2.6.10-ac11 and also previous
ac-series. The affected box is a quite loaded Dual-Xeon HT system.
The kernel was built with gcc-2.95 (Debian woody).
Sysrq-b on ac11 brings the following and the completely hangs, i.e. no
sysrq responses anymore:

SysRq : Emergency Sync
SysRq : Emergency Remount R/O
SysRq : Resetting
Badness in smp_call_function at arch/i386/kernel/smp.c:523
 [<c010c718>] smp_call_function+0x4c/0xf0
 [<c0116dc7>] release_console_sem+0x1f/0xa8
 [<c010c7fc>] smp_send_stop+0x10/0x1c
 [<c010c7bc>] stop_this_cpu+0x0/0x30
 [<c010c238>] machine_restart+0x7c/0xf8
 [<c02518fb>] sysrq_handle_reboot+0x7/0xc
 [<c0251a87>] __handle_sysrq+0x6b/0x104
 [<c0251b3d>] handle_sysrq+0x1d/0x24
 [<c0258030>] receive_chars+0x138/0x204 
 [<c02582f2>] serial8250_interrupt+0x66/0xe4
 [<c012d750>] handle_IRQ_event+0x28/0x58
 [<c012d87b>] __do_IRQ+0xfb/0x150
 [<c010415b>] do_IRQ+0x1b/0x28
 [<c0102bd2>] common_interrupt+0x1a/0x20
 [<c03266a6>] _spin_lock+0xa/0x10
 [<c010c752>] smp_call_function+0x86/0xf0
 [<c01362e8>] do_drain+0x0/0x44
 [<c01362e8>] do_drain+0x0/0x44
 [<c01362d6>] smp_call_function_all_cpus+0x1a/0x2c
 [<c01362e8>] do_drain+0x0/0x44
 [<c013633d>] drain_cpu_caches+0x11/0x40
 [<c01362e8>] do_drain+0x0/0x44
 [<c0136379>] __cache_shrink+0xd/0x8c
 [<c013641e>] kmem_cache_shrink+0x26/0x2c
 [<c022636c>] xfs_inode_shake+0xc/0x24
 [<c0138676>] shrink_slab+0x86/0x1a0
 [<c013990e>] try_to_free_pages+0xd2/0x188
 [<c0132a95>] __alloc_pages+0x1e5/0x308
 [<c0135596>] do_page_cache_readahead+0x10a/0x194
 [<c01357b1>] page_cache_readahead+0x191/0x1c8
 [<c012f036>] do_generic_mapping_read+0xe6/0x464
 [<c012f839>] generic_file_sendfile+0x51/0x64
 [<c012f798>] file_send_actor+0x0/0x50
 [<c0224eaa>] xfs_sendfile+0x152/0x1a4
 [<c012f798>] file_send_actor+0x0/0x50
 [<c012f798>] file_send_actor+0x0/0x50
 [<c0221d2a>] linvfs_sendfile+0x36/0x40
 [<c012f798>] file_send_actor+0x0/0x50
 [<c014a43a>] do_sendfile+0x246/0x294
 [<c012f798>] file_send_actor+0x0/0x50
 [<c014a55c>] sys_sendfile64+0x3c/0xa0
 [<c0102263>] syscall_call+0x7/0xb


Btw, would it be possible to directly boot the box in the sysrq case
instead of going through the smp functions as it looks they do not
always have the desired effect?





Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
