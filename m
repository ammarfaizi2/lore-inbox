Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTDGVrV (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTDGVrU (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:47:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:43685 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263697AbTDGVqX (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:46:23 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
To: andrew <akpm@digeo.com>
Subject: More Testing with 4000 disks
Date: Mon, 7 Apr 2003 13:54:49 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_D7UZPB6981S3MHZUZOYK"
Message-Id: <200304071454.49849.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_D7UZPB6981S3MHZUZOYK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is more on testing with simulated 4000 disks.

I mounted 4000 simulated (scsi_debug) disks. But
when I tried to do IO on 200 of them (just reads),
system is 100% busy. Here are the vmstat,
10-sec profile output and sysrq-t output.

I am wondering why 100% sys ?

vmstat:
--------

178 23  8      0 3381260  60392 147608    0    0 88786    10 1015 11314  =
0 100  0
177 24  8      0 3381252  60392 147608    0    0 88947    20 1022 11335  =
0 100  0
182 19  8      0 3381188  60400 147600    0    0 89301    16 1017 11368  =
0 100  0
179 23  8      0 3381180  60400 147600    0    0 89348     5 1011 11367  =
0 100  0
176 26  8      0 3381116  60400 147600    0    0 88906     3 1008 11311  =
0 100  0
184 18  8      0 3381180  60400 147600    0    0 88734     5 1008 11312  =
0 100  0

10-second profile output:
----------------------------

c0109224 ret_from_intr                                 1   0.0357
c01105e0 restore_fpu                                   1   0.0312
c0110a50 save_i387                                     1   0.0052
c0114820 flush_tlb_mm                                  1   0.0089
c01160c0 do_irq_balance                                1   0.0007
c011d8c0 prepare_to_wait_exclusive                     1   0.0063
c011dd50 copy_mm                                       1   0.0009
c011e300 copy_files                                    1   0.0012
c0120ee0 release_task                                  1   0.0023
c0121ad0 exit_notify                                   1   0.0006
c0124080 tasklet_action                                1   0.0045
c0127b80 del_timer_sync                                1   0.0063
c012c0d0 do_sigaction                                  1   0.0010
c012c7a0 sys_rt_sigaction                              1   0.0048
c01187f0 pgd_ctor                                      2   0.0417
c011d820 prepare_to_wait                               2   0.0125
c011d960 finish_wait                                   2   0.0114
c0123430 sys_time                                      2   0.0250
c0127690 add_timer_on                                  2   0.0096
c0128490 schedule_timeout                              2   0.0104
c0105000 _stext                                        4   0.0357
c01092fc syscall_call                                  4   0.3636
c01188b0 do_page_fault                                 4   0.0038
c0107980 get_wchan                                     5   0.0446
c010b270 handle_IRQ_event                              5   0.0521
c011d680 add_wait_queue                                5   0.0347
c01197d0 kunmap_atomic                                10   0.0893
c011d7a0 remove_wait_queue                            10   0.0781
c011fb10 do_syslog                                    10   0.0079
c011b440 __wake_up                                    46   0.2396
c0109307 syscall_exit                                 55   5.0000
c011d4e0 __might_sleep                               104   1.0833
c01092d0 system_call                                 180   4.0909
c01280c0 run_timer_softirq                           323   0.6309
c011c910 io_schedule                                 324   5.0625
c01275b0 add_timer                                   334   1.4911
c0123d60 current_kernel_time                         608   7.6000
c0123e00 do_softirq                                  782   3.7596
c011ae80 schedule                                   2205   1.6406
00000000 total                                      5044   0.0310



--------------Boundary-00=_D7UZPB6981S3MHZUZOYK
Content-Type: text/plain;
  charset="us-ascii";
  name="stacks.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="stacks.out"

 SysRq : Show State
 
                                                sibling
   task             PC      pid father child younger older
 init          S C3856B00     1      0     2               (NOTLB)
 Call Trace:
  [<c0127659>] add_timer+0xa9/0xe0
  [<c0128529>] schedule_timeout+0x99/0xc0
  [<c0128480>] process_timeout+0x0/0x10
  [<c01686a7>] do_select+0x247/0x280
  [<c01682e0>] __pollwait+0x0/0xa0
  [<c0168a29>] sys_select+0x319/0x470
  [<c015f7b2>] sys_stat64+0x22/0x30
  [<c0109303>] syscall_call+0x7/0xb
 
 migration/0   S F7F89FB8     2      1             3       (L-TLB)
 Call Trace:
  [<c011b610>] complete+0x50/0x90
  [<c011d081>] migration_thread+0x121/0x4e0
  [<c010932a>] work_resched+0x5/0x16
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 ksoftirqd/0   R 00000001     3      1             4     2 (L-TLB)
 Call Trace:
  [<c01243b5>] ksoftirqd+0x85/0xe0
  [<c0124330>] ksoftirqd+0x0/0xe0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 migration/1   S 00000001     4      1             5     3 (L-TLB)
 Call Trace:
  [<c011d081>] migration_thread+0x121/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 ksoftirqd/1   R 00000001     5      1             6     4 (L-TLB)
 Call Trace:
  [<c01243b5>] ksoftirqd+0x85/0xe0
  [<c0124330>] ksoftirqd+0x0/0xe0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 migration/2   S 00000001     6      1             7     5 (L-TLB)
 Call Trace:
  [<c011d081>] migration_thread+0x121/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 ksoftirqd/2   R 00000001     7      1             8     6 (L-TLB)
 Call Trace:
  [<c01243b5>] ksoftirqd+0x85/0xe0
  [<c0124330>] ksoftirqd+0x0/0xe0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 migration/3   S 00000001     8      1             9     7 (L-TLB)
 Call Trace:
  [<c011d081>] migration_thread+0x121/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 ksoftirqd/3   R 00000001     9      1            10     8 (L-TLB)
 Call Trace:
  [<c01243b5>] ksoftirqd+0x85/0xe0
  [<c0124330>] ksoftirqd+0x0/0xe0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 migration/4   S 00000001    10      1            11     9 (L-TLB)
 Call Trace:
  [<c011d081>] migration_thread+0x121/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 ksoftirqd/4   R 00000001    11      1            12    10 (L-TLB)
 Call Trace:
  [<c01243b5>] ksoftirqd+0x85/0xe0
  [<c0124330>] ksoftirqd+0x0/0xe0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 migration/5   S 00000001    12      1            13    11 (L-TLB)
 Call Trace:
  [<c011d081>] migration_thread+0x121/0x4e0
  [<c010932a>] work_resched+0x5/0x16
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 ksoftirqd/5   R 00000001    13      1            14    12 (L-TLB)
 Call Trace:
  [<c01243b5>] ksoftirqd+0x85/0xe0
  [<c0124330>] ksoftirqd+0x0/0xe0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 migration/6   S 00000001    14      1            15    13 (L-TLB)
 Call Trace:
  [<c011d081>] migration_thread+0x121/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 ksoftirqd/6   R 00000001    15      1            16    14 (L-TLB)
 Call Trace:
  [<c01243b5>] ksoftirqd+0x85/0xe0
  [<c0124330>] ksoftirqd+0x0/0xe0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 migration/7   S 00000001    16      1            17    15 (L-TLB)
 Call Trace:
  [<c011d081>] migration_thread+0x121/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c011cf60>] migration_thread+0x0/0x4e0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 ksoftirqd/7   R 00000001    17      1            18    16 (L-TLB)
 Call Trace:
  [<c01243b5>] ksoftirqd+0x85/0xe0
  [<c0124330>] ksoftirqd+0x0/0xe0
  [<c0107155>] kernel_thread_helper+0x5/0x10
 
 events/0      S C011B4CA    18      1            19    17 (L-TLB)
 Call Trace:
  [<c011b4ca>] __wake_up+0x8a/0xc0
  [<c012f48b>] worker_thread+0x13b/0x320
  [<c021dfb0>] batch_entropy_process+0x0/0xb0
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c011b3c0>] default_wake_function+0x0/0x20
 <4chedule_timeout+0x14/0xc0
  [<c0218419>] tty_poll+0x79/0x90
  [<c0335759>] sock_poll+0x19/0x20
  [<c01686a7>] do_select+0x247/0x280
  [<c01682e0>] __pollwait+0x0/0xa0
  [<c0168a29>] sys_select+0x319/0x470
  [<c011b267>] schedule+0x3e7/0x540
  [<c0109303>] syscall_call+0x7/0xb
 
 login         S E6696000  9573   9572  9574               (NOTLB)
 Call Trace:
  [<c0122f77>] sys_wait4+0x237/0x270
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c011b267>] schedule+0x3e7/0x540
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c0109303>] syscall_call+0x7/0xb
 
 bash          S C0218A7F  9574   9573  9600               (NOTLB)
 Call Trace:
  [<c0218a7f>] tiocspgrp+0x6f/0x90
  [<c0122f77>] sys_wait4+0x237/0x270
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c0109303>] syscall_call+0x7/0xb
 
 su            S E663E000  9600   9574  9601               (NOTLB)
 Call Trace:
  [<c0122f77>] sys_wait4+0x237/0x270
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c0109303>] syscall_call+0x7/0xb
 
 bash          S C0218A7F  9601   9600 14110               (NOTLB)
 Call Trace:
  [<c0218a7f>] tiocspgrp+0x6f/0x90
  [<c0122f77>] sys_wait4+0x237/0x270
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R FFFFFFEF 13898      1         13899  8965 (NOTLB)
 Call Trace:
  [<c013fda6>] kfree+0x246/0x2a0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 13899      1         13900 13898 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            D 00000000 13900      1         13901 13899 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c01282fe>] do_timer+0x2e/0xc0
  [<c010fa00>] timer_interrupt+0x110/0x1f0
  [<c010b2aa>] handle_IRQ_event+0x3a/0x60
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c0109c70>] common_interrupt+0x18/0x20
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 13947      1         13948 13946 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 13948      1         13949 13947 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 13949      1         13950 13948 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0171ea4>] dnotify_parent+0xf4/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 13950      1         13951 13949 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c01282fe>] do_timer+0x2e/0xc0
  [<c010fa00>] timer_interrupt+0x110/0x1f0
  [<c0127f56>] update_wall_time+0x16/0x50
  [<c01282fe>] do_timer+0x2e/0xc0
  [<c010fa00>] timer_interrupt+0x110/0x1f0
  [<c010b62c>] do_IRQ+0x17c/0x1f0
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c010b2a57cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 13994      1         13995 13993 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 13995      1         13996 13994 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 13996      1         13997 13995 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0171e0e>] dnotify_parent+0x5e/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 13997      1         13998 13996 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>]0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c015007b>] shmem_fill_super+0x13b/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R FFFFFFEF 14039      1         14040 14038 (NOTLB)
 Call Trace:
  [<c02570e6>] generic_unplug_device+0xc6/0xd0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c01388f0>] generic_file_read+0x0/0xa0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c01388f0>] generic_file_read+0x0/0xa0
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14040      1         14041 14039 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e81>] dio_await_one+0xb1/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            D 00000000 14041      1         14042 14040 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            D FFFFFFEF 14042      1         14043 14041 (NOTLB)
 Call Trace:
  [<c02570e6>] generic_unplug_device+0xc6/0xd0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c011525a>] smp_apic_timer_xt2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R FFFFFFEF 14068      1         14069 14067 (NOTLB)
 Call Trace:
  [<c02570e6>] generic_unplug_device+0xc6/0xd0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14069      1         14070 14068 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14070      1         14071 14069 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14071      1         14072 14070 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c015007b>] shmem_fill_super+0x13b/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R FFFFFFEF 14072      1         14073 14071 (NOTLB)
 Call Trace:
  [<c02570e6>] generic_unplug_device+0xc6/0xd0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14073      1         14074 14072 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0171df4>] dnotify_parent+0x44/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14074      1         14075 14073 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0293614>] scsi_end_request+0xe4/0xf0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c0109c92>] reschedule_interrupt+0x1a/0x20
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14075      1         14076 14074 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c012f230>] delayed_work_timer_fn+0x0/0xa0
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0171e0e>] dnotify_parent+0x5e/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14076      1         14077 14075 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14077      1         14078 14076 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14078      1         14079 14077 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c015007b>] shmem_fill_super+0x13b/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14079      1         14080 14078 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14080      1         14081 14079 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c011007b>] sys_ipc+0x3b/0x1f0
  [<c0171df4>] dnotify_parent+0x44/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            D 00000000 14081      1         14082 14080 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            D 00000000 14082      1         14083 14081 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c011b4ca>] __wake_up+0x8a/0xc0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14083      1         14084 14082 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c01388f0>] generic_file_read+0x0/0xa0
  [<c01388f1>] generic_file_read+0x1/0xa0
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14084      1         14085 14083 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14085      1         14086 14084 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            D 00000000 14086      1         14087 14085 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14087      1         14088 14086 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0293614>] scsi_end_request+0xe4/0xf0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R FFFFFFEF 14088      1         14089 14087 (NOTLB)
 Call Trace:
  [<c02570e6>] generic_unplug_device+0xc6/0xd0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0171e08>] dnotify_parent+0x58/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14089      1         14090 14088 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14090      1         14091 14089 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c029007b>] ioctl_probe+0x5b/0xa0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c01282fe>] do_timer+0x2e/0xc0
  [<c010b2aa>] handle_IRQ_event+0x3a/0x60
  [<c010b5c2>] do_IRQ+0x112/0x1f0
  [<c010b62c>] do_IRQ+0x17c/0x1f0
  [<c0109c70>] common_interrupt+0x18/0x20
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14091      1         14092 14090 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c013888f>] __generic_file_aio_read+0x1cf/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14092      1         14093 14091 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01388f0>] generic_file_read+0x0/0xa0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c01388f0>] generic_file_read+0x0/0xa0
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14093      1         14094 14092 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c02589b9>] submit_bio+0x79/0x90
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0171dc6>] dnotify_parent+0x16/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14094      1         14095 14093 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14095      1         14096 14094 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            D 00000000 14096      1         14097 14095 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14097      1               14096 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0171e0e>] dnotify_parent+0x5e/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 ps            R ED34E084 14110   9601                     (NOTLB)
 Call Trace:
  [<c010932a>] work_resched+0x5/0x16
 
 prof          S EBECE000 14111   1108 14112   14113       (NOTLB)
 Call Trace:
  [<c0122f77>] sys_wait4+0x237/0x270
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c0109303>] syscall_call+0x7/0xb
 
 prof          R C013D50E 14112  14111                     (NOTLB)
 Call Trace:
  [<c013d50e>] do_page_cache_readahead+0x16e/0x1b0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0137e95>] __lock_page+0xb5/0xe0
  [<c011da10>] autoremove_wake_function+0x0/0x40
  [<c013d637>] page_cache_readahead+0xe7/0x160
  [<c011da10>] autoremove_wake_function+0x0/0x40
  [<c01383df>] do_generic_mapping_read+0x19f/0x3b0
  [<c01385f0>] file_read_actor+0x0/0xd0
  [<c0138875>] __generic_file_aio_read+0x1b5/0x1e0
  [<c01385f0>] file_read_actor+0x0/0xd0
  [<c01388e8>] generic_file_aio_read+0x48/0x50
  [<c0155cde>] do_sync_read+0x7e/0xb0
  [<c013dc59>] check_poison_obj+0x39/0x190
  [<c013f614>] kmem_cache_alloc+0xa4/0x150
  [<c013ec2a>] cache_grow+0x22a/0x340
  [<c013f6aa>] kmem_cache_alloc+0x13a/0x150
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c013f6aa>] kmem_cache_alloc+0x13a/0x150
  [<c0118830>] pgd_alloc+0x10/0x20
  [<c013dc59>] check_poison_obj+0x39/0x190
  [<c016043d>] kernel_read+0x3d/0x50
  [<c0161222>] prepare_binprm+0xc2/0xd0
  [<c015fd64>] count+0x34/0x50
  [<c016176c>] do_execve+0x10c/0x200
  [<c0162eee>] getname+0x5e/0xa0
  [<c0107940>] sys_execve+0x30/0x70
  [<c0109303>] syscall_call+0x7/0xb
 
 cat           R ED3FC084 14113   1108               14111 (NOTLB)
 Call Trace:
  [<c01188b0>] do_page_fault+0x0/0x41e
  [<c010932a>] work_resched+0x5/0x16
 
 crond         S C02081D0 14114    910 14115               (NOTLB)
 Call Trace:
  [<c02081d0>] rb_insert_color+0x70/0xf0
  [<c0162028>] pipe_wait+0x98/0xd0
  [<c011da10>] autoremove_wake_function+0x0/0x40
  [<c011da10>] autoremove_wake_function+0x0/0x40
  [<c0148c35>] do_mmap_pgoff+0x495/0x5f0
  [<c0162248>] pipe_read+0x1e8/0x260
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c0155bf7>] sys_llseek+0x67/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 sa1           R 40017000 14115  14114                     (NOTLB)
 Call Trace:
  [<c010932a>] work_resched+0x5/0x16
 
 atkbd.c: Unknown key (set 2, scancode 0x1b7, on isa0060/serio0) pressed.
 rect_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0171df4>] dnotify_parent+0x44/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14064      1         14065 14063 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c017007b>] igrab+0x2b/0xa0
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14065      1         14066 14064 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 0804B000 14066      1         14067 14065 (NOTLB)
 Call Trace:
  [<c010932a>] work_resched+0x5/0x16
 
 io            R 00000000 14067      1         14068 14066 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14068      1         14069 14067 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14069      1         14070 14068 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c015007b>] shmem_fill_super+0x13b/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14070      1         14071 14069 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14071      1         14072 14070 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R FFFFFFEF 14072      1         14073 14071 (NOTLB)
 Call Trace:
  [<c02570e6>] generic_unplug_device+0xc6/0xd0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0293614>] scsi_end_request+0xe4/0xf0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            D 00000000 14073      1         14074 14072 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c015007b>] shmem_fill_super+0x13b/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14074      1         14075 14073 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c011007b>] sys_ipc+0x3b/0x1f0
  [<c0171df4>] dnotify_parent+0x44/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14075      1         14076 14074 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R FFFFFFEF 14076      1         14077 14075 (NOTLB)
 Call Trace:
  [<c02570e6>] generic_unplug_device+0xc6/0xd0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14077      1         14078 14076 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0109c92>] reschedule_interrupt+0x1a/0x20
  [<c028007b>] show_driver+0x1b/0x30
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14078      1         14079 14077 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14079      1         14080 14078 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 0804B000 14080      1         14081 14079 (NOTLB)
 Call Trace:
  [<c010932a>] work_resched+0x5/0x16
 
 io            R 00000000 14081      1         14082 14080 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            D 00000000 14082      1         14083 14081 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c011007b>] sys_ipc+0x3b/0x1f0
  [<c0171e94>] dnotify_parent+0xe4/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 0804B000 14083      1         14084 14082 (NOTLB)
 Call Trace:
  [<c010932a>] work_resched+0x5/0x16
 
 io            R 00000000 14084      1         14085 14083 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14085      1         14086 14084 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c01282fe>] do_timer+0x2e/0xc0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14086      1         14087 14085 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14087      1         14088 14086 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179b85>] direct_io_worker+0x265/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14088      1         14089 14087 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0293614>] scsi_end_request+0xe4/0xf0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14089      1         14090 14088 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14090      1         14091 14089 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c0127f56>] update_wall_time+0x16/0x50
  [<c01282fe>] do_timer+0x2e/0xc0
  [<c010fa00>] timer_interrupt+0x110/0x1f0
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0171e05>] dnotify_parent+0x55/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c0109c70>] common_interrupt+0x18/0x20
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14091      1         14092 14090 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14092      1         14093 14091 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R FFFFFFEF 14093      1         14094 14092 (NOTLB)
 Call Trace:
  [<c02570e6>] generic_unplug_device+0xc6/0xd0
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14094      1         14095 14093 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c02939bb>] scsi_io_completion+0x1eb/0x420
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c028e5e2>] scsi_finish_command+0x82/0x90
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14095      1         14096 14094 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0171e77>] dnotify_parent+0xc7/0x100
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c011b267>] schedule+0x3e7/0x540
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14096      1         14097 14095 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c028e4e6>] scsi_softirq+0xb6/0x100
  [<c0123e6b>] do_softirq+0x6b/0xd0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 io            R 00000000 14097      1               14096 (NOTLB)
 Call Trace:
  [<c011c93b>] io_schedule+0x2b/0x40
  [<c0178e86>] dio_await_one+0xb6/0x170
  [<c017902d>] dio_await_completion+0x1d/0x40
  [<c0179bfe>] direct_io_worker+0x2de/0x350
  [<c0179da9>] blockdev_direct_IO+0x139/0x14c
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c01a7347>] ext2_direct_IO+0x47/0x50
  [<c01a72c0>] ext2_get_blocks+0x0/0x40
  [<c013a0fc>] generic_file_direct_IO+0x5c/0x80
  [<c013878b>] __generic_file_aio_read+0xcb/0x1e0
  [<c0138968>] generic_file_read+0x78/0xa0
  [<c011525a>] smp_apic_timer_interrupt+0x14a/0x160
  [<c02bbd93>] sd_rw_intr+0x1f3/0x200
  [<c0109cf2>] apic_timer_interrupt+0x1a/0x20
  [<c028007b>] show_driver+0x1b/0x30
  [<c0138980>] generic_file_read+0x90/0xa0
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c01557cd>] generic_file_llseek+0x2d/0xd0
  [<c01557a0>] generic_file_llseek+0x0/0xd0
  [<c0155faa>] sys_read+0x2a/0x40
  [<c0109303>] syscall_call+0x7/0xb
 
 prof          S EBECE000 14111   1108 14117               (NOTLB)
 Call Trace:
  [<c0122f77>] sys_wait4+0x237/0x270
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c011b3c0>] default_wake_function+0x0/0x20
  [<c0109303>] syscall_call+0x7/0xb
 
 prof          R C38591A4 14117  14111                     (NOTLB)
 Call Trace:
  [<c01382f4>] do_generic_mapping_read+0xb4/0x3b0
  [<c01385f0>] file_read_actor+0x0/0xd0
  [<c0138875>] __generic_file_aio_read+0x1b5/0x1e0
  [<c01385f0>] file_read_actor+0x0/0xd0
  [<c01388e8>] generic_file_aio_read+0x48/0x50
  [<c0155cde>] do_sync_read+0x7e/0xb0
  [<c0195ff9>] __ext3_journal_stop+0x19/0x40
  [<c019262b>] ext3_dirty_inode+0x5b/0x70
  [<c013dc59>] check_poison_obj+0x39/0x190
  [<c013f6aa>] kmem_cache_alloc+0x13a/0x150
  [<c0156a27>] get_empty_filp+0x47/0xe0
  [<c0164020>] link_path_walk+0x850/0xa30
  [<c0155dba>] vfs_read+0xaa/0xe0
  [<c016043d>] kernel_read+0x3d/0x50
  [<c0180662>] load_elf_binary+0x2c2/0xa10
  [<c0256ee0>] blk_plug_device+0xc0/0x100
  [<c0293f8f>] scsi_request_fn+0x12f/0x280
  [<c01443e0>] page_address+0x50/0xf0
  [<c01443e0>] page_address+0x50/0xf0
  [<c0143ade>] kmap_high+0x4e/0x280
  [<c0143d5e>] kunmap_high+0x4e/0xf0
  [<c01614e9>] search_binary_handler+0xb9/0x230
  [<c015fff7>] copy_strings_kernel+0x27/0x30
  [<c01617df>] do_execve+0x17f/0x200
  [<c0162eee>] getname+0x5e/0xa0
  [<c0107940>] sys_execve+0x30/0x70
  [<c0109303>] syscall_call+0x7/0xb

--------------Boundary-00=_D7UZPB6981S3MHZUZOYK--

