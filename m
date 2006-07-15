Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945995AbWGOEBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945995AbWGOEBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 00:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945998AbWGOEBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 00:01:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27037 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1945995AbWGOEBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 00:01:21 -0400
Date: Sat, 15 Jul 2006 00:01:19 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: lockdep warnings during shutdown
Message-ID: <20060715040119.GA3772@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This monster trace happened when I went to power off a box.
(rc1-git5)

		Dave

BUG: warning at kernel/lockdep.c:565/print_infinite_recursion_bug() (Not tainted)

Call Trace:
 [<ffffffff80270865>] show_trace+0xaa/0x23d
 [<ffffffff80270a0d>] dump_stack+0x15/0x17
 [<ffffffff802a9e5d>] print_infinite_recursion_bug+0x45/0x49
 [<ffffffff802aa980>] check_noncircular+0x37/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802aa9d0>] check_noncircular+0x87/0xae
 [<ffffffff802ab290>] __lock_acquire+0x899/0xaab
 [<ffffffff802ab51d>] lock_acquire+0x7b/0xa1
 [<ffffffff802a8069>] down_read+0x3e/0x4a
 [<ffffffff8025186d>] m_start+0x1d/0x4d
 [<ffffffff80243565>] seq_read+0xea/0x29c
 [<ffffffff8020b48d>] vfs_read+0xcc/0x172
 [<ffffffff802122d3>] sys_read+0x47/0x6f
 [<ffffffff80261e1a>] tracesys+0xd1/0xdb

-> #20 (&rq->rq_lock_key#4){++..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff8026986a>] _spin_lock+0x24/0x31
       [<ffffffff8028f591>] double_rq_lock+0x2d/0x33
       [<ffffffff80290952>] rebalance_tick+0x1cb/0x35a
       [<ffffffff80290e25>] scheduler_tick+0x344/0x362
       [<ffffffff8029cc3c>] update_process_times+0x67/0x79
       [<ffffffff8027bfee>] smp_local_timer_interrupt+0x2a/0x50
       [<ffffffff8027c769>] smp_apic_timer_interrupt+0x57/0x62
       [<ffffffff802628ad>] apic_timer_interrupt+0x69/0x70

-> #19 (&rq->rq_lock_key#3){++..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff8026986a>] _spin_lock+0x24/0x31
       [<ffffffff8028f591>] double_rq_lock+0x2d/0x33
       [<ffffffff80290952>] rebalance_tick+0x1cb/0x35a
       [<ffffffff80290e25>] scheduler_tick+0x344/0x362
       [<ffffffff8029cc3c>] update_process_times+0x67/0x79
       [<ffffffff8027bfee>] smp_local_timer_interrupt+0x2a/0x50
       [<ffffffff8027c769>] smp_apic_timer_interrupt+0x57/0x62
       [<ffffffff802628ad>] apic_timer_interrupt+0x69/0x70

-> #18 (&rq->rq_lock_key#2){++..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff8026986a>] _spin_lock+0x24/0x31
       [<ffffffff8028f591>] double_rq_lock+0x2d/0x33
       [<ffffffff8028f735>] __migrate_task+0x63/0xeb
       [<ffffffff80247a77>] migration_thread+0x1e1/0x240
       [<ffffffff802361e9>] kthread+0xff/0x136
       [<ffffffff80262bdd>] child_rip+0x7/0x12

-> #17 (&rq->rq_lock_key){++..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff8026986a>] _spin_lock+0x24/0x31
       [<ffffffff8028fde0>] task_rq_lock+0x41/0x74
       [<ffffffff80249998>] try_to_wake_up+0x26/0x418
       [<ffffffff8028fff6>] wake_up_process+0xf/0x12
       [<ffffffff80223b21>] __up_read+0xcc/0xf4
       [<ffffffff802a80a5>] up_read+0x25/0x2a
       [<ffffffff802ac6d5>] futex_wake+0xd2/0xe5
       [<ffffffff80242534>] do_futex+0x2d2/0x904
       [<ffffffff802adb95>] sys_futex+0x100/0x122
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #16 (&sem->wait_lock){....}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80269c42>] _spin_lock_irqsave+0x2b/0x3c
       [<ffffffff8020ba0f>] __down_read_trylock+0x15/0x46
       [<ffffffff802a8161>] down_read_trylock+0xe/0x3e
       [<ffffffff802317f1>] prune_dcache+0x16d/0x1c9
       [<ffffffff80250982>] shrink_dcache_parent+0x29/0x164
       [<ffffffff8030adc8>] proc_flush_task+0x62/0x200
       [<ffffffff80218e0c>] release_task+0x2d4/0x306
       [<ffffffff8022a457>] do_wait+0x7cc/0xb63
       [<ffffffff802584bd>] sys_wait4+0x27/0x2a
       [<ffffffff80261e19>] tracesys+0xd0/0xdb

