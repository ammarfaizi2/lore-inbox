Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267346AbUGNKQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267346AbUGNKQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267349AbUGNKQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:16:12 -0400
Received: from die-box.org ([81.169.152.139]:3550 "HELO die-box.org")
	by vger.kernel.org with SMTP id S267346AbUGNKP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:15:58 -0400
Subject: Re: [ck] Preempt Threshold Measurements
From: Jens Bergmann <me@1cu.de>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
In-Reply-To: <200407121943.25196.devenyga@mcmaster.ca>
References: <200407121943.25196.devenyga@mcmaster.ca>
Content-Type: text/plain
Message-Id: <1089800153.3851.4.camel@host-95173.ewetel.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 12:15:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is what i got running -ck (downloaded today so including wli's
updated preempt latency testing patch):

8ms non-preemptible critical section violated 2 ms preempt threshold
starting at generic_shutdown_super+0x73/0x1b0 and ending at
schedule+0x255/0x4a0
 [<c0354b35>] schedule+0x255/0x4a0
 [<c0114a08>] dec_preempt_count+0x118/0x120
 [<c0354b35>] schedule+0x255/0x4a0
 [<c0354b35>] schedule+0x255/0x4a0
 [<c011e7b2>] __mod_timer+0x112/0x180
 [<c0355283>] schedule_timeout+0x63/0xc0
 [<c011f2c0>] process_timeout+0x0/0x10
 [<c0161237>] do_select+0x187/0x2f0
 [<c0160ee0>] __pollwait+0x0/0xd0
 [<c01616bb>] sys_select+0x2db/0x500
 [<c0104237>] syscall_call+0x7/0xb

3ms non-preemptible critical section violated 2 ms preempt threshold
starting at schedule+0x65/0x4a0 and ending at schedule+0x255/0x4a0
 [<c0354b35>] schedule+0x255/0x4a0
 [<c0114a08>] dec_preempt_count+0x118/0x120
 [<c0354b35>] schedule+0x255/0x4a0
 [<c0354b35>] schedule+0x255/0x4a0
 [<c01170b5>] do_syslog+0x205/0x430
 [<c0114e30>] autoremove_wake_function+0x0/0x60
 [<c0114942>] dec_preempt_count+0x52/0x120
 [<c0114e30>] autoremove_wake_function+0x0/0x60  
 [<c0169a63>] dnotify_parent+0x93/0xc0
 [<c014def8>] vfs_read+0xb8/0x130
 [<c014e192>] sys_read+0x42/0x70
 [<c0104237>] syscall_call+0x7/0xb

6ms non-preemptible critical section violated 2 ms preempt threshold
starting at sock_def_readable+0x10/0x90 and ending at
sock_def_readable+0x31/0x90
 [<c02ec391>] sock_def_readable+0x31/0x90
 [<c0114a08>] dec_preempt_count+0x118/0x120
 [<c02ec391>] sock_def_readable+0x31/0x90
 [<c02ec391>] sock_def_readable+0x31/0x90
 [<c033a66f>] unix_stream_sendmsg+0x28f/0x410
 [<c02e8d8d>] sock_sendmsg+0x9d/0xc0
 [<c0112f4a>] slice+0x2a/0x50
 [<c0112fb9>] effective_prio+0x49/0xe0
 [<c01131ae>] activate_task+0x6e/0x90
 [<c0113271>] try_to_wake_up+0x71/0xc0
 [<c01132dd>] wake_up_process+0x1d/0x30
 [<c02566dc>] vt_ioctl+0x21c/0x1c40
 [<c02e91b5>] sock_readv_writev+0x75/0xb0
 [<c02e929f>] sock_writev+0x4f/0x60
 [<c014e59c>] do_readv_writev+0x22c/0x280
 [<c016071d>] sys_ioctl+0xbd/0x2a0
 [<c0114942>] dec_preempt_count+0x52/0x120
 [<c014e6b8>] vfs_writev+0x58/0x70
 [<c014e782>] sys_writev+0x42/0x70
 [<c014e6b8>] vfs_writev+0x58/0x70
 [<c014e782>] sys_writev+0x42/0x70
 [<c0104237>] syscall_call+0x7/0xb

6ms non-preemptible critical section violated 2 ms preempt threshold
starting at exit_mmap+0x1a/0x170 and ending at exit_mmap+0x112/0x170
 [<c0142862>] exit_mmap+0x112/0x170
 [<c0114a08>] dec_preempt_count+0x118/0x120
 [<c0142862>] exit_mmap+0x112/0x170
 [<c0142862>] exit_mmap+0x112/0x170
 [<c0115154>] mmput+0x74/0xa0
 [<c01194ab>] do_exit+0xfb/0x430
 [<c0121cd6>] get_signal_to_deliver+0x236/0x380
 [<c0114942>] dec_preempt_count+0x52/0x120
 [<c011988e>] do_group_exit+0x3e/0xc0
 [<c0121d09>] get_signal_to_deliver+0x269/0x380
 [<c0103fd3>] do_signal+0x93/0x120
 [<c01345c8>] free_hot_cold_page+0xa8/0x120
 [<c0160ed4>] poll_freewait+0x44/0x50
 [<c0161c5c>] sys_poll+0x20c/0x240
 [<c0160ee0>] __pollwait+0x0/0xd0
 [<c0104097>] do_notify_resume+0x37/0x3c
 [<c0104282>] work_notifysig+0x13/0x15

