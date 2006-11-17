Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755807AbWKQSqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbWKQSqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755810AbWKQSqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:46:34 -0500
Received: from dot.reactive-networks.net ([217.144.82.11]:48142 "EHLO
	dot.oreally.co.uk") by vger.kernel.org with ESMTP id S1755807AbWKQSqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:46:32 -0500
Date: Fri, 17 Nov 2006 18:46:30 +0000
From: linux-kernel@ckeith.clara.net
To: linux-kernel@vger.kernel.org
Subject: "Unable to handle kernel NULL pointer dereference" in 2.6.18.2 (2.6.18-1.2239.fc5)
Message-ID: <20061117184630.GV26200@dot.oreally.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

2.6.18 kernels do not seem happy on my new 2x dual core opteron box. I posted
an oops yesterday but since then have wiped everything and started again
(without XFS this time, just in case) and upgraded to 2.6.18-1.2239.fc5 which
is 2.6.18.2 + a couple of redhat patches. It had been running for about 24
hours and was idling when the following Oops came up.

I've included 3 stack traces. The second and third stack traces appeared
immediately after the first. Then the third was repeated constantly until I
rebooted it. I assume this is because the original error caused the scheduling
to throw errors and both the second and third are red herrings, but I thought
I'd include them, just in case.

dmesg is attached below, if anything else is needed please let me know.
And if any one knows of any older kernels that are more stable for this
hardware configuration (2x dual core opteron 2220SE's with aacraid) please
let me know.

TIA,
Colin.

Unable to handle kernel NULL pointer dereference at 0000000000000050 RIP:
 [<ffffffff8025fabb>] memcpy_c+0xb/0x14
PGD 0
Oops: 0002 [1] SMP
last sysfs file: /class/input/input1/capabilities/sw
CPU 0
Modules linked in: ipmi_devintf ipmi_si ipmi_msghandler i2c_isa nls_utf8 ipv6 dm_mod video sbs i2c_ec button battery asus_acpi ac lp parport_pc parport ohci_hcd ehci_hcd sg ide_cd id
Pid: 2299, comm: gpm Not tainted 2.6.18-1.2239.fc5 #1
RIP: 0010:[<ffffffff8025fabb>]  [<ffffffff8025fabb>] memcpy_c+0xb/0x14
RSP: 0000:ffff8102fe727bf8  EFLAGS: 00010246
RAX: 0000000000000050 RBX: 0000000000000000 RCX: 0000000000000008
RDX: 0000000000000000 RSI: ffff8102fe727c00 RDI: 0000000000000050
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000030
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8102ffe8a000
R13: 0000000000000050 R14: ffff8102ffc4ca80 R15: ffff81030c248078
FS:  00002aaaaaf8fb00(0000) GS:ffffffff80603000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000050 CR3: 0000000000201000 CR4: 00000000000006e0
Process gpm (pid: 2299, threadinfo 0000000000000000, task ffff8102fe1e4040)
Stack:  ffffffff8020aecb ffffffff8808d2e6 ffff81000cfa5900 ffff8102ffcd8540
 ffff8102ffcd8540 ffff8102ffcd8540 ffff8102ffcd8540 ffffffff880a9653
 ffff8102ffcd8540 ffff8102ffcd8540 ffffffff880ac1f8 ffffffff880ac227
Call Trace:
Inexact backtrace:
 [<ffffffff8020aecb>] __find_get_block+0x14b/0x172
 [<ffffffff8808d2e6>] :jbd:journal_start+0x8f/0x101
 [<ffffffff880a9653>] :ext3:start_transaction+0x1c/0x48
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff880ac227>] :ext3:ext3_delete_inode+0x2f/0xd8
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff8022f5c4>] generic_delete_inode+0xcb/0x149
 [<ffffffff8020d0be>] dput+0x10e/0x12b
 [<ffffffff8021244e>] __fput+0x17d/0x1aa
 [<ffffffff8021a480>] remove_vma+0x4e/0x75
 [<ffffffff80239e64>] exit_mmap+0xcf/0xf3
 [<ffffffff8023bff3>] mmput+0x41/0x96
 [<ffffffff802150f7>] do_exit+0x28c/0x8c3
 [<ffffffff80247b25>] cpuset_exit+0x0/0x6c
 [<ffffffff8022b280>] get_signal_to_deliver+0x42d/0x45d
 [<ffffffff80259eba>] do_notify_resume+0x9c/0x7ae
 [<ffffffff80294499>] signal_wake_up+0x1e/0x2d
 [<ffffffff80294fe9>] specific_send_sig_info+0xa1/0xac
 [<ffffffff80295265>] force_sig_info+0xa9/0xb3
 [<ffffffff802b3b05>] audit_syscall_exit+0x2cd/0x2eb
 [<ffffffff8025c5d0>] retint_signal+0x3d/0x79