-> #15 (&dentry->d_lock){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff8026986a>] _spin_lock+0x24/0x31
       [<ffffffff8023582c>] d_move+0x70/0x408
       [<ffffffff8022d19d>] vfs_rename+0x315/0x46d
       [<ffffffff8023a5c0>] sys_renameat+0x19d/0x21c
       [<ffffffff802eaae2>] sys_rename+0x15/0x18
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #14 (rename_lock){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff8026986a>] _spin_lock+0x24/0x31
       [<ffffffff802357ff>] d_move+0x43/0x408
       [<ffffffff8022d19d>] vfs_rename+0x315/0x46d
       [<ffffffff8023a5c0>] sys_renameat+0x19d/0x21c
       [<ffffffff802eaae2>] sys_rename+0x15/0x18
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #13 (dcache_lock){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff8026986a>] _spin_lock+0x24/0x31
       [<ffffffff802f9f88>] set_dentry_child_flags+0x22/0x173
       [<ffffffff802fa54b>] inotify_add_watch+0xe0/0x1cd
       [<ffffffff8024fb9e>] sys_inotify_add_watch+0x15e/0x1a9
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #12 (&ih->mutex){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80267ffc>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802681d9>] mutex_lock+0x29/0x2e
       [<ffffffff802f9f18>] inotify_find_update_watch+0x4f/0x9d
       [<ffffffff8024fb21>] sys_inotify_add_watch+0xe1/0x1a9
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #11 (&inode->inotify_mutex){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80267ffc>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802681d9>] mutex_lock+0x29/0x2e
       [<ffffffff8025dc3d>] inotify_unmount_inodes+0xbc/0x180
       [<ffffffff802ee531>] invalidate_inodes+0x49/0x155
       [<ffffffff8025da19>] __invalidate_device+0x2f/0x50
       [<ffffffff80345de7>] invalidate_partition+0x31/0x45
       [<ffffffff8030d9e6>] del_gendisk+0x20/0x145
       [<ffffffff8807b4c5>] sd_remove+0x2e/0x6e [sd_mod]
       [<ffffffff803bbe87>] __device_release_driver+0x82/0x9f
       [<ffffffff803bc18e>] device_release_driver+0x3c/0x5e
       [<ffffffff803bb6b4>] bus_remove_device+0xa5/0xbc
       [<ffffffff803ba24d>] device_del+0x149/0x17d
       [<ffffffff880526ab>] __scsi_remove_device+0x3a/0x75 [scsi_mod]
       [<ffffffff8805029b>] scsi_forget_host+0x41/0x6a [scsi_mod]
       [<ffffffff8804aa57>] scsi_remove_host+0x8d/0x126 [scsi_mod]
       [<ffffffff883aeb36>] quiesce_and_remove_host+0x96/0x9b [usb_storage]
       [<ffffffff883aec18>] storage_disconnect+0x17/0x24 [usb_storage]
       [<ffffffff803f1e14>] usb_unbind_interface+0x49/0x89
       [<ffffffff803bbe87>] __device_release_driver+0x82/0x9f
       [<ffffffff803bc18e>] device_release_driver+0x3c/0x5e
       [<ffffffff803bb6b4>] bus_remove_device+0xa5/0xbc
       [<ffffffff803ba24d>] device_del+0x149/0x17d
       [<ffffffff803f01da>] usb_disable_device+0x81/0xfb
       [<ffffffff803ec656>] usb_disconnect+0xb5/0x135
       [<ffffffff803ec70d>] hub_pre_reset+0x37/0x6c
       [<ffffffff803ebae9>] usb_reset_composite_device+0xc9/0x184
       [<ffffffff803ed17e>] hub_thread+0x14f/0xb7e
       [<ffffffff802361e9>] kthread+0xff/0x136
       [<ffffffff80262bdd>] child_rip+0x7/0x12