6ms non-preemptible critical section violated 2 ms preempt threshold
starting at install_arg_page+0x39/0x100 and ending at
pte_alloc_map+0x45/0xb0
 [<c013dc95>] pte_alloc_map+0x45/0xb0
 [<c0114a08>] dec_preempt_count+0x118/0x120
 [<c013dc95>] pte_alloc_map+0x45/0xb0
 [<c013dc95>] pte_alloc_map+0x45/0xb0
 [<c0114858>] __touch_preempt_timing+0x8/0x20
 [<c0158918>] install_arg_page+0x48/0x100
 [<c0158b34>] setup_arg_pages+0x164/0x1b0
 [<c01788eb>] load_elf_binary+0x41b/0xd50
 [<c0130f95>] __generic_file_aio_read+0x205/0x240
 [<c014de10>] do_sync_read+0x80/0xb0
 [<c0169a63>] dnotify_parent+0x93/0xc0
 [<c01784d0>] load_elf_binary+0x0/0xd50
 [<c0159a91>] search_binary_handler+0x191/0x2c0
 [<c0177b55>] load_script+0x215/0x250
 [<c0169a63>] dnotify_parent+0x93/0xc0
 [<c0134b20>] __alloc_pages+0x320/0x390
 [<c0159a75>] search_binary_handler+0x175/0x2c0
 [<c0114942>] dec_preempt_count+0x52/0x120
 [<c0177940>] load_script+0x0/0x250
 [<c0159a91>] search_binary_handler+0x191/0x2c0
 [<c0159d8d>] do_execve+0x1cd/0x250
 [<c0102d22>] sys_execve+0x42/0x80
 [<c0104237>] syscall_call+0x7/0xb
 [<c012583b>] ____call_usermodehelper+0x7b/0xb0
 [<c0104237>] syscall_call+0x7/0xb
 [<c012583b>] ____call_usermodehelper+0x7b/0xb0
 [<c01257c0>] ____call_usermodehelper+0x0/0xb0
 [<c010237d>] kernel_thread_helper+0x5/0x18 

6ms non-preemptible critical section violated 2 ms preempt threshold
starting at unix_accept+0xbe/0x140 and ending at unix_accept+0xfc/0x140
 [<c033a50c>] unix_accept+0xfc/0x140
 [<c0114a08>] dec_preempt_count+0x118/0x120
 [<c033a50c>] unix_accept+0xfc/0x140
 [<c033a50c>] unix_accept+0xfc/0x140
 [<c02ea8a1>] sys_accept+0xb1/0x170
 [<c0161a5f>] do_select+0x1af/0x2f0
 [<c011e7d2>] __mod_timer+0x112/0x180
 [<c0114942>] dec_preempt_count+0x52/0x120
 [<c011e7d2>] __mod_timer+0x112/0x180
 [<c011a51c>] do_setitimer+0x1bc/0x1f0
 [<c0224308>] copy_from_user+0x48/0x80
 [<c02eb495>] sys_socketcall+0xd5/0x260
 [<c0104237>] syscall_call+0x7/0xb

5ms non-preemptible critical section violated 2 ms preempt threshold
starting at sys_ioctl+0x41/0x2a0 and ending at sys_ioctl+0xbd/0x2a0
 [<c0160f1d>] sys_ioctl+0xbd/0x2a0
 [<c0114a08>] dec_preempt_count+0x118/0x120  [<c0160f1d>]
sys_ioctl+0xbd/0x2a0
 [<c0104648>] show_trace+0x18/0xa0
 [<c0160f1d>] sys_ioctl+0xbd/0x2a0
 [<c0104648>] show_trace+0x18/0xa0
 [<c0104237>] syscall_call+0x7/0xb
 [<c0104648>] show_trace+0x18/0xa0

115ms non-preemptible critical section violated 2 ms preempt threshold
starting at schedule+0x65/0x4a0 and ending at chrdev_open+0x105/0x240
 [<c0157af5>] chrdev_open+0x105/0x240
 [<c0114a08>] dec_preempt_count+0x118/0x120
 [<c0157af5>] chrdev_open+0x105/0x240
 [<c0157af5>] chrdev_open+0x105/0x240
 [<c014d75a>] dentry_open+0x15a/0x240
 [<c014d5f8>] filp_open+0x68/0x70
 [<c014d8b4>] get_unused_fd+0x74/0xe0
 [<c014da5b>] sys_open+0x5b/0x90
 [<c0104237>] syscall_call+0x7/0xb

300ms non-preemptible critical section violated 2 ms preempt threshold
starting at chrdev_open+0xd3/0x240 and ending at schedule+0x255/0x4a0
 [<c03553d5>] schedule+0x255/0x4a0
 [<c0114a08>] dec_preempt_count+0x118/0x120
 [<c03553d5>] schedule+0x255/0x4a0
 [<c03553d5>] schedule+0x255/0x4a0
 [<c011e7d2>] __mod_timer+0x112/0x180
 [<c0355b23>] schedule_timeout+0x63/0xc0
 [<c011e7d2>] __mod_timer+0x112/0x180
 [<c0355b23>] schedule_timeout+0x63/0xc0
 [<c011f2e0>] process_timeout+0x0/0x10
 [<c0161a37>] do_select+0x187/0x2f0
 [<c01616e0>] __pollwait+0x0/0xd0
 [<c0161ebb>] sys_select+0x2db/0x500
 [<c0104237>] syscall_call+0x7/0xb

System specs:
P3 1.13 GHz, 512 MB RAM, 1024 MB Swap, Ext3, 20GB IBM DTLA305020
Normal Desktop Maschine running X.

-- 
  it's just a game...