Code: f3 48 a5 89 d1 f3 a4 c3 90 eb ea 66 66 66 90 66 66 66 90 66
RIP  [<ffffffff8025fabb>] memcpy_c+0xb/0x14
 RSP <ffff8102fe727bf8>
CR2: 0000000000000050
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000010 RIP:
 [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
PGD 0
Oops: 0002 [2] SMP
last sysfs file: /class/input/input1/capabilities/sw
CPU 0
Modules linked in: ipmi_devintf ipmi_si ipmi_msghandler i2c_isa nls_utf8 ipv6 dm_mod video sbs i2c_ec button battery asus_acpi ac lp parport_pc parport ohci_hcd ehci_hcd sg ide_cd id
Pid: 2299, comm: gpm Not tainted 2.6.18-1.2239.fc5 #1
RIP: 0010:[<ffffffff80287d81>]  [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
RSP: 0000:ffffffff8067cf38  EFLAGS: 00010017
RAX: 0000000000000000 RBX: ffff81000d057488 RCX: 00000000113a032c
RDX: 0000517524bac600 RSI: 0000000000000000 RDI: ffff81000d059480
RBP: ffffffff8067cf68 R08: ffffffff80673400 R09: ffff81008c9e4000
R10: 0000000000000046 R11: ffffffff803523ee R12: ffff8102fe1e4040
R13: ffff81000d057400 R14: 0000000000000002 R15: ffff8102fe1e4040
FS:  00002aaaaaf8fb00(0000) GS:ffffffff80603000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000010 CR3: 0000000000201000 CR4: 00000000000006e0
Process gpm (pid: 2299, threadinfo 0000000000000000, task ffff8102fe1e4040)
Stack:  000000008028ecf7 ffff8102fe1e4040 0000000000000000 0000000000000000
 0000000000000002 ffff8102fe1e4040 0000000000000000 ffffffff80293721
 ffff8102fe727988 ffff8102fe7279b0 ffff8102fe727b48 ffffffff80273dc2
Call Trace:
 [<ffffffff80293721>] update_process_times+0x5c/0x68
 [<ffffffff80273dc2>] smp_local_timer_interrupt+0x23/0x47
 [<ffffffff80274483>] smp_apic_timer_interrupt+0x41/0x47
 [<ffffffff8025cb82>] apic_timer_interrupt+0x66/0x6c
DWARF2 unwinder stuck at apic_timer_interrupt+0x66/0x6c
Leftover inexact backtrace:
 <IRQ>  <EOI>  [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff80262764>] _spin_unlock_irqrestore+0xb/0xd
 [<ffffffff80262d93>] oops_end+0x3a/0x53
 [<ffffffff80264860>] do_page_fault+0x74a/0x815
 [<ffffffff802236c9>] __pagevec_free+0x2a/0x3b
 [<ffffffff8020ac77>] release_pages+0x152/0x15f
 [<ffffffff8025ccdd>] error_exit+0x0/0x84
 [<ffffffff8025fabb>] memcpy_c+0xb/0x14
 [<ffffffff8020aecb>] __find_get_block+0x14b/0x172
 [<ffffffff8808d2e6>] :jbd:journal_start+0x8f/0x101
 [<ffffffff880a9653>] :ext3:start_transaction+0x1c/0x48
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff880ac227>] :ext3:ext3_delete_inode+0x2f/0xd8
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff8022f5c4>] generic_delete_inode+0xcb/0x149
 [<ffffffff8020d0be>] dput+0x10e/0x12b
 [<ffffffff8021244e>] __fput+0x17d/0x1aa
 [<ffffffff8021a480>] remove_vma+0x4e/0x75
 [<ffffffff80239e64>] exit_mmap+0xcf/0xf3
 [<ffffffff8023bff3>] mmput+0x41/0x96
 [<ffffffff802150f7>] do_exit+0x28c/0x8c3
 [<ffffffff80247b25>] cpuset_exit+0x0/0x6c
 [<ffffffff8022b280>] get_signal_to_deliver+0x42d/0x45d
 [<ffffffff80259eba>] do_notify_resume+0x9c/0x7ae
 [<ffffffff80294499>] signal_wake_up+0x1e/0x2d
 [<ffffffff80294fe9>] specific_send_sig_info+0xa1/0xac
 [<ffffffff80295265>] force_sig_info+0xa9/0xb3
 [<ffffffff802b3b05>] audit_syscall_exit+0x2cd/0x2eb
 [<ffffffff8025c5d0>] retint_signal+0x3d/0x79