-> #10 (iprune_mutex){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80267ffc>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802681d9>] mutex_lock+0x29/0x2e
       [<ffffffff802ee51d>] invalidate_inodes+0x35/0x155
       [<ffffffff802e695c>] generic_shutdown_super+0x77/0x19d
       [<ffffffff802e6aa7>] kill_block_super+0x25/0x3b
       [<ffffffff802e6b92>] deactivate_super+0x6e/0x84
       [<ffffffff8022f77d>] mntput_no_expire+0x55/0x9a
       [<ffffffff80235287>] path_release_on_umount+0x1c/0x21
       [<ffffffff802f01f3>] sys_umount+0x24d/0x294
       [<ffffffff80261e19>] tracesys+0xd0/0xdb

-> #9 (&type->s_lock_key#9){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80267ffc>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802681d9>] mutex_lock+0x29/0x2e
       [<ffffffff88025823>] ext3_orphan_add+0x43/0x25b [ext3]
       [<ffffffff88022e7f>] ext3_setattr+0x179/0x21e [ext3]
       [<ffffffff8022f585>] notify_change+0x154/0x2f7
       [<ffffffff802e26b8>] do_truncate+0x52/0x72
       [<ffffffff80212d14>] may_open+0x1d5/0x231
       [<ffffffff8021c17d>] open_namei+0x290/0x6b4
       [<ffffffff802297f8>] do_filp_open+0x27/0x46
       [<ffffffff8021abc4>] do_sys_open+0x4e/0xcd
       [<ffffffff80234870>] sys_open+0x1a/0x1d
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #8 (&inode->i_alloc_sem){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff802a8146>] down_write+0x3a/0x47
       [<ffffffff8022f535>] notify_change+0x104/0x2f7
       [<ffffffff802e26b8>] do_truncate+0x52/0x72
       [<ffffffff80212d14>] may_open+0x1d5/0x231
       [<ffffffff8021c17d>] open_namei+0x290/0x6b4
       [<ffffffff802297f8>] do_filp_open+0x27/0x46
       [<ffffffff8021abc4>] do_sys_open+0x4e/0xcd
       [<ffffffff80234870>] sys_open+0x1a/0x1d
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #7 (&sysfs_inode_imutex_key){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80267ffc>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802681d9>] mutex_lock+0x29/0x2e
       [<ffffffff8030fdfc>] sysfs_hash_and_remove+0x3f/0x11c
       [<ffffffff8031064a>] sysfs_remove_file+0xf/0x12
       [<ffffffff803ba9f4>] sysdev_remove_file+0xc/0xf
       [<ffffffff80276a57>] mce_cpu_callback+0x4b/0xbd
       [<ffffffff8026c0f3>] notifier_call_chain+0x28/0x3e
       [<ffffffff8029f9f6>] blocking_notifier_call_chain+0x29/0x41
       [<ffffffff802af4a0>] cpu_down+0x18c/0x267
       [<ffffffff802b8a6e>] disable_nonboot_cpus+0x41/0xbb
       [<ffffffff802b4602>] enter_state+0xae/0x20e
       [<ffffffff802b47da>] state_store+0x67/0x86
       [<ffffffff803102bf>] subsys_attr_store+0x23/0x26
       [<ffffffff803105f7>] sysfs_write_file+0xd0/0x103
       [<ffffffff80217528>] vfs_write+0xce/0x175
       [<ffffffff80217e16>] sys_write+0x46/0x70
       [<ffffffff80261e19>] tracesys+0xd0/0xdb

-> #6 ((cpu_chain).rwsem){----}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff802a8068>] down_read+0x3d/0x4a
       [<ffffffff8029f9e7>] blocking_notifier_call_chain+0x1a/0x41
       [<ffffffff802af292>] cpu_up+0x57/0xd9
       [<ffffffff8026f71f>] init+0xb7/0x3cd
       [<ffffffff80262bdd>] child_rip+0x7/0x12

