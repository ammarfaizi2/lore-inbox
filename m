Return-Path: <linux-kernel-owner+w=401wt.eu-S1754005AbWLXBDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbWLXBDW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 20:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbWLXBDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 20:03:22 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:4040 "EHLO sycorax.lbl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005AbWLXBDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 20:03:21 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.20-rc1: kernel BUG at fs/buffer.c:1235!
Date: Sat, 23 Dec 2006 17:03:21 -0800
Message-ID: <87psaagl5y.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is on a thinkpad t40, not sure if it means anything, but here it goes:

kernel: kernel BUG at fs/buffer.c:1235!
kernel: invalid opcode: 0000 [#1]
kernel: PREEMPT 
kernel: Modules linked in: radeon drm binfmt_misc nfs sd_mod scsi_mod nfsd exportfs lockd sunrpc autofs4 pcmcia firmware_class joydev irtty_sir sir_dev nsc_ircc irda crc_ccitt parport_pc parport ehci_hcd uhci_hcd usbcore aes_i586 airo nls_iso8859_1 ntfs yenta_socket rsrc_nonstatic pcmcia_core
kernel: CPU:    0
kernel: EIP:    0060:[<c016ad06>]    Not tainted VLI
kernel: EFLAGS: 00010046   (2.6.20-rc1 #215)
kernel: EIP is at __find_get_block+0x14/0x15e
kernel: eax: 00000082   ebx: c661fcf0   ecx: 00001000   edx: 004d7f7a
kernel: esi: 00001000   edi: 004d7f7a   ebp: c146d740   esp: c661fb80
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process vdrift (pid: 27994, ti=c661e000 task=ddc9da70 task.ti=c661e000)
kernel: Stack: 00000000 00001000 000b0059 cf76d9f8 c016ae46 cf76d9f8 cf76dd38 d7da8684 
kernel:        c661fcf0 004d7f7a 00001000 00000000 c016ae66 c661fd1c 000b0059 004d7f7a 
kernel:        c146d740 c661fcf0 004d7f7a c661fcf8 00000000 c019889a 00000000 c661fc0c 
kernel: Call Trace:
kernel:  [<c016ae46>] __find_get_block+0x154/0x15e
kernel:  [<c016ae66>] __getblk+0x16/0x1d6
kernel:  [<c019889a>] search_by_key+0x6b/0xc77
kernel:  [<c0114c69>] try_to_wake_up+0x13c/0x147
kernel:  [<c0120f8d>] __group_send_sig_info+0x5e/0x69
kernel:  [<c0121594>] group_send_sig_info+0x5d/0x65
kernel:  [<c012a998>] hrtimer_run_queues+0x136/0x14c
kernel:  [<c011f320>] run_timer_softirq+0x17c/0x184
kernel:  [<c0187768>] make_cpu_key+0x3f/0x46
kernel:  [<c0188c7e>] reiserfs_update_sd_size+0x7e/0x284
kernel:  [<c0118de9>] profile_tick+0x42/0x5d
kernel:  [<c019f915>] journal_begin+0x99/0xd0
kernel:  [<c0191c39>] reiserfs_dirty_inode+0x61/0x7e
kernel:  [<c0167be0>] __mark_inode_dirty+0x2a/0x18d
kernel:  [<c015dab3>] __d_lookup+0x120/0x13d
kernel:  [<c01607ed>] inode_setattr+0x15f/0x169
kernel:  [<c018aee6>] reiserfs_setattr+0x152/0x185
kernel:  [<c011bc74>] current_fs_time+0x45/0x51
kernel:  [<c01608f8>] notify_change+0x101/0x219
kernel:  [<c014e03a>] do_truncate+0x52/0x68
kernel:  [<c014daac>] get_unused_fd+0xa9/0xc5
kernel:  [<c01562fe>] may_open+0x17c/0x193
kernel:  [<c015822b>] open_namei+0x25a/0x56e
kernel:  [<c014dd21>] do_filp_open+0x25/0x39
kernel:  [<c014daac>] get_unused_fd+0xa9/0xc5
kernel:  [<c014dd77>] do_sys_open+0x42/0xc3
kernel:  [<c014de31>] sys_open+0x1c/0x1e
kernel:  [<c0102d64>] syscall_call+0x7/0xb
kernel:  [<c0300033>] unix_create1+0x4a/0xee
kernel:  =======================
kernel: Code: 89 e0 25 00 e0 ff ff 8b 40 08 a8 08 74 05 e8 cd 93 19 00 5b 5e 5f c3 55 89 c5 57 89 d7 56 89 ce 53 83 ec 20 9c 58 f6 c4 02 75 04 <0f> 0b eb fe b8 01 00 00 00 e8 ae 94 fa ff 31 c9 8b 1c 8d 20 23 
kernel: EIP: [<c016ad06>] __find_get_block+0x14/0x15e SS:ESP 0068:c661fb80
kernel:  WARNING at kernel/exit.c:853 do_exit()
kernel:  [<c011a2b7>] do_exit+0x42/0x72f
kernel:  [<c0118561>] printk+0x1b/0x1f
kernel:  [<c0104154>] die+0x1d9/0x1e1
kernel:  [<c01049b2>] do_invalid_op+0x0/0xab
kernel:  [<c0104a54>] do_invalid_op+0xa2/0xab
kernel:  [<c016ad06>] __find_get_block+0x14/0x15e
kernel:  [<c016ae66>] __getblk+0x16/0x1d6
kernel:  [<c012ba63>] clocksource_get_next+0x3b/0x55
kernel:  [<c011f98b>] do_timer+0x500/0x711
kernel:  [<c0181143>] reiserfs_read_bitmap_block+0x5c/0xc1
kernel:  [<c012a985>] hrtimer_run_queues+0x123/0x14c
kernel:  [<c0305d5c>] error_code+0x74/0x7c
kernel:  [<c016007b>] shrink_icache_memory+0x17b/0x1ce
kernel:  [<c016ad06>] __find_get_block+0x14/0x15e
kernel:  [<c016ae46>] __find_get_block+0x154/0x15e
kernel:  [<c016ae66>] __getblk+0x16/0x1d6
kernel:  [<c019889a>] search_by_key+0x6b/0xc77
kernel:  [<c0114c69>] try_to_wake_up+0x13c/0x147
kernel:  [<c0120f8d>] __group_send_sig_info+0x5e/0x69
kernel:  [<c0121594>] group_send_sig_info+0x5d/0x65
kernel:  [<c012a998>] hrtimer_run_queues+0x136/0x14c
kernel:  [<c011f320>] run_timer_softirq+0x17c/0x184
kernel:  [<c0187768>] make_cpu_key+0x3f/0x46
kernel:  [<c0188c7e>] reiserfs_update_sd_size+0x7e/0x284
kernel:  [<c0118de9>] profile_tick+0x42/0x5d
kernel:  [<c019f915>] journal_begin+0x99/0xd0
kernel:  [<c0191c39>] reiserfs_dirty_inode+0x61/0x7e
kernel:  [<c0167be0>] __mark_inode_dirty+0x2a/0x18d
kernel:  [<c015dab3>] __d_lookup+0x120/0x13d
kernel:  [<c01607ed>] inode_setattr+0x15f/0x169
kernel:  [<c018aee6>] reiserfs_setattr+0x152/0x185
kernel:  [<c011bc74>] current_fs_time+0x45/0x51
kernel:  [<c01608f8>] notify_change+0x101/0x219
kernel:  [<c014e03a>] do_truncate+0x52/0x68
kernel:  [<c014daac>] get_unused_fd+0xa9/0xc5
kernel:  [<c01562fe>] may_open+0x17c/0x193
kernel:  [<c015822b>] open_namei+0x25a/0x56e
kernel:  [<c014dd21>] do_filp_open+0x25/0x39
kernel:  [<c014daac>] get_unused_fd+0xa9/0xc5
kernel:  [<c014dd77>] do_sys_open+0x42/0xc3
kernel:  [<c014de31>] sys_open+0x1c/0x1e
kernel:  [<c0102d64>] syscall_call+0x7/0xb
kernel:  [<c0300033>] unix_create1+0x4a/0xee
kernel:  =======================

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