Code: f0 0f ba 68 10 03 e9 79 02 00 00 4c 89 ef e8 3e a9 fd ff 41
RIP  [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
 RSP <ffffffff8067cf38>
CR2: 0000000000000010
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():1

Call Trace:
 [<ffffffff802691d9>] show_trace+0x34/0x47
 [<ffffffff802691fe>] dump_stack+0x12/0x17
 [<ffffffff8029db75>] down_read+0x15/0x23
 [<ffffffff80296114>] blocking_notifier_call_chain+0x13/0x36
 [<ffffffff80214e8a>] do_exit+0x1f/0x8c3
 [<ffffffff802648b0>] do_page_fault+0x79a/0x815
 [<ffffffff8025ccdd>] error_exit+0x0/0x84
DWARF2 unwinder stuck at error_exit+0x0/0x84
Leftover inexact backtrace:
 <IRQ>  [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
 [<ffffffff80287cf6>] scheduler_tick+0x16/0x34e
 [<ffffffff80293721>] update_process_times+0x5c/0x68
 [<ffffffff80273dc2>] smp_local_timer_interrupt+0x23/0x47
 [<ffffffff80274483>] smp_apic_timer_interrupt+0x41/0x47
 [<ffffffff8025cb82>] apic_timer_interrupt+0x66/0x6c
 <EOI>  [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff80262764>] _spin_unlock_irqrestore+0xb/0xd
 [<ffffffff80262d93>] oops_end+0x3a/0x53
 [<ffffffff80264860>] do_page_fault+0x74a/0x815
 [<ffffffff802236c9>] __pagevec_free+0x2a/0x3b
 [<ffffffff8020ac77>] release_pages+0x152/0x15f
 [<ffffffff8025ccdd>] error_exit+0x0/0x84
 [<ffffffff8025fabb>] memcpy_c+0xb/0x14
 [<ffffffff8020aecb>] __find_get_block+0x14b/0x172
 [<ffffffff8808d2e6>] :jbd:journal_start+0x8f/0x101
 [<ffffffff880a9653>] :ext3:start_transaction+0x1c/0x48
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff880ac227>] :ext3:ext3_delete_inode+0x2f/0xd8
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff8022f5c4>] generic_delete_inode+0xcb/0x149
 [<ffffffff8020d0be>] dput+0x10e/0x12b
 [<ffffffff8021244e>] __fput+0x17d/0x1aa
 [<ffffffff8021a480>] remove_vma+0x4e/0x75
 [<ffffffff80239e64>] exit_mmap+0xcf/0xf3
 [<ffffffff8023bff3>] mmput+0x41/0x96
 [<ffffffff802150f7>] do_exit+0x28c/0x8c3
 [<ffffffff80247b25>] cpuset_exit+0x0/0x6c
 [<ffffffff8022b280>] get_signal_to_deliver+0x42d/0x45d
 [<ffffffff80259eba>] do_notify_resume+0x9c/0x7ae
 [<ffffffff80294499>] signal_wake_up+0x1e/0x2d
 [<ffffffff80294fe9>] specific_send_sig_info+0xa1/0xac
 [<ffffffff80295265>] force_sig_info+0xa9/0xb3
 [<ffffffff802b3b05>] audit_syscall_exit+0x2cd/0x2eb
 [<ffffffff8025c5d0>] retint_signal+0x3d/0x79

