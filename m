Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTFJNCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTFJNCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:02:50 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:22259 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262598AbTFJNCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:02:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16101.55819.768909.143767@gargle.gargle.HOWL>
Date: Tue, 10 Jun 2003 09:15:55 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.70-mm3 - Oops and hang
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's an oops and hang from /var/log/messages that happened the other
evening.  It kicked in at 4am or so.  This was running 2.5.70-mm3 SMP,
PREEMPT, no ACPI, RAID1 on one pair of disks, not root or /boot.

Here's the messages I got in the messages file.  The system was
completely hung and needed to be reset to recover:

Jun  9 04:02:12 jfsnew kernel: Unable to handle kernel paging request at virtual
 address 6b6b6b6b
Jun  9 04:02:12 jfsnew kernel:  printing eip:
Jun  9 04:02:12 jfsnew kernel: c0133477
Jun  9 04:02:12 jfsnew kernel: *pde = 00000000
Jun  9 04:02:12 jfsnew kernel: Oops: 0000 [#1]
Jun  9 04:02:12 jfsnew kernel: PREEMPTSMP DEBUG_PAGEALLOC
Jun  9 04:02:12 jfsnew kernel: CPU:    1
Jun  9 04:02:12 jfsnew kernel: EIP:    0060:[detach_pid+23/304]    Not tainted V
LI
Jun  9 04:02:12 jfsnew kernel: EIP:    0060:[<c0133477>]    Not tainted VLI
Jun  9 04:02:12 jfsnew kernel: EFLAGS: 00010046
Jun  9 04:02:12 jfsnew kernel: EIP is at detach_pid+0x17/0x130
Jun  9 04:02:12 jfsnew kernel: eax: dfd30050   ebx: 6b6b6b6b   ecx: dfd30100   e
dx: 6b6b6b6b
Jun  9 04:02:12 jfsnew kernel: esi: e3cc6000   edi: 00000000   ebp: 00000000   e
sp: e3cc7f08
Jun  9 04:02:12 jfsnew kernel: ds: 007b   es: 007b   ss: 0068
Jun  9 04:02:12 jfsnew kernel: Process makewhatis (pid: 2446, threadinfo=e3cc600
0 task=e4117000)
Jun  9 04:02:12 jfsnew kernel: Stack: dfd30000 e3cc6000 00000000 c0123a79 dfd300
00 c0123bb3 dfd30000 dfd30000 
Jun  9 04:02:12 jfsnew kernel:        dfd305c4 dfd30000 00000a07 bffff5c8 c01258
cd dfd30000 ea854a74 bffff350 
Jun  9 04:02:12 jfsnew kernel:        dfd300a4 dfd30000 e4117000 00000000 c0125c
75 dfd30000 bffff5c8 00000000 
Jun  9 04:02:12 jfsnew kernel: Call Trace:
Jun  9 04:02:12 jfsnew kernel:  [__unhash_process+57/176] __unhash_process+0x39/
0xb0
Jun  9 04:02:12 jfsnew kernel:  [<c0123a79>] __unhash_process+0x39/0xb0
Jun  9 04:02:12 jfsnew kernel:  [release_task+195/560] release_task+0xc3/0x230
Jun  9 04:02:12 jfsnew kernel:  [<c0123bb3>] release_task+0xc3/0x230
Jun  9 04:02:12 jfsnew kernel:  [wait_task_zombie+397/432] wait_task_zombie+0x18
d/0x1b0
Jun  9 04:02:12 jfsnew kernel:  [<c01258cd>] wait_task_zombie+0x18d/0x1b0
Jun  9 04:02:12 jfsnew kernel:  [sys_wait4+357/640] sys_wait4+0x165/0x280
Jun  9 04:02:12 jfsnew kernel:  [<c0125c75>] sys_wait4+0x165/0x280
Jun  9 04:02:12 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Jun  9 04:02:12 jfsnew kernel:  [<c011da40>] default_wake_function+0x0/0x20
Jun  9 04:02:13 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Jun  9 04:02:13 jfsnew kernel:  [<c011da40>] default_wake_function+0x0/0x20
Jun  9 04:02:13 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun  9 04:02:13 jfsnew kernel:  [<c010af1f>] syscall_call+0x7/0xb
Jun  9 04:02:13 jfsnew kernel: 
Jun  9 04:02:13 jfsnew kernel: Code: 51 08 52 e8 8c cd fe ff 58 5b c3 89 f6 8d b
c 27 00 00 00 00 57 56 53 89 d3 8d 14 9b 8d 04 d0 8d 88 b0 00 00 00 8b 59 08 8b 
51 04 <39> 0a 74 08 0f 0b 8c 00 c8 8f 3a c0 8b 80 b0 00 00 00 39 48 04 
Jun  9 04:02:13 jfsnew kernel:  <6>note: makewhatis[2446] exited with preempt_co
unt 2
Jun  9 04:02:13 jfsnew kernel: Debug: sleeping function called from illegal cont
ext at include/linux/rwsem.h:43
Jun  9 04:02:13 jfsnew kernel: Call Trace:
Jun  9 04:02:13 jfsnew kernel:  [__might_sleep+99/112] __might_sleep+0x63/0x70
Jun  9 04:02:13 jfsnew kernel:  [do_acct_process+381/656] do_acct_process+0x17d/
0x290
Jun  9 04:02:13 jfsnew kernel:  [<c013c0dd>] do_acct_process+0x17d/0x290
Jun  9 04:02:13 jfsnew kernel:  [__wake_up_common+64/96] __wake_up_common+0x40/0
x60
Jun  9 04:02:13 jfsnew kernel:  [<c011daa0>] __wake_up_common+0x40/0x60
Jun  9 04:02:13 jfsnew kernel:  [acct_process+133/223] acct_process+0x85/0xdf
Jun  9 04:02:13 jfsnew kernel:  [<c013c275>] acct_process+0x85/0xdf
Jun  9 04:02:13 jfsnew kernel:  [do_exit+187/1408] do_exit+0xbb/0x580
Jun  9 04:02:13 jfsnew kernel:  [<c0124fbb>] do_exit+0xbb/0x580
Jun  9 04:02:13 jfsnew kernel:  [smp_apic_timer_interrupt+320/352] smp_apic_time
r_interrupt+0x140/0x160
Jun  9 04:02:13 jfsnew kernel:  [<c0118660>] smp_apic_timer_interrupt+0x140/0x16
0
Jun  9 04:02:13 jfsnew kernel:  [__wake_up+109/192] __wake_up+0x6d/0xc0
Jun  9 04:02:13 jfsnew kernel:  [<c011db2d>] __wake_up+0x6d/0xc0
Jun  9 04:02:13 jfsnew kernel:  [apic_timer_interrupt+26/32] apic_timer_interrup
t+0x1a/0x20
Jun  9 04:02:13 jfsnew kernel:  [<c010b90e>] apic_timer_interrupt+0x1a/0x20
Jun  9 04:02:13 jfsnew kernel:  [sys_ptrace+523/1920] sys_ptrace+0x20b/0x780
Jun  9 04:02:13 jfsnew kernel:  [<c011007b>] sys_ptrace+0x20b/0x780
Jun  9 04:02:13 jfsnew kernel:  [die+286/400] die+0x11e/0x190
Jun  9 04:02:13 jfsnew kernel:  [<c010bfae>] die+0x11e/0x190
Jun  9 04:02:13 jfsnew kernel:  [do_page_fault+787/1118] do_page_fault+0x313/0x4
5e
Jun  9 04:02:13 jfsnew kernel:  [<c011b243>] do_page_fault+0x313/0x45e
Jun  9 04:02:13 jfsnew kernel:  [do_softirq+107/208] do_softirq+0x6b/0xd0
Jun  9 04:02:13 jfsnew kernel:  [<c0126c3b>] do_softirq+0x6b/0xd0
Jun  9 04:02:13 jfsnew kernel:  [free_pages_bulk+411/656] free_pages_bulk+0x19b/
0x290
Jun  9 04:02:13 jfsnew kernel:  [<c014033b>] free_pages_bulk+0x19b/0x290
Jun  9 04:02:13 jfsnew kernel:  [kmem_cache_free+496/608] kmem_cache_free+0x1f0/
0x260
Jun  9 04:02:13 jfsnew kernel:  [<c0145990>] kmem_cache_free+0x1f0/0x260
Jun  9 04:02:13 jfsnew kernel:  [free_task_struct+44/128] free_task_struct+0x2c/
0x80
Jun  9 04:02:13 jfsnew kernel:  [<c012018c>] free_task_struct+0x2c/0x80
Jun  9 04:02:13 jfsnew kernel:  [do_page_fault+0/1118] do_page_fault+0x0/0x45e
Jun  9 04:02:13 jfsnew kernel:  [<c011af30>] do_page_fault+0x0/0x45e
Jun  9 04:02:13 jfsnew kernel:  [error_code+45/56] error_code+0x2d/0x38
Jun  9 04:02:13 jfsnew kernel:  [<c010b989>] error_code+0x2d/0x38
Jun  9 04:02:13 jfsnew kernel:  [detach_pid+23/304] detach_pid+0x17/0x130
Jun  9 04:02:13 jfsnew kernel:  [<c0133477>] detach_pid+0x17/0x130
Jun  9 04:02:13 jfsnew kernel:  [__unhash_process+57/176] __unhash_process+0x39/
0xb0
Jun  9 04:02:13 jfsnew kernel:  [<c0123a79>] __unhash_process+0x39/0xb0
Jun  9 04:02:13 jfsnew kernel:  [release_task+195/560] release_task+0xc3/0x230
Jun  9 04:02:13 jfsnew kernel:  [<c0123bb3>] release_task+0xc3/0x230
Jun  9 04:02:13 jfsnew kernel:  [wait_task_zombie+397/432] wait_task_zombie+0x18
d/0x1b0
Jun  9 04:02:13 jfsnew kernel:  [<c01258cd>] wait_task_zombie+0x18d/0x1b0
Jun  9 04:02:13 jfsnew kernel:  [sys_wait4+357/640] sys_wait4+0x165/0x280
Jun  9 04:02:13 jfsnew kernel:  [<c0125c75>] sys_wait4+0x165/0x280
Jun  9 04:02:13 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Jun  9 04:02:13 jfsnew kernel:  [<c011da40>] default_wake_function+0x0/0x20
Jun  9 04:02:13 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Jun  9 04:02:13 jfsnew kernel:  [<c011da40>] default_wake_function+0x0/0x20
Jun  9 04:02:13 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun  9 04:02:13 jfsnew kernel:  [<c010af1f>] syscall_call+0x7/0xb
Jun  9 04:02:13 jfsnew kernel: 
Jun  9 04:02:13 jfsnew kernel: bad: scheduling while atomic!
Jun  9 04:02:13 jfsnew kernel: Call Trace:
Jun  9 04:02:13 jfsnew kernel:  [schedule+61/1424] schedule+0x3d/0x590
Jun  9 04:02:13 jfsnew kernel:  [<c011d49d>] schedule+0x3d/0x590
Jun  9 04:02:13 jfsnew kernel:  [balance_dirty_pages_ratelimited+162/176] balanc
e_dirty_pages_ratelimited+0xa2/0xb0
Jun  9 04:02:13 jfsnew kernel:  [<c0141d82>] balance_dirty_pages_ratelimited+0xa
2/0xb0
Jun  9 04:02:13 jfsnew kernel:  [generic_file_aio_write_nolock+2438/2736] generi
c_file_aio_write_nolock+0x986/0xab0
Jun  9 04:02:14 jfsnew kernel:  [<c013ed56>] generic_file_aio_write_nolock+0x986
/0xab0
Jun  9 04:02:14 jfsnew kernel:  [scsi_delete_timer+15/80] scsi_delete_timer+0xf/
0x50
Jun  9 04:02:14 jfsnew kernel:  [<c02c87cf>] scsi_delete_timer+0xf/0x50
Jun  9 04:02:14 jfsnew kernel:  [rcu_process_callbacks+438/480] rcu_process_call
backs+0x1b6/0x1e0
Jun  9 04:02:14 jfsnew kernel:  [<c0133b26>] rcu_process_callbacks+0x1b6/0x1e0
Jun  9 04:02:14 jfsnew kernel:  [vt_console_print+105/688] vt_console_print+0x69
/0x2b0
Jun  9 04:02:14 jfsnew kernel:  [<c0270339>] vt_console_print+0x69/0x2b0
Jun  9 04:02:14 jfsnew kernel:  [vt_console_print+105/688] vt_console_print+0x69
/0x2b0
Jun  9 04:02:14 jfsnew kernel:  [<c0270339>] vt_console_print+0x69/0x2b0
Jun  9 04:02:14 jfsnew kernel:  [__call_console_drivers+70/96] __call_console_dr
ivers+0x46/0x60
Jun  9 04:02:14 jfsnew kernel:  [<c0123016>] __call_console_drivers+0x46/0x60
Jun  9 04:02:14 jfsnew kernel:  [call_console_drivers+235/256] call_console_driv
ers+0xeb/0x100
Jun  9 04:02:14 jfsnew kernel:  [<c012318b>] call_console_drivers+0xeb/0x100
Jun  9 04:02:14 jfsnew kernel:  [generic_file_aio_write+149/256] generic_file_ai
o_write+0x95/0x100
Jun  9 04:02:14 jfsnew kernel:  [<c013efd5>] generic_file_aio_write+0x95/0x100
Jun  9 04:02:14 jfsnew kernel:  [ext3_file_write+42/176] ext3_file_write+0x2a/0x
b0
Jun  9 04:02:14 jfsnew kernel:  [<c0198e2a>] ext3_file_write+0x2a/0xb0
Jun  9 04:02:14 jfsnew kernel:  [do_sync_write+170/224] do_sync_write+0xaa/0xe0
Jun  9 04:02:14 jfsnew kernel:  [<c015c2fa>] do_sync_write+0xaa/0xe0
Jun  9 04:02:14 jfsnew kernel:  [autoremove_wake_function+0/64] autoremove_wake_
function+0x0/0x40
Jun  9 04:02:14 jfsnew kernel:  [<c01206e0>] autoremove_wake_function+0x0/0x40
Jun  9 04:02:14 jfsnew kernel:  [call_console_drivers+235/256] call_console_driv
ers+0xeb/0x100
Jun  9 04:02:14 jfsnew kernel:  [<c012318b>] call_console_drivers+0xeb/0x100
Jun  9 04:02:14 jfsnew kernel:  [release_console_sem+323/400] release_console_se
m+0x143/0x190
Jun  9 04:02:14 jfsnew kernel:  [<c0123633>] release_console_sem+0x143/0x190
Jun  9 04:02:14 jfsnew kernel:  [printk+559/656] printk+0x22f/0x290
Jun  9 04:02:14 jfsnew kernel:  [<c012343f>] printk+0x22f/0x290
Jun  9 04:02:14 jfsnew kernel:  [show_trace+131/144] show_trace+0x83/0x90
Jun  9 04:02:14 jfsnew kernel:  [<c010bbc3>] show_trace+0x83/0x90
Jun  9 04:02:14 jfsnew kernel:  [dump_stack+11/16] dump_stack+0xb/0x10
Jun  9 04:02:14 jfsnew kernel:  [<c010bc8b>] dump_stack+0xb/0x10
Jun  9 04:02:14 jfsnew kernel:  [do_acct_process+632/656] do_acct_process+0x278/
0x290
Jun  9 04:02:14 jfsnew kernel:  [<c013c1d8>] do_acct_process+0x278/0x290
Jun  9 04:02:14 jfsnew kernel:  [__wake_up_common+64/96] __wake_up_common+0x40/0
x60
Jun  9 04:02:14 jfsnew kernel:  [<c011daa0>] __wake_up_common+0x40/0x60
Jun  9 04:02:14 jfsnew kernel:  [acct_process+133/223] acct_process+0x85/0xdf
Jun  9 04:02:14 jfsnew kernel:  [<c013c275>] acct_process+0x85/0xdf
Jun  9 04:02:14 jfsnew kernel:  [do_exit+187/1408] do_exit+0xbb/0x580
Jun  9 04:02:14 jfsnew kernel:  [<c0124fbb>] do_exit+0xbb/0x580
Jun  9 04:02:14 jfsnew kernel:  [smp_apic_timer_interrupt+320/352] smp_apic_time
r_interrupt+0x140/0x160
Jun  9 04:02:14 jfsnew kernel:  [<c0118660>] smp_apic_timer_interrupt+0x140/0x16
0
Jun  9 04:02:14 jfsnew kernel:  [__wake_up+109/192] __wake_up+0x6d/0xc0
Jun  9 04:02:14 jfsnew kernel:  [<c011db2d>] __wake_up+0x6d/0xc0
Jun  9 04:02:14 jfsnew kernel:  [apic_timer_interrupt+26/32] apic_timer_interrup
t+0x1a/0x20
Jun  9 04:02:14 jfsnew kernel:  [<c010b90e>] apic_timer_interrupt+0x1a/0x20
Jun  9 04:02:14 jfsnew kernel:  [sys_ptrace+523/1920] sys_ptrace+0x20b/0x780
Jun  9 04:02:14 jfsnew kernel:  [<c011007b>] sys_ptrace+0x20b/0x780
Jun  9 04:02:14 jfsnew kernel:  [die+286/400] die+0x11e/0x190
Jun  9 04:02:14 jfsnew kernel:  [<c010bfae>] die+0x11e/0x190
Jun  9 04:02:14 jfsnew kernel:  [do_page_fault+787/1118] do_page_fault+0x313/0x4
5e
Jun  9 04:02:14 jfsnew kernel:  [<c011b243>] do_page_fault+0x313/0x45e
Jun  9 04:02:14 jfsnew kernel:  [do_softirq+107/208] do_softirq+0x6b/0xd0
Jun  9 04:02:14 jfsnew kernel:  [<c0126c3b>] do_softirq+0x6b/0xd0
Jun  9 04:02:14 jfsnew kernel:  [free_pages_bulk+411/656] free_pages_bulk+0x19b/
0x290
Jun  9 04:02:14 jfsnew kernel:  [<c014033b>] free_pages_bulk+0x19b/0x290
Jun  9 04:02:14 jfsnew kernel:  [kmem_cache_free+496/608] kmem_cache_free+0x1f0/
0x260
Jun  9 04:02:14 jfsnew kernel:  [<c0145990>] kmem_cache_free+0x1f0/0x260
Jun  9 04:02:14 jfsnew kernel:  [free_task_struct+44/128] free_task_struct+0x2c/
0x80
Jun  9 04:02:14 jfsnew kernel:  [<c012018c>] free_task_struct+0x2c/0x80
Jun  9 04:02:14 jfsnew kernel:  [do_page_fault+0/1118] do_page_fault+0x0/0x45e
Jun  9 04:02:14 jfsnew kernel:  [<c011af30>] do_page_fault+0x0/0x45e
Jun  9 04:02:14 jfsnew kernel:  [error_code+45/56] error_code+0x2d/0x38
Jun  9 04:02:14 jfsnew kernel:  [<c010b989>] error_code+0x2d/0x38
Jun  9 04:02:14 jfsnew kernel:  [detach_pid+23/304] detach_pid+0x17/0x130
Jun  9 04:02:14 jfsnew kernel:  [<c0133477>] detach_pid+0x17/0x130
Jun  9 04:02:14 jfsnew kernel:  [__unhash_process+57/176] __unhash_process+0x39/
0xb0
Jun  9 04:02:14 jfsnew kernel:  [<c0123a79>] __unhash_process+0x39/0xb0
Jun  9 04:02:14 jfsnew kernel:  [release_task+195/560] release_task+0xc3/0x230
Jun  9 04:02:15 jfsnew kernel:  [<c0123bb3>] release_task+0xc3/0x230
Jun  9 04:02:15 jfsnew kernel:  [wait_task_zombie+397/432] wait_task_zombie+0x18
d/0x1b0
Jun  9 04:02:15 jfsnew kernel:  [<c01258cd>] wait_task_zombie+0x18d/0x1b0
Jun  9 04:02:15 jfsnew kernel:  [sys_wait4+357/640] sys_wait4+0x165/0x280
Jun  9 04:02:15 jfsnew kernel:  [<c0125c75>] sys_wait4+0x165/0x280
Jun  9 04:02:15 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Jun  9 04:02:15 jfsnew kernel:  [<c011da40>] default_wake_function+0x0/0x20
Jun  9 04:02:15 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Jun  9 04:02:15 jfsnew kernel:  [<c011da40>] default_wake_function+0x0/0x20
Jun  9 04:02:15 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun  9 04:02:15 jfsnew kernel:  [<c010af1f>] syscall_call+0x7/0xb
Jun  9 04:02:15 jfsnew kernel: 
