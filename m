Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265455AbTFRUSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbTFRUSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:18:14 -0400
Received: from 63.156-136-217.adsl.skynet.be ([217.136.156.63]:19460 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S265455AbTFRURr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:17:47 -0400
Message-ID: <3EF0CBCB.4010202@trollprod.org>
Date: Wed, 18 Jun 2003 22:30:03 +0200
From: Olivier NICOLAS <olivn@trollprod.org>
Organization: TrollPod
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.7x: processes in D state
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some time from a few seconds after boot to a few hours, the system 
locks.

Processes seem to be in D state

Kernel 2.5.72

System
	2 x Athlon MP 1800
	512 Mb RAM
	IDE disk (reiserfs and ext3 partions)
	


AltSysRq T ....

.....

konqueror     D 00000001 4244652160  1965   1943                     (NOTLB)
Call Trace:
  [<c011c3aa>] default_wake_function+0x2a/0x30
  [<c011cb5e>] sleep_on+0x6e/0x130
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01e6768>] do_journal_begin_r+0x88/0x2a0
  [<c01e69d7>] journal_begin+0x27/0x30
  [<c01d5a07>] reiserfs_dirty_inode+0x77/0x140
  [<c0183a16>] __mark_inode_dirty+0x126/0x160
  [<c017c6c2>] update_atime+0xb2/0xd0
  [<c01d0edc>] reiserfs_readdir+0x59c/0x610
  [<c021a072>] tty_default_put_char+0x32/0x40
  [<c014d461>] do_wp_page+0x281/0x410
  [<c014e613>] handle_mm_fault+0x193/0x220
  [<c0172c2e>] vfs_readdir+0x7e/0xa0
  [<c0172f40>] filldir64+0x0/0x120
  [<c01730d4>] sys_getdents64+0x74/0xb5
  [<c0172f40>] filldir64+0x0/0x120
  [<c01097f3>] syscall_call+0x7/0xb
....


SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c010719f>] CPU: 0
EIP is at default_idle+0x2f/0x40
  EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c036a000 ECX: 00000000 EDX: c036a000
ESI: c0107170 EDI: ffffe000 EBP: c036bfb0 DS: 007b ES: 007b
CR0: 8005003b CR2: 40018000 CR3: 16b33000 CR4: 000006d0
Call Trace:
  [<c0107235>] cpu_idle+0x45/0x60
  [<c0105000>] _stext+0x0/0x80
  [<c036c93f>] start_kernel+0x16f/0x1a0
  [<c036c4e0>] unknown_bootoption+0x0/0x110

SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c010719f>] CPU: 0
EIP is at default_idle+0x2f/0x40
  EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c036a000 ECX: 00000000 EDX: c036a000
ESI: c0107170 EDI: ffffe000 EBP: c036bfb0 DS: 007b ES: 007b
CR0: 8005003b CR2: 40018000 CR3: 16b33000 CR4: 000006d0
Call Trace:
  [<c0107235>] cpu_idle+0x45/0x60
  [<c0105000>] _stext+0x0/0x80
  [<c036c93f>] start_kernel+0x16f/0x1a0
  [<c036c4e0>] unknown_bootoption+0x0/0x110


SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c010719f>] CPU: 0
EIP is at default_idle+0x2f/0x40
  EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c036a000 ECX: 00000000 EDX: c036a000
ESI: c0107170 EDI: ffffe000 EBP: c036bfb0 DS: 007b ES: 007b
CR0: 8005003b CR2: 40018000 CR3: 16b33000 CR4: 000006d0
Call Trace:
  [<c0107235>] cpu_idle+0x45/0x60
  [<c0105000>] _stext+0x0/0x80
  [<c036c93f>] start_kernel+0x16f/0x1a0
  [<c036c4e0>] unknown_bootoption+0x0/0x110


SysRq : Terminate All Tasks




Same problem 2.5.70-mm3

