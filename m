Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265493AbUFXPIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUFXPIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbUFXPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:06:56 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:7154 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265398AbUFXPDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:03:17 -0400
Date: Thu, 24 Jun 2004 08:02:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.7-mm2 oopses and badness
Message-ID: <1968860000.1088089370@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During bootup, shortly after CPU init (mm1 was fine):

Only candidate I can see is 
+reduce-tlb-flushing-during-process-migration-2.patch
Will try backing that out unless you want something else ...

Jun 24 06:54:24 larry kernel: PCI->APIC IRQ transform: (B5,I10,P0) -> 119
Jun 24 06:54:24 larry kernel: PCI->APIC IRQ transform: (B5,I11,P0) -> 115
Jun 24 06:54:24 larry kernel: PCI->APIC IRQ transform: (B8,I12,P0) -> 184
Jun 24 06:54:24 larry kernel: PCI->APIC IRQ transform: (B8,I13,P0) -> 180
Jun 24 06:54:24 larry kernel: PCI->APIC IRQ transform: (B7,I11,P0) -> 163
Jun 24 06:54:24 larry kernel: highmem bounce pool size: 64 pages

Jun 24 06:54:24 larry kernel: c010e98b
Jun 24 06:54:24 larry kernel: SMP 
Jun 24 06:54:24 larry kernel: c010e98b
Jun 24 06:54:24 larry kernel: Modules linked in:
Jun 24 06:54:24 larry kernel: CPU:    12
Jun 24 06:54:24 larry kernel: EIP:    0060:[flush_tlb_mm+7/120]    Not tainted VLI
Jun 24 06:54:24 larry kernel: EFLAGS: 00010292   (2.6.7-mm2) 
Jun 24 06:54:24 larry kernel: EIP is at flush_tlb_mm+0x7/0x78
Jun 24 06:54:24 larry kernel: eax: 00000000   ebx: f124bfa8   ecx: 00000000   ed
x: f124bf94
Jun 24 06:54:24 larry kernel: esi: c30d3be0   edi: 00000000   ebp: f124bf9c   esp: f124bf4c
Jun 24 06:54:24 larry kernel: ds: 007b   es: 007b   ss: 0068
Jun 24 06:54:24 larry kernel: Process kswapd3 (pid: 72, threadinfo=f124a000 task=f1247390)
Jun 24 06:54:24 larry kernel: Stack: 00200200 c01159e1 00000000 f1247390 f124bfdc f124bff0 f124bfa8 c02bcc40 
Jun 24 06:54:24 larry kernel:        00000000 00000282 f124bf74 f124bf74 00000000 f1247390 0000000c f124a000 
Jun 24 06:54:24 larry kernel:        00000000 00000001 f124bf94 f124bf94 f1a00000 c0138bca f1247390 0000f000 
Jun 24 06:54:24 larry kernel: Call Trace:
Jun 24 06:54:24 larry kernel:  [set_cpus_allowed+225/252] set_cpus_allowed+0xe1/0xfc
Jun 24 06:54:24 larry kernel:  [kswapd+142/224] kswapd+0x8e/0xe0
Jun 24 06:54:24 larry kernel:  [kswapd+0/224] kswapd+0x0/0xe0
Jun 24 06:54:24 larry kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Jun 24 06:54:24 larry kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Jun 24 06:54:24 larry kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Jun 24 06:54:24 larry kernel: Code: 0f 20 d8 0f 22 d8 8b 04 24 85 c0 74 13 6a ff 51 50 e8 0a ff ff ff 83 c4 0c 8d b4 26 00 00 00 00 59 c3 89 f6 83 ec
 04 8b 4c 24 08 <8b> 81 24 01 00 00 ba 00 e0 ff ff 21 e2 89 04 24 8b 42 10 f0 0f 