-> #5 (cpucontrol){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80267ffc>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802681d9>] mutex_lock+0x29/0x2e
       [<ffffffff802af1cc>] __lock_cpu_hotplug+0x3c/0x5f
       [<ffffffff802af209>] lock_cpu_hotplug+0xa/0xd
       [<ffffffff8023cca3>] kmem_cache_create+0x86/0x72b
       [<ffffffff804635fa>] fib_hash_init+0x31/0xce
       [<ffffffff8045fbfe>] __fib_new_table+0xf/0x2a
       [<ffffffff8045fc86>] fib_magic+0x6d/0x120
       [<ffffffff8045fdaf>] fib_add_ifaddr+0x76/0x135
       [<ffffffff8045ff16>] fib_inetaddr_event+0x2d/0x1d0
       [<ffffffff8026c0f3>] notifier_call_chain+0x28/0x3e
       [<ffffffff8029f9f6>] blocking_notifier_call_chain+0x29/0x41
       [<ffffffff8045a24b>] inet_insert_ifa+0x112/0x11a
       [<ffffffff8045b215>] devinet_ioctl+0x45c/0x5ee
       [<ffffffff8045b65d>] inet_ioctl+0x70/0x8f
       [<ffffffff8041f92a>] sock_ioctl+0x1e7/0x20a
       [<ffffffff8024495e>] do_ioctl+0x29/0x77
       [<ffffffff80233256>] vfs_ioctl+0x259/0x277
       [<ffffffff8024fa1c>] sys_ioctl+0x5e/0x82
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #4 ((inetaddr_chain).rwsem){..--}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff802a8068>] down_read+0x3d/0x4a
       [<ffffffff8029f9e7>] blocking_notifier_call_chain+0x1a/0x41
       [<ffffffff8045a24b>] inet_insert_ifa+0x112/0x11a
       [<ffffffff8045b215>] devinet_ioctl+0x45c/0x5ee
       [<ffffffff8045b65d>] inet_ioctl+0x70/0x8f
       [<ffffffff8041f92a>] sock_ioctl+0x1e7/0x20a
       [<ffffffff8024495e>] do_ioctl+0x29/0x77
       [<ffffffff80233256>] vfs_ioctl+0x259/0x277
       [<ffffffff8024fa1c>] sys_ioctl+0x5e/0x82
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #3 (rtnl_mutex){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80267ffc>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802681d9>] mutex_lock+0x29/0x2e
       [<ffffffff8042f7fd>] rtnl_lock+0xf/0x12
       [<ffffffff8045e03d>] ip_mc_leave_group+0x1e/0xae
       [<ffffffff80447ed0>] do_ip_setsockopt+0x6ad/0x9b2
       [<ffffffff80448283>] ip_setsockopt+0x2a/0x84
       [<ffffffff804561db>] udp_setsockopt+0xd/0x1c
       [<ffffffff80420e4e>] sock_common_setsockopt+0xe/0x11
       [<ffffffff8041ffc9>] sys_setsockopt+0x8e/0xb4
       [<ffffffff80261e19>] tracesys+0xd0/0xdb

-> #2 (sk_lock-AF_INET){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80236fbb>] lock_sock+0xd4/0xe7
       [<ffffffff80227ee5>] tcp_sendmsg+0x1e/0xb1a
       [<ffffffff802481c5>] inet_sendmsg+0x45/0x53
       [<ffffffff80258de7>] sock_sendmsg+0x110/0x130
       [<ffffffff80420ac6>] kernel_sendmsg+0x3c/0x52
       [<ffffffff8853d9e9>] xs_tcp_send_request+0x117/0x320 [sunrpc]
       [<ffffffff8853c8d5>] xprt_transmit+0x105/0x21e [sunrpc]
       [<ffffffff8853b71e>] call_transmit+0x1f4/0x239 [sunrpc]
       [<ffffffff8854006e>] __rpc_execute+0x9b/0x1e6 [sunrpc]
       [<ffffffff885401de>] rpc_execute+0x1a/0x1d [sunrpc]
       [<ffffffff8853a4ad>] rpc_call_sync+0x87/0xb9 [sunrpc]
       [<ffffffff885a653b>] nfs3_rpc_wrapper+0x2e/0x74 [nfs]
       [<ffffffff885a69c8>] nfs3_proc_lookup+0xe0/0x163 [nfs]
       [<ffffffff88598b10>] nfs_lookup+0xef/0x1d6 [nfs]
       [<ffffffff8020d300>] do_lookup+0xd0/0x1c9
       [<ffffffff80209f27>] __link_path_walk+0xa29/0xf7d
       [<ffffffff8020f0b0>] link_path_walk+0x69/0x101
       [<ffffffff8020d096>] do_path_lookup+0x27b/0x2e7
       [<ffffffff802257ca>] __user_walk_fd+0x40/0x5c
       [<ffffffff802430fd>] vfs_lstat_fd+0x23/0x5a
       [<ffffffff8022d316>] sys_newlstat+0x21/0x3c
       [<ffffffff80261e19>] tracesys+0xd0/0xdb