bash          D 00000010  1464   1349                     (NOTLB)
Call Trace:
  [<c011cf8b>] sleep_on+0x7b/0x170
  [<c011c710>] default_wake_function+0x0/0x30
  [<c01ea4a8>] do_journal_begin_r+0x88/0x2a0
  [<c01ea717>] journal_begin+0x27/0x30
  [<c01d95d7>] reiserfs_dirty_inode+0x77/0x140
  [<c013d725>] file_read_actor+0x115/0x120
  [<c01856b6>] __mark_inode_dirty+0x126/0x160
  [<c013d30a>] do_generic_mapping_read+0xfa/0x400
  [<c017e0e2>] update_atime+0xb2/0xd0
  [<c013d8ef>] __generic_file_aio_read+0x1bf/0x1e0
  [<c013d610>] file_read_actor+0x0/0x120
  [<c013da3a>] generic_file_read+0xba/0xe0
  [<c0145f34>] kmem_cache_alloc+0x114/0x190
  [<c0119c0b>] pgd_alloc+0x1b/0x20
  [<c0119c0b>] pgd_alloc+0x1b/0x20
  [<c011f340>] autoremove_wake_function+0x0/0x50
  [<c015e81a>] vfs_read+0xda/0x120
  [<c016baca>] kernel_read+0x4a/0x60
  [<c016caab>] prepare_binprm+0xcb/0xf0
  [<c016d04e>] do_execve+0xfe/0x1e0
  [<c0107cbf>] sys_execve+0x3f/0x80
  [<c01098a3>] syscall_call+0x7/0xb

bash          D 00000000  1467   1410                1432 (NOTLB)
Call Trace:
  [<c011cf8b>] sleep_on+0x7b/0x170
  [<c011c710>] default_wake_function+0x0/0x30
  [<c01ea4a8>] do_journal_begin_r+0x88/0x2a0
  [<c01ea717>] journal_begin+0x27/0x30
  [<c01d95d7>] reiserfs_dirty_inode+0x77/0x140
  [<c013d725>] file_read_actor+0x115/0x120
  [<c01856b6>] __mark_inode_dirty+0x126/0x160
  [<c013d30a>] do_generic_mapping_read+0xfa/0x400
  [<c017e0e2>] update_atime+0xb2/0xd0
  [<c013d8ef>] __generic_file_aio_read+0x1bf/0x1e0
  [<c013d610>] file_read_actor+0x0/0x120
  [<c013da3a>] generic_file_read+0xba/0xe0
  [<c0119c0b>] pgd_alloc+0x1b/0x20
  [<c0119c0b>] pgd_alloc+0x1b/0x20
  [<c011f340>] autoremove_wake_function+0x0/0x50
  [<c015e81a>] vfs_read+0xda/0x120
  [<c016baca>] kernel_read+0x4a/0x60
  [<c016caab>] prepare_binprm+0xcb/0xf0
  [<c016d04e>] do_execve+0xfe/0x1e0
  [<c0107cbf>] sys_execve+0x3f/0x80
  [<c01098a3>] syscall_call+0x7/0xb

bash          D 00000000  1467   1410                1432 (NOTLB)
Call Trace:
  [<c011cf8b>] sleep_on+0x7b/0x170
  [<c011c710>] default_wake_function+0x0/0x30
  [<c01ea4a8>] do_journal_begin_r+0x88/0x2a0
  [<c01ea717>] journal_begin+0x27/0x30
  [<c01d95d7>] reiserfs_dirty_inode+0x77/0x140
  [<c013d725>] file_read_actor+0x115/0x120
  [<c01856b6>] __mark_inode_dirty+0x126/0x160
  [<c013d30a>] do_generic_mapping_read+0xfa/0x400
  [<c017e0e2>] update_atime+0xb2/0xd0
  [<c013d8ef>] __generic_file_aio_read+0x1bf/0x1e0
  [<c013d610>] file_read_actor+0x0/0x120
  [<c013da3a>] generic_file_read+0xba/0xe0
  [<c0145f34>] kmem_cache_alloc+0x114/0x190
  [<c0119c0b>] pgd_alloc+0x1b/0x20
  [<c0119c0b>] pgd_alloc+0x1b/0x20
  [<c011f340>] autoremove_wake_function+0x0/0x50
  [<c015e81a>] vfs_read+0xda/0x120
  [<c016baca>] kernel_read+0x4a/0x60
  [<c016caab>] prepare_binprm+0xcb/0xf0
  [<c016d04e>] do_execve+0xfe/0x1e0
  [<c0107cbf>] sys_execve+0x3f/0x80
  [<c01098a3>] syscall_call+0x7/0xb