Jun 24 06:54:24 larry kernel:  <1>Oops: 0000 [#2]
Jun 24 06:54:24 larry kernel: SMP 
Jun 24 06:54:24 larry kernel: Modules linked in:
Jun 24 06:54:24 larry kernel: CPU:    4
Jun 24 06:54:24 larry kernel: EIP:    0060:[flush_tlb_mm+7/120]    Not tainted VLI
Jun 24 06:54:24 larry kernel: EFLAGS: 00010292   (2.6.7-mm2) 
Jun 24 06:54:24 larry kernel: EIP is at flush_tlb_mm+0x7/0x78
Jun 24 06:54:24 larry kernel: eax: 00000000   ebx: f1245fa8   ecx: 00000000   edx: f1245f94
Jun 24 06:54:24 larry kernel: esi: c30c3be0   edi: 00000000   ebp: f1245f9c   esp: f1245f4c
Jun 24 06:54:24 larry kernel: ds: 007b   es: 007b   ss: 0068
Jun 24 06:54:24 larry kernel: Process kswapd1 (pid: 70, threadinfo=f1244000 task=f1104230)
Jun 24 06:54:24 larry kernel: Stack: 00200200 c01159e1 00000000 f1104230 f1245fdc f1245ff0 f1245fa8 c02bcc40 
Jun 24 06:54:24 larry kernel:        00000000 00000282 f1245f74 f1245f74 00000000 f1104230 00000004 f1244000 
Jun 24 06:54:24 larry kernel:        00000000 00000001 f1245f94 f1245f94 f5e00000 c0138bca f1104230 000000f0 
Jun 24 06:54:24 larry kernel: Call Trace:
Jun 24 06:54:24 larry kernel:  [set_cpus_allowed+225/252] set_cpus_allowed+0xe1/0xfc
Jun 24 06:54:24 larry kernel:  [kswapd+142/224] kswapd+0x8e/0xe0
Jun 24 06:54:24 larry kernel:  [kswapd+0/224] kswapd+0x0/0xe0
Jun 24 06:54:24 larry kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Jun 24 06:54:24 larry kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Jun 24 06:54:24 larry kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Jun 24 06:54:24 larry kernel: Code: 0f 20 d8 0f 22 d8 8b 04 24 85 c0 74 13 6a ff 51 50 e8 0a ff ff ff 83 c4 0c 8d b4 26 00 00 00 00 59 c3 89 f6 83 ec
 04 8b 4c 24 08 <8b> 81 24 01 00 00 ba 00 e0 ff ff 21 e2 89 04 24 8b 42 10 f0 0f 
Jun 24 06:54:24 larry kernel:   at virtual address 00000124
Jun 24 06:54:24 larry kernel: c010e98b
Jun 24 06:54:24 larry kernel: SMP 
Jun 24 06:54:24 larry kernel: Modules linked in:
Jun 24 06:54:24 larry kernel: CPU:    8
Jun 24 06:54:24 larry kernel: EIP:    0060:[flush_tlb_mm+7/120]    Not tainted VLI
Jun 24 06:54:24 larry kernel: EFLAGS: 00010292   (2.6.7-mm2) 
Jun 24 06:54:24 larry kernel: EIP is at flush_tlb_mm+0x7/0x78
Jun 24 06:54:24 larry kernel: eax: 00000000   ebx: f1249fa8   ecx: 00000000   edx: f1249f94
Jun 24 06:54:24 larry kernel: esi: c30cbbe0   edi: 00000000   ebp: f1249f9c   esp: f1249f4c
Jun 24 06:54:24 larry kernel: ds: 007b   es: 007b   ss: 0068
Jun 24 06:54:24 larry kernel: Process kswapd2 (pid: 71, threadinfo=f1248000 task=f1247950)
Jun 24 06:54:24 larry kernel: Stack: 00200200 c01159e1 00000000 f1247950 f1249fdc f1249ff0 f1249fa8 c02bcc40 
Jun 24 06:54:24 larry kernel:        00000000 00000282 f1249f74 f1249f74 00000000 f1247950 00000008 f1248000 
Jun 24 06:54:24 larry kernel:        00000000 00000001 f1249f94 f1249f94 f3c00000 c0138bca f1247950 00000f00 
Jun 24 06:54:24 larry kernel: Call Trace:
Jun 24 06:54:24 larry kernel:  [set_cpus_allowed+225/252] set_cpus_allowed+0xe1/0xfc
Jun 24 06:54:24 larry kernel:  [kswapd+142/224] kswapd+0x8e/0xe0
Jun 24 06:54:24 larry kernel:  [kswapd+0/224] kswapd+0x0/0xe0
Jun 24 06:54:24 larry kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Jun 24 06:54:24 larry kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Jun 24 06:54:24 larry kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Jun 24 06:54:24 larry kernel: Code: 0f 20 d8 0f 22 d8 8b 04 24 85 c0 74 13 6a ff 51 50 e8 0a ff ff ff 83 c4 0c 8d b4 26 00 00 00 00 59 c3 89 f6 83 ec
 04 8b 4c 24 08 <8b> 81 24 01 00 00 ba 00 e0 ff ff 21 e2 89 04 24 8b 42 10 f0 0f 


After mounting fs's also get this:

Badness in complement_pos at drivers/char/vt.c:458
 [<c01c621c>] complement_pos+0x3c/0x13c
 [<c01c3ebd>] clear_selection+0xd/0x48
 [<c01c6666>] hide_cursor+0x12/0x30
 [<c01c9962>] vt_console_print+0xa6/0x2d4
 [<c0118674>] __call_console_drivers+0x3c/0x4c
 [<c01186dc>] _call_console_drivers+0x58/0x60
 [<c011879e>] call_console_drivers+0xba/0xe8
 [<c0118a52>] release_console_sem+0x42/0xb4
 [<c01189b1>] printk+0x11d/0x134
 [<c018632a>] ext3_setup_super+0x14e/0x15c
 [<c015fcf8>] d_alloc_root+0x34/0x3c
 [<c018703a>] ext3_fill_super+0x952/0xac4
 [<c0151433>] get_sb_bdev+0xe3/0x12c
 [<c0187c63>] ext3_get_sb+0x1f/0x24
 [<c01866e8>] ext3_fill_super+0x0/0xac4
 [<c01515f2>] do_kern_mount+0x4a/0xb8
 [<c01643d9>] do_add_mount+0x69/0x154
 [<c01646c2>] do_mount+0x15e/0x178
 [<c0164514>] copy_mount_options+0x50/0xa0
 [<c0164a4f>] sys_mount+0xb3/0x118
 [<c0103baf>] syscall_call+0x7/0xb
Badness in complement_pos at drivers/char/vt.c:458
 [<c01c621c>] complement_pos+0x3c/0x13c
 [<c01c3ebd>] clear_selection+0xd/0x48
 [<c01c66cd>] set_cursor+0x49/0x80
 [<c01c9b6b>] vt_console_print+0x2af/0x2d4
 [<c0118674>] __call_console_drivers+0x3c/0x4c
 [<c01186dc>] _call_console_drivers+0x58/0x60
 [<c011879e>] call_console_drivers+0xba/0xe8
 [<c0118a52>] release_console_sem+0x42/0xb4
 [<c01189b1>] printk+0x11d/0x134
 [<c018632a>] ext3_setup_super+0x14e/0x15c
 [<c015fcf8>] d_alloc_root+0x34/0x3c
 [<c018703a>] ext3_fill_super+0x952/0xac4
 [<c0151433>] get_sb_bdev+0xe3/0x12c
 [<c0187c63>] ext3_get_sb+0x1f/0x24
 [<c01866e8>] ext3_fill_super+0x0/0xac4
 [<c01515f2>] do_kern_mount+0x4a/0xb8
 [<c01643d9>] do_add_mount+0x69/0x154
 [<c01646c2>] do_mount+0x15e/0x178
 [<c0164514>] copy_mount_options+0x50/0xa0
 [<c0164a4f>] sys_mount+0xb3/0x118
 [<c0103baf>] syscall_call+0x7/0xb
Badness in poke_blanked_console at drivers/char/vt.c:2910
 [<c01ca76c>] poke_blanked_console+0x30/0xa8
 [<c01c9b7c>] vt_console_print+0x2c0/0x2d4
 [<c0118674>] __call_console_drivers+0x3c/0x4c
 [<c01186dc>] _call_console_drivers+0x58/0x60
 [<c011879e>] call_console_drivers+0xba/0xe8
 [<c0118a52>] release_console_sem+0x42/0xb4
 [<c01189b1>] printk+0x11d/0x134
 [<c018632a>] ext3_setup_super+0x14e/0x15c
 [<c015fcf8>] d_alloc_root+0x34/0x3c
 [<c018703a>] ext3_fill_super+0x952/0xac4
 [<c0151433>] get_sb_bdev+0xe3/0x12c
 [<c0187c63>] ext3_get_sb+0x1f/0x24
 [<c01866e8>] ext3_fill_super+0x0/0xac4
 [<c01515f2>] do_kern_mount+0x4a/0xb8
 [<c01643d9>] do_add_mount+0x69/0x154
 [<c01646c2>] do_mount+0x15e/0x178
 [<c0164514>] copy_mount_options+0x50/0xa0
 [<c0164a4f>] sys_mount+0xb3/0x118
 [<c0103baf>] syscall_call+0x7/0xb

