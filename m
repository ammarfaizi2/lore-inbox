Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVJZREI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVJZREI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 13:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVJZREI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 13:04:08 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:13269 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964821AbVJZREH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 13:04:07 -0400
Message-ID: <435FB708.3040506@anagramm.de>
Date: Wed, 26 Oct 2005 19:04:08 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is this Oops due to messed up memory? - And how to protect fs during
 driver development?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There!

During my DMA driver development on an embedded MPC8540 (e500) PPC processor, which
is work in progress and definitely dangerous and unstable, I received the oops as shown
below... not really during a dma transfer but later during recompilation of my driver.
I guess, that I corrupted my memory very bad (misprogrammed DMA).
The kernel is still a 2.6.13-rc7

How can I avoid to crash my filesystem during driver development as much as possible?
Well, I do backups, but is there something like a temporary "remount it physically
readonly for the next 10 secons" thingy?

Thanks,

Clemens


Oct 26 18:32:32 ecam kernel: Oops: kernel access of bad area, sig: 11 [#1]
Oct 26 18:32:32 ecam kernel: NIP: C0048070 LR: C004818C SP: C05CBEC0 REGS: c05cbe10 TRAP: 0300 Not tainted
Oct 26 18:32:32 ecam kernel: MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
Oct 26 18:32:32 ecam kernel: DAR: 00000000, DSISR: 00800000
Oct 26 18:32:32 ecam kernel: TASK = c05bf100[3] 'events/0' THREAD: c05ca000
Oct 26 18:32:32 ecam kernel: Last syscall: -1
Oct 26 18:32:32 ecam kernel: GPR00: 00200200 C05CBEC0 C05BF100 C0559340 C055E930 00000001 C0566C14 CA5E1F80
Oct 26 18:32:32 ecam kernel: GPR08: 00000000 00000001 C7AD4000 00100100 00000000 00000000 10000000 00000000
Oct 26 18:32:32 ecam kernel: GPR16: 00000001 00000001 FFFFFFFF 007FFF00 0FFFA600 00000000 00000002 0FFAF3B0
Oct 26 18:32:32 ecam kernel: GPR24: C02D0000 C055935C C02D0000 C055E930 00000001 C055934C 00000000 C0559340
Oct 26 18:32:32 ecam kernel: NIP [c0048070] free_block+0xb0/0x140
Oct 26 18:32:32 ecam kernel: LR [c004818c] drain_array_locked+0x8c/0xd4
Oct 26 18:32:32 ecam kernel: Call trace:
Oct 26 18:32:32 ecam kernel:  [c004818c] drain_array_locked+0x8c/0xd4
Oct 26 18:32:32 ecam kernel:  [c0048fec] cache_reap+0x84/0x1e4
Oct 26 18:32:32 ecam kernel:  [c0030640] worker_thread+0x174/0x218
Oct 26 18:32:32 ecam kernel:  [c003574c] kthread+0xec/0x128
Oct 26 18:32:32 ecam kernel:  [c00050f0] kernel_thread+0x44/0x60
Oct 26 18:34:53 ecam kernel: Oops: kernel access of bad area, sig: 11 [#2]
Oct 26 18:34:53 ecam kernel: NIP: C00CAA28 LR: C00CAB48 SP: C07C3CE0 REGS: c07c3c30 TRAP: 0300 Not tainted
Oct 26 18:34:53 ecam kernel: MSR: 00029000 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 00
Oct 26 18:34:53 ecam kernel: DAR: 2F6C643A, DSISR: 00000000
Oct 26 18:34:53 ecam kernel: TASK = c07c1980[43] 'pdflush' THREAD: c07c2000
Oct 26 18:34:53 ecam kernel: Last syscall: -1
Oct 26 18:34:53 ecam kernel: GPR00: 2F6C643A C07C3CE0 C07C1980 00000000 C19439F0 D10FF0CC C00CA5F4 00000000
Oct 26 18:34:53 ecam kernel: GPR08: CA5E16E0 C07C2000 CA5E16E8 00000000 00000001 00000000 00000000 D1107104
Oct 26 18:34:53 ecam kernel: GPR16: 067D4870 D1124F78 C31B1000 C07C3E70 00B3812B C7C36000 00000012 00000000
Oct 26 18:34:53 ecam kernel: GPR24: 00001AB0 0000010D 00000001 C07C3D80 00000000 D10FF0CC CCA90F74 2F6C642E
Oct 26 18:34:53 ecam kernel: NIP [c00caa28] write_ordered_buffers+0x54/0x248
Oct 26 18:34:53 ecam kernel: LR [c00cab48] write_ordered_buffers+0x174/0x248
Oct 26 18:34:55 ecam kernel: Call trace:
Oct 26 18:34:55 ecam kernel:  [c00caedc] flush_commit_list+0x168/0x5b0
Oct 26 18:34:55 ecam kernel:  [c00d0e6c] do_journal_end+0xa64/0xa94
Oct 26 18:34:55 ecam kernel:  [c00cf7d4] journal_end_sync+0x8c/0xa0
Oct 26 18:34:55 ecam kernel:  [c00b57dc] reiserfs_sync_fs+0x4c/0x88
Oct 26 18:34:55 ecam kernel:  [c00b582c] reiserfs_write_super+0x14/0x24
Oct 26 18:34:55 ecam kernel:  [c0067038] sync_supers+0x1a8/0x1ac
Oct 26 18:34:55 ecam kernel:  [c0045a24] wb_kupdate+0x5c/0x168
Oct 26 18:34:55 ecam kernel:  [c004683c] pdflush+0x120/0x1e0
Oct 26 18:34:55 ecam kernel:  [c003574c] kthread+0xec/0x128
Oct 26 18:34:55 ecam kernel:  [c00050f0] kernel_thread+0x44/0x60
Oct 26 18:34:55 ecam kernel: Badness in do_exit at kernel/exit.c:787
Oct 26 18:34:55 ecam kernel: Call trace:
Oct 26 18:34:55 ecam kernel:  [c0003514] check_bug_trap+0x98/0xdc
Oct 26 18:34:55 ecam kernel:  [c00037b4] ProgramCheckException+0x25c/0x4c8
Oct 26 18:34:55 ecam kernel:  [c0002b40] ret_from_except_full+0x0/0x4c
Oct 26 18:34:55 ecam kernel:  [c0020278] do_exit+0x24/0xad0
Oct 26 18:34:55 ecam kernel:  [c0003130] _exception+0x0/0xa8
Oct 26 18:34:55 ecam kernel:  [c000b0b8] bad_page_fault+0x58/0x5c
Oct 26 18:34:55 ecam kernel:  [c00029d4] handle_page_fault+0x7c/0x80
Oct 26 18:34:55 ecam kernel:  [c00cab48] write_ordered_buffers+0x174/0x248
Oct 26 18:34:55 ecam kernel:  [c00caedc] flush_commit_list+0x168/0x5b0
Oct 26 18:34:55 ecam kernel:  [c00d0e6c] do_journal_end+0xa64/0xa94
Oct 26 18:34:55 ecam kernel:  [c00cf7d4] journal_end_sync+0x8c/0xa0
Oct 26 18:34:55 ecam kernel:  [c00b57dc] reiserfs_sync_fs+0x4c/0x88
Oct 26 18:34:55 ecam kernel:  [c00b582c] reiserfs_write_super+0x14/0x24
Oct 26 18:34:55 ecam kernel:  [c0067038] sync_supers+0x1a8/0x1ac
Oct 26 18:34:55 ecam kernel:  [c0045a24] wb_kupdate+0x5c/0x168


-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