-> #1 (&inode->i_mutex){--..}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff80267ffc>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802681d9>] mutex_lock+0x29/0x2e
       [<ffffffff802ef633>] graft_tree+0x75/0x110
       [<ffffffff802efaf8>] do_add_mount+0xb1/0x171
       [<ffffffff802f0f12>] do_mount+0x6bc/0x711
       [<ffffffff8024f83a>] sys_mount+0x88/0xcb
       [<ffffffff80261c8d>] system_call+0x7d/0x83

-> #0 (&namespace_sem){----}:
       [<ffffffff802ab51c>] lock_acquire+0x7a/0xa1
       [<ffffffff802a8068>] down_read+0x3d/0x4a
       [<ffffffff8025186c>] m_start+0x1c/0x4d
       [<ffffffff80243564>] seq_read+0xe9/0x29c
       [<ffffffff8020b48c>] vfs_read+0xcb/0x172
       [<ffffffff802122d2>] sys_read+0x46/0x6f
       [<ffffffff80261e19>] tracesys+0xd0/0xdb

other info that might help us debug this:

1 lock held by awk/29576:
 #0:  (&p->lock){--..}, at: [<ffffffff802681da>] mutex_lock+0x2a/0x2e

stack backtrace:

Call Trace:
 [<ffffffff80270865>] show_trace+0xaa/0x23d
 [<ffffffff80270a0d>] dump_stack+0x15/0x17
 [<ffffffff802a9bda>] print_circular_bug_tail+0x6c/0x77
 [<ffffffff802ab299>] __lock_acquire+0x8a2/0xaab
 [<ffffffff802ab51d>] lock_acquire+0x7b/0xa1
 [<ffffffff802a8069>] down_read+0x3e/0x4a
 [<ffffffff8025186d>] m_start+0x1d/0x4d
 [<ffffffff80243565>] seq_read+0xea/0x29c
 [<ffffffff8020b48d>] vfs_read+0xcc/0x172
 [<ffffffff802122d3>] sys_read+0x47/0x6f
 [<ffffffff80261e1a>] tracesys+0xd1/0xdb
BUG: sleeping function called from invalid context at kernel/sched.c:4438
in_atomic():0, irqs_disabled():1

Call Trace:
 [<ffffffff80270865>] show_trace+0xaa/0x23d
 [<ffffffff80270a0d>] dump_stack+0x15/0x17
 [<ffffffff8020b9f8>] __might_sleep+0xb2/0xb4
 [<ffffffff802916ed>] __cond_resched+0x15/0x55
 [<ffffffff802668f2>] cond_resched+0x3b/0x42
 [<ffffffff8026769e>] console_conditional_schedule+0x12/0x14
 [<ffffffff80369d42>] fbcon_redraw+0xf6/0x160
 [<ffffffff8036b841>] fbcon_scroll+0x5d9/0xb52
 [<ffffffff803a5fc8>] scrup+0x6b/0xd6
 [<ffffffff803a6057>] lf+0x24/0x44
 [<ffffffff803a9bc2>] vt_console_print+0x166/0x23d
 [<ffffffff802948fc>] __call_console_drivers+0x65/0x76
 [<ffffffff8029496b>] _call_console_drivers+0x5e/0x62
 [<ffffffff80217cd8>] release_console_sem+0x14b/0x232
 [<ffffffff8036c8bf>] fb_flashcursor+0x279/0x2a6
 [<ffffffff80250ba8>] run_workqueue+0xa8/0xfb
 [<ffffffff8024d348>] worker_thread+0xef/0x122
 [<ffffffff802361ea>] kthread+0x100/0x136
 [<ffffffff80262bde>] child_rip+0x8/0x12


-- 
http://www.codemonkey.org.uk