Unable to handle kernel NULL pointer dereference at 0000000000000010 RIP:
 [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
PGD 0
Oops: 0002 [3] SMP
last sysfs file: /class/input/input1/capabilities/sw
CPU 0
Modules linked in: ipmi_devintf ipmi_si ipmi_msghandler i2c_isa nls_utf8 ipv6 dm_mod video sbs i2c_ec button battery asus_acpi ac lp parport_pc parport ohci_hcd ehci_hcd sg ide_cd id
Pid: 2299, comm: gpm Not tainted 2.6.18-1.2239.fc5 #1
RIP: 0010:[<ffffffff80287d81>]  [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
RSP: 0000:ffffffff8067cbe8  EFLAGS: 00010017
RAX: 0000000000000000 RBX: ffff81000d057488 RCX: 0000000023be8cc0
RDX: 0000517535f4c92c RSI: 0000000000000000 RDI: ffff81000d059480
RBP: ffffffff8067cc18 R08: ffffffff80673400 R09: ffff81008c9e4000
R10: ffffffff8067cc38 R11: ffffffff803523ee R12: ffff8102fe1e4040
R13: ffff81000d057400 R14: 0000000000000002 R15: ffff8102fe1e4040
FS:  00002aaaaaf8fb00(0000) GS:ffffffff80603000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000010 CR3: 0000000000201000 CR4: 00000000000006e0
Process gpm (pid: 2299, threadinfo 0000000000000000, task ffff8102fe1e4040)
Stack:  0000000080551140 ffff8102fe1e4040 0000000000000000 0000000000000000
 0000000000000002 ffff8102fe1e4040 0000000000000000 ffffffff80293721
 ffffffff8067cc48 ffffffff8067cc70 ffff8102fe1e4040 ffffffff80273dc2
Call Trace:
 [<ffffffff80293721>] update_process_times+0x5c/0x68
 [<ffffffff80273dc2>] smp_local_timer_interrupt+0x23/0x47
 [<ffffffff80274483>] smp_apic_timer_interrupt+0x41/0x47
 [<ffffffff8025cb82>] apic_timer_interrupt+0x66/0x6c
DWARF2 unwinder stuck at apic_timer_interrupt+0x66/0x6c
Leftover inexact backtrace:
 <IRQ>  [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff8026274c>] _spin_unlock_irq+0xb/0xc
 [<ffffffff80262211>] __down_read+0x34/0x96
 [<ffffffff802691fe>] dump_stack+0x12/0x17
 [<ffffffff8020b5e4>] __might_sleep+0xad/0xb5
 [<ffffffff80296114>] blocking_notifier_call_chain+0x13/0x36
 [<ffffffff80214e8a>] do_exit+0x1f/0x8c3
 [<ffffffff802648b0>] do_page_fault+0x79a/0x815
 [<ffffffff803df600>] hid_input_report+0x2f4/0x347
 [<ffffffff803e0ab1>] hid_irq_in+0x95/0xea
 [<ffffffff8025ccdd>] error_exit+0x0/0x84
 [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
 [<ffffffff80287cf6>] scheduler_tick+0x16/0x34e
 [<ffffffff80293721>] update_process_times+0x5c/0x68
 [<ffffffff80273dc2>] smp_local_timer_interrupt+0x23/0x47
 [<ffffffff80274483>] smp_apic_timer_interrupt+0x41/0x47
 [<ffffffff8025cb82>] apic_timer_interrupt+0x66/0x6c
 <EOI>  [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff80262764>] _spin_unlock_irqrestore+0xb/0xd
 [<ffffffff80262d93>] oops_end+0x3a/0x53
 [<ffffffff80264860>] do_page_fault+0x74a/0x815
 [<ffffffff802236c9>] __pagevec_free+0x2a/0x3b
 [<ffffffff8020ac77>] release_pages+0x152/0x15f
 [<ffffffff8025ccdd>] error_exit+0x0/0x84
 [<ffffffff8025fabb>] memcpy_c+0xb/0x14
 [<ffffffff8020aecb>] __find_get_block+0x14b/0x172
 [<ffffffff8808d2e6>] :jbd:journal_start+0x8f/0x101
 [<ffffffff880a9653>] :ext3:start_transaction+0x1c/0x48
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff880ac227>] :ext3:ext3_delete_inode+0x2f/0xd8
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff8022f5c4>] generic_delete_inode+0xcb/0x149
 [<ffffffff8020d0be>] dput+0x10e/0x12b
 [<ffffffff8021244e>] __fput+0x17d/0x1aa
 [<ffffffff8021a480>] remove_vma+0x4e/0x75
 [<ffffffff80239e64>] exit_mmap+0xcf/0xf3
 [<ffffffff8023bff3>] mmput+0x41/0x96
 [<ffffffff802150f7>] do_exit+0x28c/0x8c3
 [<ffffffff80247b25>] cpuset_exit+0x0/0x6c
 [<ffffffff8022b280>] get_signal_to_deliver+0x42d/0x45d
 [<ffffffff80259eba>] do_notify_resume+0x9c/0x7ae
 [<ffffffff80294499>] signal_wake_up+0x1e/0x2d
 [<ffffffff80294fe9>] specific_send_sig_info+0xa1/0xac
 [<ffffffff80295265>] force_sig_info+0xa9/0xb3
 [<ffffffff802b3b05>] audit_syscall_exit+0x2cd/0x2eb
 [<ffffffff8025c5d0>] retint_signal+0x3d/0x79


Code: f0 0f ba 68 10 03 e9 79 02 00 00 4c 89 ef e8 3e a9 fd ff 41
RIP  [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
 RSP <ffffffff8067cbe8>
CR2: 0000000000000010
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000010 RIP:
 [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
PGD 0
Oops: 0002 [4] SMP
last sysfs file: /class/input/input1/capabilities/sw
CPU 0
Modules linked in: ipmi_devintf ipmi_si ipmi_msghandler i2c_isa nls_utf8 ipv6 dm_mod video sbs i2c_ec button battery asus_acpi ac lp parport_pc parport ohci_hcd ehci_hcd sg ide_cd id
Pid: 2299, comm: gpm Not tainted 2.6.18-1.2239.fc5 #1
RIP: 0010:[<ffffffff80287d81>]  [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
RSP: 0000:ffffffff8067c898  EFLAGS: 00010017
RAX: 0000000000000000 RBX: ffff81000d057488 RCX: 000000001b381c2f
RDX: 0000517559b355ec RSI: 0000000000000000 RDI: ffff81000d059480
RBP: ffffffff8067c8c8 R08: ffffffff80673400 R09: ffff81008c9e4000
R10: 0000000000000002 R11: ffffffff803523ee R12: ffff8102fe1e4040
R13: ffff81000d057400 R14: 0000000000000002 R15: ffff8102fe1e4040
FS:  00002aaaaaf8fb00(0000) GS:ffffffff80603000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000010 CR3: 0000000000201000 CR4: 00000000000006e0
Process gpm (pid: 2299, threadinfo 0000000000000000, task ffff8102fe1e4040)
Stack:  00000000804a313f ffff8102fe1e4040 0000000000000000 0000000000000000
 0000000000000002 ffff8102fe1e4040 0000000000000000 ffffffff80293721
 ffffffff8067c8f8 ffffffff8067c920 ffff8102fe1e4040 ffffffff80273dc2
Call Trace:
 [<ffffffff80293721>] update_process_times+0x5c/0x68
 [<ffffffff80273dc2>] smp_local_timer_interrupt+0x23/0x47
 [<ffffffff80274483>] smp_apic_timer_interrupt+0x41/0x47
 [<ffffffff8025cb82>] apic_timer_interrupt+0x66/0x6c
DWARF2 unwinder stuck at apic_timer_interrupt+0x66/0x6c
Leftover inexact backtrace:
 <IRQ>  [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff8026274c>] _spin_unlock_irq+0xb/0xc
 [<ffffffff80262211>] __down_read+0x34/0x96
 [<ffffffff80296114>] blocking_notifier_call_chain+0x13/0x36
 [<ffffffff80214e8a>] do_exit+0x1f/0x8c3
 [<ffffffff802648b0>] do_page_fault+0x79a/0x815
 [<ffffffff803a19dc>] serial8250_console_putchar+0x3f/0x9e
 [<ffffffff803a199d>] serial8250_console_putchar+0x0/0x9e
 [<ffffffff8039d191>] uart_console_write+0x36/0x44
 [<ffffffff8025ccdd>] error_exit+0x0/0x84
 [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
 [<ffffffff80287cf6>] scheduler_tick+0x16/0x34e
 [<ffffffff80293721>] update_process_times+0x5c/0x68
 [<ffffffff80273dc2>] smp_local_timer_interrupt+0x23/0x47
 [<ffffffff80274483>] smp_apic_timer_interrupt+0x41/0x47
 [<ffffffff8025cb82>] apic_timer_interrupt+0x66/0x6c
 [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff8026274c>] _spin_unlock_irq+0xb/0xc
 [<ffffffff80262211>] __down_read+0x34/0x96
 [<ffffffff802691fe>] dump_stack+0x12/0x17
 [<ffffffff8020b5e4>] __might_sleep+0xad/0xb5
 [<ffffffff80296114>] blocking_notifier_call_chain+0x13/0x36
 [<ffffffff80214e8a>] do_exit+0x1f/0x8c3
 [<ffffffff802648b0>] do_page_fault+0x79a/0x815
 [<ffffffff803df600>] hid_input_report+0x2f4/0x347
 [<ffffffff803e0ab1>] hid_irq_in+0x95/0xea
 [<ffffffff8025ccdd>] error_exit+0x0/0x84
 [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff80287d81>] scheduler_tick+0xa1/0x34e
 [<ffffffff80287cf6>] scheduler_tick+0x16/0x34e
 [<ffffffff80293721>] update_process_times+0x5c/0x68
 [<ffffffff80273dc2>] smp_local_timer_interrupt+0x23/0x47
 [<ffffffff80274483>] smp_apic_timer_interrupt+0x41/0x47
 [<ffffffff8025cb82>] apic_timer_interrupt+0x66/0x6c
 <EOI>  [<ffffffff803523ee>] vgacon_cursor+0x0/0x1a5
 [<ffffffff80262764>] _spin_unlock_irqrestore+0xb/0xd
 [<ffffffff80262d93>] oops_end+0x3a/0x53
 [<ffffffff80264860>] do_page_fault+0x74a/0x815
 [<ffffffff802236c9>] __pagevec_free+0x2a/0x3b
 [<ffffffff8020ac77>] release_pages+0x152/0x15f
 [<ffffffff8025ccdd>] error_exit+0x0/0x84
 [<ffffffff8025fabb>] memcpy_c+0xb/0x14
 [<ffffffff8020aecb>] __find_get_block+0x14b/0x172
 [<ffffffff8808d2e6>] :jbd:journal_start+0x8f/0x101
 [<ffffffff880a9653>] :ext3:start_transaction+0x1c/0x48
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff880ac227>] :ext3:ext3_delete_inode+0x2f/0xd8
 [<ffffffff880ac1f8>] :ext3:ext3_delete_inode+0x0/0xd8
 [<ffffffff8022f5c4>] generic_delete_inode+0xcb/0x149
 [<ffffffff8020d0be>] dput+0x10e/0x12b
 [<ffffffff8021244e>] __fput+0x17d/0x1aa
 [<ffffffff8021a480>] remove_vma+0x4e/0x75
 [<ffffffff80239e64>] exit_mmap+0xcf/0xf3
 [<ffffffff8023bff3>] mmput+0x41/0x96
 [<ffffffff802150f7>] do_exit+0x28c/0x8c3
 [<ffffffff80247b25>] cpuset_exit+0x0/0x6c
 [<ffffffff8022b280>] get_signal_to_deliver+0x42d/0x45d
 [<ffffffff80259eba>] do_notify_resume+0x9c/0x7ae
 [<ffffffff80294499>] signal_wake_up+0x1e/0x2d
 [<ffffffff80294fe9>] specific_send_sig_info+0xa1/0xac
 [<ffffffff80295265>] force_sig_info+0xa9/0xb3
 [<ffffffff802b3b05>] audit_syscall_exit+0x2cd/0x2eb
 [<ffffffff8025c5d0>] retint_signal+0x3d/0x79


Bootdata ok (command line is ro root=LABEL=/ console=ttyS0,115200 console=tty0)
Linux version 2.6.18-1.2239.fc5 (brewbuilder@hs20-bc1-6.build.redhat.com) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 SMP Fri Nov 10 12:51:06 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfffe000 (ACPI data)
 BIOS-e820: 00000000bfffe000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ff700000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000600000000 (usable)
DMI present.
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 1 -> APIC 2 -> Node 1
SRAT: PXM 1 -> APIC 3 -> Node 1
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-c0000000
SRAT: Node 0 PXM 0 0-300000000
SRAT: Node 1 PXM 1 300000000-600000000
ACPI: SLIT table looks invalid. Not used.
Bootmem setup node 0 0000000000000000-0000000300000000
Bootmem setup node 1 0000000300000000-0000000600000000
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x2008
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xdcffb000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xdcffb000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009e000 - 000000000009f000
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e0000
Nosave address range: 00000000000e0000 - 0000000000100000
Nosave address range: 00000000bfff0000 - 00000000bfffe000
Nosave address range: 00000000bfffe000 - 00000000c0000000
Nosave address range: 00000000c0000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 00000000fec01000
Nosave address range: 00000000fec01000 - 00000000fee00000
Nosave address range: 00000000fee00000 - 00000000fef00000
Nosave address range: 00000000fef00000 - 00000000ff700000
Nosave address range: 00000000ff700000 - 0000000100000000
Allocating PCI resources starting at c4000000 (gap: c0000000:3ec00000)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 2 zonelists.  Total pages: 5929566
Kernel command line: ro root=LABEL=/ console=ttyS0,115200 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2814.480 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Checking aperture...
CPU 0: aperture @ c0000000 size 256 MB
CPU 1: aperture @ c0000000 size 256 MB
Memory: 23667212k/25165824k available (2392k kernel code, 449580k reserved, 1711k data, 204k init)
Calibrating delay using timer specific routine.. 5632.21 BogoMIPS (lpj=2816109)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12564653
Detected 12.564 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5628.21 BogoMIPS (lpj=2814105)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
Dual-Core AMD Opteron(tm) Processor 2220 SE stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 687 cycles)
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 5627.97 BogoMIPS (lpj=2813989)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2/2 -> Node 1
CPU: Physical Processor ID: 1
CPU: Processor Core ID: 0
Dual-Core AMD Opteron(tm) Processor 2220 SE stepping 02
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff 7 cycles, maxerr 1299 cycles)
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 5628.06 BogoMIPS (lpj=2814030)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3/3 -> Node 1
CPU: Physical Processor ID: 1
CPU: Processor Core ID: 1
Dual-Core AMD Opteron(tm) Processor 2220 SE stepping 02
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -14 cycles, maxerr 1298 cycles)
Brought up 4 CPUs
testing NMI watchdog ... OK.
migration_cost=392,491
checking if image is initramfs... it is
Freeing initrd memory: 1121k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:06.0
ACPI: PCI Root Bridge [PCIB] (0000:80)
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *10
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs<7>Losing some ticks... checking if CPU frequency changed.
 16 17 18 19) *10
ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *10
ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *11
ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *10
ACPI: PCI Interrupt Link [LMAD] (IRQs 20 21 22 23) *5
ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *11
ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *11
ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *5
ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *7
ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *5
ACPI: PCI Interrupt Link [LSA1] (IRQs 20 21 22 23) *10
ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LSA2] (IRQs 20 21 22 23) *10
ACPI: PCI Interrupt Link [LN2A] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2B] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2C] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2D] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LE3A] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LE3B] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LE3C] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LE3D] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [IIM0] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [IIM1] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [ISI0] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [ISI1] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [ISI2] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [ILSM] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [ILPM] (IRQs 44 45 46 47) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 17 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ c0000000 size 262144 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 256MB of IOMMU area in the AGP aperture
pnp: 00:06: ioport range 0xb00-0xb7f has been reserved
pnp: 00:06: ioport range 0xb80-0xb83 has been reserved
pnp: 00:06: ioport range 0xb84-0xb85 has been reserved
pnp: 00:06: ioport range 0xb86-0xb8d has been reserved
pnp: 00:06: ioport range 0xb90-0xb9f has been reserved
pnp: 00:06: ioport range 0xc00-0xcfe could not be reserved
pnp: 00:09: ioport range 0x3000-0x307f has been reserved
pnp: 00:09: ioport range 0x3080-0x30ff has been reserved
pnp: 00:09: ioport range 0x3400-0x347f has been reserved
pnp: 00:09: ioport range 0x3480-0x34ff has been reserved
pnp: 00:09: ioport range 0x3800-0x387f has been reserved
pnp: 00:09: ioport range 0x3880-0x38ff has been reserved
pnp: 00:0d: ioport range 0xa00-0xa0f has been reserved
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: df000000-dfbfffff
  PREFETCH window: dd000000-ddffffff
