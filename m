Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUG1U1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUG1U1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUG1U07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:26:59 -0400
Received: from salzburg.nitnet.com.br ([200.157.204.105]:8139 "EHLO
	nat.cesarb.net") by vger.kernel.org with ESMTP id S263467AbUG1UYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:24:31 -0400
Date: Wed, 28 Jul 2004 17:23:48 -0300
To: linux-kernel@vger.kernel.org
Cc: Bruno Lustosa <bruno@lustosa.net>
Subject: Oops at radix_tree_delete
Message-ID: <20040728202348.GC2320@flower.home.cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040523i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(not subscribed to linux-kernel, please CC: me on replies)

A friend of mine asked for help on a problem with tar receiving a sig11.
It turned out to be an oops at time_out_leases. I asked him to find the
first oops, which was at radix_tree_delete.

Jul 24 02:09:49 cerberus kernel: Unable to handle kernel paging request at virtual address 066f0aa3
Jul 24 02:09:49 cerberus kernel:  printing eip:
Jul 24 02:09:49 cerberus kernel: c02015ea
Jul 24 02:09:49 cerberus kernel: *pde = 00000000
Jul 24 02:09:49 cerberus kernel: Oops: 0000 [#1]
Jul 24 02:09:49 cerberus kernel: PREEMPT
Jul 24 02:09:49 cerberus kernel: Modules linked in: ide_cd cdrom 8139too mii crc32 rtc
Jul 24 02:09:49 cerberus kernel: CPU:    0
Jul 24 02:09:49 cerberus kernel: EIP:    0060:[number+298/704]    Not tainted
Jul 24 02:09:49 cerberus kernel: EFLAGS: 00010086   (2.6.7)
Jul 24 02:09:49 cerberus kernel: EIP is at radix_tree_delete+0x4a/0x170
Jul 24 02:09:49 cerberus kernel: eax: 066f0aa3   ebx: 9021bcd2   ecx: 9021bcd8   edx: 066f0aa3
Jul 24 02:09:49 cerberus kernel: esi: 000039cf   edi: c1987dd8   ebp: c2b04a24   esp: c1987db8
Jul 24 02:09:49 cerberus kernel: ds: 007b   es: 007b   ss: 0068
Jul 24 02:09:49 cerberus kernel: Process kswapd0 (pid: 32, threadinfo=c1986000 task=c19be5d0)
Jul 24 02:09:49 cerberus kernel: Stack: 00000002 00000000 c1987de4 e1acfd28 00000202 00000000 e1acfd30 c1987df0
Jul 24 02:09:49 cerberus kernel:        066f0a9f 066f0aa3 00000000 f2f2a7e0 f2f2a8a8 00000031 00000010 00000001
Jul 24 02:09:49 cerberus kernel:        c1274520 c14a7180 c151c6c0 c11fbec0 c12a55a0 c14b6ea0 c14f7960 c0104856
Jul 24 02:09:49 cerberus kernel: Call Trace:
Jul 24 02:09:49 cerberus kernel:  [apic_timer_interrupt+26/32] apic_timer_interrupt+0x1a/0x20
Jul 24 02:09:49 cerberus kernel:  [filemap_flush+10/16] __remove_from_page_cache+0x1a/0x40
Jul 24 02:09:49 cerberus kernel:  [shrink_cache+9/784] shrink_list+0x319/0x490
Jul 24 02:09:49 cerberus kernel:  [shrink_cache+691/784] shrink_cache+0x133/0x310
Jul 24 02:09:49 cerberus kernel:  [handle_write_error+41/128] shrink_slab+0x79/0x170
Jul 24 02:09:49 cerberus kernel:  [wakeup_kswapd+75/80] balance_pgdat+0x18b/0x1f0
Jul 24 02:09:49 cerberus kernel:  [install_page+78/416] kswapd+0xbe/0xd0
Jul 24 02:09:49 cerberus kernel:  [mm_init+48/192] autoremove_wake_function+0x0/0x50
Jul 24 02:09:49 cerberus kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Jul 24 02:09:49 cerberus kernel:  [mm_init+48/192] autoremove_wake_function+0x0/0x50
Jul 24 02:09:49 cerberus kernel:  [shrink_all_memory+96/103] kswapd+0x0/0xd0
Jul 24 02:09:49 cerberus kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Jul 24 02:09:49 cerberus kernel:
Jul 24 02:09:49 cerberus kernel: Code: 8b 02 85 c0 0f 84 f5 00 00 00 89 d9 89 f0 83 eb 06 d3 e8 83
Jul 24 02:09:49 cerberus kernel:  <6>note: kswapd0[32] exited with preempt_count 1

Unable to handle kernel NULL pointer dereference at virtual address 00000029
printing eip:
c015d2b5
*pde = 00000000
Oops: 0000 [#12]
PREEMPT
Modules linked in: ide_cd cdrom 8139too mii crc32 rtc
CPU:    0
EIP:    0060:[<c015d2b5>]    Not tainted
EFLAGS: 00210202   (2.6.7)
EIP is at time_out_leases+0x15/0x80
eax: d057e54c   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: d057e5dc   edi: e3c0a000   ebp: d057e54c   esp: e3c0bee8
ds: 007b   es: 007b   ss: 0068
Process tar (pid: 26448, threadinfo=e3c0a000 task=f7301230)
Stack: 00000000 d057e54c e3c0bf78 d057e54c e3c0bf78 c015d36f d0ce3178 00000000
      00000000 d057e54c 00000000 00008001 f6b0abf0 d057e54c e3c0bf78 00008001
      d0ce3178 c0157963 dc545000 e3c0bf78 00008001 00000004 c0157a36 00000000
Call Trace:
[<c015d36f>] __break_lease+0x4f/0x270
[<c0157963>] may_open+0x143/0x180
[<c0157a36>] open_namei+0x96/0x3b0
[<c014976d>] filp_open+0x2d/0x60
[<c0149bfd>] sys_open+0x4d/0x80
[<c0103e75>] sysenter_past_esp+0x52/0x71

Code: f6 43 28 20 74 25 f6 43 29 10 74 1f 8b 53 4c 85 d2 75 1e 8b

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
