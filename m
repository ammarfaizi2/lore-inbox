Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTJ2E5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 23:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTJ2E5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 23:57:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55462 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261842AbTJ2E5m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 23:57:42 -0500
Date: Wed, 29 Oct 2003 04:57:41 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ernst Herzberg <earny@net4u.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 can't kill process in stat 'R'
Message-ID: <20031029045741.GA7665@parcelfarce.linux.theplanet.co.uk>
References: <200310290508.41096.earny@net4u.de> <200310290537.02548.earny@net4u.de> <20031029044129.GZ7665@parcelfarce.linux.theplanet.co.uk> <200310290547.13047.earny@net4u.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310290547.13047.earny@net4u.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 05:47:13AM +0100, Ernst Herzberg wrote:
> On Mittwoch, 29. Oktober 2003 05:41, you wrote:
> 
> > a) ssh into the box and check the logs
> > (a) is obviously preferable.
> 
> *schäm* 
> 
> 
> Attached :-)

Hmm...  Looks like 3661 is spinning somewhere in ACPI code and so does
ksoftirqd/0...  Relevant parts of the trace are

Oct 29 05:34:54 lidl kernel: kdeinit       R current      0  3661      1          3664  3634 (NOTLB)
Oct 29 05:34:54 lidl kernel: db0fbc90 db0fa000 c02bcfd0 db0fbc90 db0fbc90 db0d007b 0000007b ffffff01 
Oct 29 05:34:54 lidl kernel:        c012754f 00000060 00000203 c04a7d60 c04a8568 00000008 db0fbc90 db0fbc90 
Oct 29 05:34:54 lidl kernel:        db0fbc90 c03e007b 00000001 c04a7ae8 0000000a 00000046 c0123105 c04a7ae8 
Oct 29 05:34:54 lidl kernel: Call Trace:
Oct 29 05:34:54 lidl kernel:  [rh_report_status+0/304] rh_report_status+0x0/0x130
Oct 29 05:34:54 lidl kernel:  [<c02bcfd0>] rh_report_status+0x0/0x130
Oct 29 05:34:54 lidl kernel:  [run_timer_softirq+191/448] run_timer_softirq+0xbf/0x1c0
Oct 29 05:34:54 lidl kernel:  [<c012754f>] run_timer_softirq+0xbf/0x1c0
Oct 29 05:34:54 lidl kernel:  [do_softirq+149/160] do_softirq+0x95/0xa0
Oct 29 05:34:54 lidl kernel:  [<c0123105>] do_softirq+0x95/0xa0
Oct 29 05:34:54 lidl kernel:  [do_IRQ+251/304] do_IRQ+0xfb/0x130
Oct 29 05:34:54 lidl kernel:  [<c010baab>] do_IRQ+0xfb/0x130
Oct 29 05:34:54 lidl kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Oct 29 05:34:54 lidl kernel:  [<c0109d98>] common_interrupt+0x18/0x20
Oct 29 05:34:54 lidl kernel:  [acpi_ut_release_to_cache+70/138] acpi_ut_release_to_cache+0x46/0x8a
Oct 29 05:34:54 lidl kernel:  [<c0234dae>] acpi_ut_release_to_cache+0x46/0x8a
Oct 29 05:34:54 lidl kernel:  [acpi_ds_delete_walk_state+150/154] acpi_ds_delete_walk_state+0x96/0x9a
Oct 29 05:34:54 lidl kernel:  [<c0225483>] acpi_ds_delete_walk_state+0x96/0x9a
Oct 29 05:34:54 lidl kernel:  [acpi_ps_parse_loop+1349/2083] acpi_ps_parse_loop+0x545/0x823
Oct 29 05:34:54 lidl kernel:  [<c0230806>] acpi_ps_parse_loop+0x545/0x823
Oct 29 05:34:54 lidl kernel:  [acpi_ut_acquire_mutex+92/114] acpi_ut_acquire_mutex+0x5c/0x72
Oct 29 05:34:54 lidl kernel:  [<c0235c86>] acpi_ut_acquire_mutex+0x5c/0x72
Oct 29 05:34:54 lidl kernel:  [acpi_ut_release_to_cache+49/138] acpi_ut_release_to_cache+0x31/0x8a
Oct 29 05:34:54 lidl kernel:  [<c0234d99>] acpi_ut_release_to_cache+0x31/0x8a
Oct 29 05:34:54 lidl kernel:  [acpi_ut_release_mutex+103/108] acpi_ut_release_mutex+0x67/0x6c
Oct 29 05:34:54 lidl kernel:  [<c0235d03>] acpi_ut_release_mutex+0x67/0x6c
Oct 29 05:34:54 lidl kernel:  [acpi_ut_delete_generic_state+11/14] acpi_ut_delete_generic_state+0xb/0xe
Oct 29 05:34:54 lidl kernel:  [<c0235e35>] acpi_ut_delete_generic_state+0xb/0xe
Oct 29 05:34:54 lidl kernel:  [acpi_ut_update_object_reference+464/526] acpi_ut_update_object_reference+0x1d0/0x20e
Oct 29 05:34:54 lidl kernel:  [<c0236b37>] acpi_ut_update_object_reference+0x1d0/0x20e
Oct 29 05:34:54 lidl kernel:  [acpi_ut_remove_reference+33/39] acpi_ut_remove_reference+0x21/0x27
Oct 29 05:34:54 lidl kernel:  [acpi_ds_call_control_method+326/385] acpi_ds_call_control_method+0x146/0x181
Oct 29 05:34:54 lidl kernel:  [<c0223eab>] acpi_ds_call_control_method+0x146/0x181
Oct 29 05:34:54 lidl kernel:  [acpi_ps_parse_aml+78/380] acpi_ps_parse_aml+0x4e/0x17c
Oct 29 05:34:54 lidl kernel:  [<c0230b32>] acpi_ps_parse_aml+0x4e/0x17c
Oct 29 05:34:54 lidl kernel:  [acpi_psx_execute+341/416] acpi_psx_execute+0x155/0x1a0
Oct 29 05:34:54 lidl kernel:  [<c02313e1>] acpi_psx_execute+0x155/0x1a0
Oct 29 05:34:54 lidl kernel:  [acpi_ns_execute_control_method+67/82] acpi_ns_execute_control_method+0x43/0x52
Oct 29 05:34:54 lidl kernel:  [<c022e771>] acpi_ns_execute_control_method+0x43/0x52
Oct 29 05:34:54 lidl kernel:  [acpi_ns_evaluate_by_handle+111/147] acpi_ns_evaluate_by_handle+0x6f/0x93
Oct 29 05:34:54 lidl kernel:  [<c022e70a>] acpi_ns_evaluate_by_handle+0x6f/0x93
Oct 29 05:34:54 lidl kernel:  [acpi_ns_evaluate_relative+157/180] acpi_ns_evaluate_relative+0x9d/0xb4
Oct 29 05:34:54 lidl kernel:  [<c022e5fd>] acpi_ns_evaluate_relative+0x9d/0xb4
Oct 29 05:34:54 lidl kernel:  [proc_lookup+188/288] proc_lookup+0xbc/0x120
Oct 29 05:34:54 lidl kernel:  [<c0180a2c>] proc_lookup+0xbc/0x120
Oct 29 05:34:54 lidl kernel:  [acpi_evaluate_object+271/446] acpi_evaluate_object+0x10f/0x1be
Oct 29 05:34:54 lidl kernel:  [<c022defc>] acpi_evaluate_object+0x10f/0x1be
Oct 29 05:34:54 lidl kernel:  [acpi_battery_get_status+100/277] acpi_battery_get_status+0x64/0x115
Oct 29 05:34:54 lidl kernel:  [<c0238a15>] acpi_battery_get_status+0x64/0x115
Oct 29 05:34:54 lidl kernel:  [acpi_battery_read_state+130/594] acpi_battery_read_state+0x82/0x252
Oct 29 05:34:54 lidl kernel:  [<c0238f66>] acpi_battery_read_state+0x82/0x252
Oct 29 05:34:54 lidl kernel:  [proc_file_read+195/640] proc_file_read+0xc3/0x280
Oct 29 05:34:54 lidl kernel:  [<c0180493>] proc_file_read+0xc3/0x280
Oct 29 05:34:54 lidl kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Oct 29 05:34:54 lidl kernel:  [<c01537e8>] vfs_read+0xb8/0x130
Oct 29 05:34:54 lidl kernel:  [sys_read+66/112] sys_read+0x42/0x70
Oct 29 05:34:54 lidl kernel:  [<c0153a92>] sys_read+0x42/0x70
Oct 29 05:34:54 lidl kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 29 05:34:54 lidl kernel:  [<c010942b>] syscall_call+0x7/0xb