PCI: Bridge: 0000:04:00.0
  IO window: disabled.
  MEM window: dfd00000-dfffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:00.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: dfc00000-dfffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0f.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt Link [LNEA] enabled at IRQ 19
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:04:00.1[A] -> Link [LNEA] -> GSI 19 (level, low) -> IRQ 177
PCI: Bridge: 0000:80:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:80:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:80:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:80:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:80:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:80:0f.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1163769761.180:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 7CA24123B153FD83
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcie_portdrv_probe->Dev[0376:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0378:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0375:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0377:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0376:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0378:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0375:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[0377:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
.serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:05: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP55: IDE controller at PCI slot 0000:00:04.0
NFORCE-MCP55: chipset revision 161
NFORCE-MCP55: not 100% native mode: will probe irqs later
NFORCE-MCP55: 0000:00:04.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
hda: Slimtype DVDRW SSM-8515S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 4 Dual-Core AMD Opteron(tm) Processor 2220 SE processors (version 2.00.00)
powernow-k8:    0 : fid 0x14 (2800 MHz), vid 0x7
powernow-k8:    1 : fid 0x12 (2600 MHz), vid 0x9
powernow-k8:    2 : fid 0x10 (2400 MHz), vid 0xb
powernow-k8:    3 : fid 0xe (2200 MHz), vid 0xd
powernow-k8:    4 : fid 0xc (2000 MHz), vid 0xf
powernow-k8:    5 : fid 0xa (1800 MHz), vid 0x11
powernow-k8:    6 : fid 0x2 (1000 MHz), vid 0x12
powernow-k8:    0 : fid 0x14 (2800 MHz), vid 0x7
powernow-k8:    1 : fid 0x12 (2600 MHz), vid 0x9
powernow-k8:    2 : fid 0x10 (2400 MHz), vid 0xb
powernow-k8:    3 : fid 0xe (2200 MHz), vid 0xd
powernow-k8:    4 : fid 0xc (2000 MHz), vid 0xf
powernow-k8:    5 : fid 0xa (1800 MHz), vid 0x11
powernow-k8:    6 : fid 0x2 (1000 MHz), vid 0x12
ACPI: (supports S0 S4 S5)
Freeing unused kernel memory: 204k freed
Write protecting the kernel read-only data: 460k
input: AT Translated Set 2 keyboard as /class/input/input0
SCSI subsystem initialized
Adaptec aacraid driver (1.1-5[2409]-mh2)
ACPI: PCI Interrupt 0000:05:01.0[A] -> Link [LNEA] -> GSI 19 (level, low) -> IRQ 177
AAC0: kernel 5.1-0[8832]
AAC0: monitor 5.1-0[8832]
AAC0: bios 5.1-0[8832]
AAC0: serial 16fc25
AAC0: Non-DASD support enabled.
AAC0: 64bit support enabled.
AAC0: 64 Bit DAC enabled
scsi0 : aacraid
  Vendor: Adaptec   Model: Array 0           Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 2342883328 512-byte hdwr sectors (1199556 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
SCSI device sda: 2342883328 512-byte hdwr sectors (1199556 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 0:0:0:0: Attached scsi removable disk sda
  Vendor: FUJITSU   Model: MAW3300NC         Rev: 0104
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: FUJITSU   Model: MAW3300NC         Rev: 0104
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: FUJITSU   Model: MAW3300NC         Rev: 0104
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: FUJITSU   Model: MAW3300NC         Rev: 0104
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: FUJITSU   Model: MAW3300NC         Rev: 0104
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: FUJITSU   Model: MAW3300NC         Rev: 0104
  Type:   Direct-Access                      ANSI SCSI revision: 03
ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
GSI 17 sharing vector 0x62 and IRQ 17
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LSA0] -> GSI 23 (level, low) -> IRQ 98
ata1: SATA max UDMA/133 cmd 0xB480 ctl 0xB402 bmdma 0xAC00 irq 98
ata2: SATA max UDMA/133 cmd 0xB080 ctl 0xB002 bmdma 0xAC08 irq 98
scsi1 : sata_nv
ata1: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xB487
scsi2 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xB087
ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 22
GSI 18 sharing vector 0x6A and IRQ 18
ACPI: PCI Interrupt 0000:00:05.1[B] -> Link [LSA1] -> GSI 22 (level, low) -> IRQ 106
ata3: SATA max UDMA/133 cmd 0xA880 ctl 0xA802 bmdma 0xA080 irq 106
ata4: SATA max UDMA/133 cmd 0xA480 ctl 0xA402 bmdma 0xA088 irq 106
scsi3 : sata_nv
ata3: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xA887
scsi4 : sata_nv
ata4: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xA487
ACPI: PCI Interrupt Link [LSA2] enabled at IRQ 21
GSI 19 sharing vector 0x72 and IRQ 19
ACPI: PCI Interrupt 0000:00:05.2[C] -> Link [LSA2] -> GSI 21 (level, low) -> IRQ 114
ata5: SATA max UDMA/133 cmd 0xA000 ctl 0x9C02 bmdma 0x9480 irq 114
ata6: SATA max UDMA/133 cmd 0x9880 ctl 0x9802 bmdma 0x9488 irq 114
scsi5 : sata_nv
ata5: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xA007
scsi6 : sata_nv
ata6: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x9887
ACPI: PCI Interrupt Link [ISI0] enabled at IRQ 47
GSI 20 sharing vector 0x7A and IRQ 20
ACPI: PCI Interrupt 0000:80:05.0[A] -> Link [ISI0] -> GSI 47 (level, low) -> IRQ 122
ata7: SATA max UDMA/133 cmd 0xE480 ctl 0xE402 bmdma 0xDC00 irq 122
ata8: SATA max UDMA/133 cmd 0xE080 ctl 0xE002 bmdma 0xDC08 irq 122
scsi7 : sata_nv
ata7: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xE487
scsi8 : sata_nv
ata8: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xE087
ACPI: PCI Interrupt Link [ISI1] enabled at IRQ 46
GSI 21 sharing vector 0x82 and IRQ 21
ACPI: PCI Interrupt 0000:80:05.1[B] -> Link [ISI1] -> GSI 46 (level, low) -> IRQ 130
ata9: SATA max UDMA/133 cmd 0xD880 ctl 0xD802 bmdma 0xD080 irq 130
ata10: SATA max UDMA/133 cmd 0xD480 ctl 0xD402 bmdma 0xD088 irq 130
scsi9 : sata_nv
ata9: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xD887
scsi10 : sata_nv
ata10: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xD487
ACPI: PCI Interrupt Link [ISI2] enabled at IRQ 45
GSI 22 sharing vector 0x8A and IRQ 22
ACPI: PCI Interrupt 0000:80:05.0[A] -> Link [ISI0] -> GSI 47 (level, low) -> IRQ 122
ata7: SATA max UDMA/133 cmd 0xE480 ctl 0xE402 bmdma 0xDC00 irq 122
ata8: SATA max UDMA/133 cmd 0xE080 ctl 0xE002 bmdma 0xDC08 irq 122
scsi7 : sata_nv
ata7: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xE487
scsi8 : sata_nv
ata8: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xE087
ACPI: PCI Interrupt Link [ISI1] enabled at IRQ 46
GSI 21 sharing vector 0x82 and IRQ 21
ACPI: PCI Interrupt 0000:80:05.1[B] -> Link [ISI1] -> GSI 46 (level, low) -> IRQ 130
ata9: SATA max UDMA/133 cmd 0xD880 ctl 0xD802 bmdma 0xD080 irq 130
ata10: SATA max UDMA/133 cmd 0xD480 ctl 0xD402 bmdma 0xD088 irq 130
scsi9 : sata_nv
ata9: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xD887
scsi10 : sata_nv
ata10: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xD487
ACPI: PCI Interrupt Link [ISI2] enabled at IRQ 45
GSI 22 sharing vector 0x8A and IRQ 22
ACPI: PCI Interrupt 0000:80:05.2[C] -> Link [ISI2] -> GSI 45 (level, low) -> IRQ 138
ata11: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC480 irq 138
ata12: SATA max UDMA/133 cmd 0xC880 ctl 0xC802 bmdma 0xC488 irq 138
scsi11 : sata_nv
ata11: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xD007
scsi12 : sata_nv
ata12: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xC887
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda1: orphan cleanup on readonly fs
EXT3-fs: sda1: 25 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
audit(1163769770.617:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1481 types, 152 bools, 1 sens, 256 cats
security:  58 classes, 43474 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1163769770.723:3): policy loaded auid=4294967295
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts





-- 
 "Developers are like artists; they produce their best work if they
  have the freedom to do so" - Werner Vogels, CTO Amazon.com