Oct 29 05:34:55 lidl kernel: ksoftirqd/0   S 0000210A  7880     2      1             3       (L-TLB)
Oct 29 05:34:55 lidl kernel: dfeedfd4 00000046 c012f3e6 0000210a 00000000 c012f483 dfeedfa4 dfeedfa4 
Oct 29 05:34:55 lidl kernel:        dba78740 00000000 c04a7b08 d87b1940 d87b1960 00000138 e9f49584 0001a2af 
Oct 29 05:34:55 lidl kernel:        dfeec000 dfeec000 ffffe000 00000000 c01234fb dfeef2a0 00000013 c0123450 
Oct 29 05:34:55 lidl kernel: Call Trace:
Oct 29 05:34:55 lidl kernel:  [rcu_check_quiescent_state+118/144] rcu_check_quiescent_state+0x76/0x90
Oct 29 05:34:55 lidl kernel:  [<c012f3e6>] rcu_check_quiescent_state+0x76/0x90
Oct 29 05:34:55 lidl kernel:  [rcu_process_callbacks+131/256] rcu_process_callbacks+0x83/0x100
Oct 29 05:34:55 lidl kernel:  [<c012f483>] rcu_process_callbacks+0x83/0x100
Oct 29 05:34:55 lidl kernel:  [ksoftirqd+171/192] ksoftirqd+0xab/0xc0
Oct 29 05:34:55 lidl kernel:  [<c01234fb>] ksoftirqd+0xab/0xc0
Oct 29 05:34:55 lidl kernel:  [ksoftirqd+0/192] ksoftirqd+0x0/0xc0
Oct 29 05:34:55 lidl kernel:  [<c0123450>] ksoftirqd+0x0/0xc0
Oct 29 05:34:55 lidl kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct 29 05:34:55 lidl kernel:  [<c01072a5>] kernel_thread_helper+0x5/0x10
Oct 29 05:34:55 lidl kernel: 
Oct 29 05:34:55 lidl kernel: events/0      D 6CF2C8B6  6576     3      1             4     2 (L-TLB)
Oct 29 05:34:55 lidl kernel: dfeebcb8 00000046 d93972a0 6cf2c8b6 000165b4 c022dc4d 0000006c 00000003 
Oct 29 05:34:55 lidl kernel:        00000000 6cf2c8b6 000165b4 d93972a0 d93972c0 000a7202 6cf2c8b6 000165b4 
Oct 29 05:34:55 lidl kernel:        dfed66c0 00000286 dfeea000 dfeeec80 c0108175 dfed66c8 00000001 dfeeec80 
Oct 29 05:34:55 lidl kernel: Call Trace:
Oct 29 05:34:55 lidl kernel:  [acpi_ns_search_parent_tree+61/94] acpi_ns_search_parent_tree+0x3d/0x5e
Oct 29 05:34:55 lidl kernel:  [<c022dc4d>] acpi_ns_search_parent_tree+0x3d/0x5e
Oct 29 05:34:55 lidl kernel:  [__down+149/272] __down+0x95/0x110
Oct 29 05:34:55 lidl kernel:  [<c0108175>] __down+0x95/0x110
Oct 29 05:34:55 lidl kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 29 05:34:55 lidl kernel:  [<c011bdb0>] default_wake_function+0x0/0x30
Oct 29 05:34:55 lidl kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
Oct 29 05:34:55 lidl kernel:  [<c010839c>] __down_failed+0x8/0xc
Oct 29 05:34:55 lidl kernel:  [.text.lock.osl+15/50] .text.lock.osl+0xf/0x32
Oct 29 05:34:55 lidl kernel:  [<c02223e5>] .text.lock.osl+0xf/0x32
Oct 29 05:34:55 lidl kernel:  [acpi_ex_system_wait_semaphore+52/72] acpi_ex_system_wait_semaphore+0x34/0x48
Oct 29 05:34:55 lidl kernel:  [<c022a720>] acpi_ex_system_wait_semaphore+0x34/0x48
Oct 29 05:34:55 lidl kernel:  [acpi_ex_acquire_mutex+172/226] acpi_ex_acquire_mutex+0xac/0xe2
Oct 29 05:34:55 lidl kernel:  [<c022bfe2>] acpi_ex_acquire_mutex+0xac/0xe2
Oct 29 05:34:55 lidl kernel:  [acpi_ex_opcode_2A_0T_1R+107/264] acpi_ex_opcode_2A_0T_1R+0x6b/0x108
Oct 29 05:34:55 lidl kernel:  [<c022b713>] acpi_ex_opcode_2A_0T_1R+0x6b/0x108
Oct 29 05:34:55 lidl kernel:  [acpi_ds_exec_end_op+162/552] acpi_ds_exec_end_op+0xa2/0x228
Oct 29 05:34:55 lidl kernel:  [<c02239c6>] acpi_ds_exec_end_op+0xa2/0x228
Oct 29 05:34:55 lidl kernel:  [acpi_ps_parse_loop+1304/2083] acpi_ps_parse_loop+0x518/0x823
Oct 29 05:34:55 lidl kernel:  [<c02307d9>] acpi_ps_parse_loop+0x518/0x823
Oct 29 05:34:55 lidl kernel:  [acpi_ut_acquire_mutex+92/114] acpi_ut_acquire_mutex+0x5c/0x72
Oct 29 05:34:55 lidl kernel:  [<c0235c86>] acpi_ut_acquire_mutex+0x5c/0x72
Oct 29 05:34:55 lidl kernel:  [acpi_ut_release_to_cache+49/138] acpi_ut_release_to_cache+0x31/0x8a
Oct 29 05:34:55 lidl kernel:  [<c0234d99>] acpi_ut_release_to_cache+0x31/0x8a
Oct 29 05:34:55 lidl kernel:  [acpi_ut_release_mutex+103/108] acpi_ut_release_mutex+0x67/0x6c
Oct 29 05:34:55 lidl kernel:  [<c0235d03>] acpi_ut_release_mutex+0x67/0x6c
Oct 29 05:34:55 lidl kernel:  [acpi_ut_delete_generic_state+11/14] acpi_ut_delete_generic_state+0xb/0xe
Oct 29 05:34:55 lidl kernel:  [acpi_ut_update_object_reference+464/526] acpi_ut_update_object_reference+0x1d0/0x20e
Oct 29 05:34:55 lidl kernel:  [<c0236b37>] acpi_ut_update_object_reference+0x1d0/0x20e
Oct 29 05:34:55 lidl kernel:  [acpi_ut_remove_reference+33/39] acpi_ut_remove_reference+0x21/0x27
Oct 29 05:34:55 lidl kernel:  [<c0236bb2>] acpi_ut_remove_reference+0x21/0x27
Oct 29 05:34:55 lidl kernel:  [acpi_ds_call_control_method+326/385] acpi_ds_call_control_method+0x146/0x181
Oct 29 05:34:55 lidl kernel:  [<c0223eab>] acpi_ds_call_control_method+0x146/0x181
Oct 29 05:34:55 lidl kernel:  [acpi_ps_parse_aml+78/380] acpi_ps_parse_aml+0x4e/0x17c
Oct 29 05:34:55 lidl kernel:  [<c0230b32>] acpi_ps_parse_aml+0x4e/0x17c
Oct 29 05:34:55 lidl kernel:  [acpi_psx_execute+341/416] acpi_psx_execute+0x155/0x1a0
Oct 29 05:34:55 lidl kernel:  [<c02313e1>] acpi_psx_execute+0x155/0x1a0
Oct 29 05:34:55 lidl kernel:  [acpi_ns_execute_control_method+67/82] acpi_ns_execute_control_method+0x43/0x52
Oct 29 05:34:55 lidl kernel:  [<c022e771>] acpi_ns_execute_control_method+0x43/0x52
Oct 29 05:34:55 lidl kernel:  [acpi_ns_evaluate_by_handle+111/147] acpi_ns_evaluate_by_handle+0x6f/0x93
Oct 29 05:34:55 lidl kernel:  [<c022e70a>] acpi_ns_evaluate_by_handle+0x6f/0x93
Oct 29 05:34:55 lidl kernel:  [acpi_ns_evaluate_relative+157/180] acpi_ns_evaluate_relative+0x9d/0xb4
Oct 29 05:34:55 lidl kernel:  [<c022e5fd>] acpi_ns_evaluate_relative+0x9d/0xb4
Oct 29 05:34:55 lidl kernel:  [acpi_ut_delete_object_desc+17/20] acpi_ut_delete_object_desc+0x11/0x14
Oct 29 05:34:55 lidl kernel:  [<c0237344>] acpi_ut_delete_object_desc+0x11/0x14
Oct 29 05:34:55 lidl kernel:  [acpi_ut_update_object_reference+464/526] acpi_ut_update_object_reference+0x1d0/0x20e
Oct 29 05:34:55 lidl kernel:  [<c0236b37>] acpi_ut_update_object_reference+0x1d0/0x20e
Oct 29 05:34:55 lidl kernel:  [acpi_ut_acquire_mutex+92/114] acpi_ut_acquire_mutex+0x5c/0x72
Oct 29 05:34:55 lidl kernel:  [<c0235c86>] acpi_ut_acquire_mutex+0x5c/0x72
Oct 29 05:34:55 lidl kernel:  [acpi_evaluate_object+271/446] acpi_evaluate_object+0x10f/0x1be
Oct 29 05:34:55 lidl kernel:  [<c022defc>] acpi_evaluate_object+0x10f/0x1be
Oct 29 05:34:55 lidl kernel:  [acpi_evaluate_integer+52/86] acpi_evaluate_integer+0x34/0x56
Oct 29 05:34:55 lidl kernel:  [<c02226a0>] acpi_evaluate_integer+0x34/0x56
Oct 29 05:34:55 lidl kernel:  [schedule+761/1456] schedule+0x2f9/0x5b0
Oct 29 05:34:55 lidl kernel:  [<c011baa9>] schedule+0x2f9/0x5b0
Oct 29 05:34:55 lidl kernel:  [acpi_thermal_get_temperature+37/58] acpi_thermal_get_temperature+0x25/0x3a
Oct 29 05:34:55 lidl kernel:  [<c023d3c9>] acpi_thermal_get_temperature+0x25/0x3a
Oct 29 05:34:55 lidl kernel:  [acpi_thermal_check+35/567] acpi_thermal_check+0x23/0x237
Oct 29 05:34:55 lidl kernel:  [<c023d97a>] acpi_thermal_check+0x23/0x237
Oct 29 05:34:55 lidl kernel:  [acpi_os_execute_deferred+14/27] acpi_os_execute_deferred+0xe/0x1b
Oct 29 05:34:55 lidl kernel:  [<c022211f>] acpi_os_execute_deferred+0xe/0x1b
Oct 29 05:34:55 lidl kernel:  [worker_thread+477/704] worker_thread+0x1dd/0x2c0
Oct 29 05:34:55 lidl kernel:  [<c012e76d>] worker_thread+0x1dd/0x2c0
Oct 29 05:34:55 lidl kernel:  [acpi_os_execute_deferred+0/27] acpi_os_execute_deferred+0x0/0x1b
Oct 29 05:34:55 lidl kernel:  [<c0222111>] acpi_os_execute_deferred+0x0/0x1b
Oct 29 05:34:55 lidl kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 29 05:34:55 lidl kernel:  [<c011bdb0>] default_wake_function+0x0/0x30
Oct 29 05:34:55 lidl kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Oct 29 05:34:55 lidl kernel:  [<c0109302>] ret_from_fork+0x6/0x14
Oct 29 05:34:55 lidl kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 29 05:34:55 lidl kernel:  [<c011bdb0>] default_wake_function+0x0/0x30
Oct 29 05:34:55 lidl kernel:  [worker_thread+0/704] worker_thread+0x0/0x2c0
Oct 29 05:34:55 lidl kernel:  [<c012e590>] worker_thread+0x0/0x2c0
Oct 29 05:34:55 lidl kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct 29 05:34:55 lidl kernel:  [<c01072a5>] kernel_thread_helper+0x5/0x10
