Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130182AbRBWJsW>; Fri, 23 Feb 2001 04:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRBWJsN>; Fri, 23 Feb 2001 04:48:13 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:43524 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S130182AbRBWJr7>;
	Fri, 23 Feb 2001 04:47:59 -0500
Message-ID: <3A9631CA.999950EF@sh0n.net>
Date: Fri, 23 Feb 2001 04:47:54 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: [ANOMALIES]: 2.4.2 - __alloc_pages: failed & mount hanging with loop 
 device issues
Content-Type: multipart/mixed;
 boundary="------------EE8E13B6C341C2EB92F25ED0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EE8E13B6C341C2EB92F25ED0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
failed.
Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
failed.
Feb 23 03:31:18 coredump kernel: __alloc_pages: 2-order allocation
failed.
Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
failed.
Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
failed.
Feb 23 03:31:18 coredump kernel: __alloc_pages: 2-order allocation
failed.
Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
failed.

The use of mkisofs and xcdroster with cdrecord seems to cause this fault
in kernel.log

Other things such as mount hanging on trying to load a .ISO image with
the loopback device:

mount -t iso9660 -o loop bootcd.iso /image
.......waiting......

Here's my debug:

Feb 23 04:41:20 coredump kernel: EIP: 0010:[default_idle+35/40] CPU: 0
EFLAGS: 00000246
Feb 23 04:41:20 coredump kernel: EAX: 00000000 EBX: c0272000 ECX:
c2068260 EDX: c2068260
Feb 23 04:41:20 coredump kernel: ESI: c0107120 EDI: ffffe000 EBP:
0008e000 DS: 0018 ES: 0018
Feb 23 04:41:20 coredump kernel: CR0: 8005003b CR2: 400a7bc0 CR3:
0374e000 CR4: 00000010
Feb 23 04:41:20 coredump kernel: Call Trace: [cpu_idle+63/84]
[empty_bad_page+0/4096] [L6+0/2]

I've included a snip of kern.log as an attachment. I cant make sense of
it ;-)

Here's a ps dump:

root         1 init             do_select
root         2 [keventd]        context_thread
root         3 [kswapd]         kswapd
root         4 [kreclaimd]      kreclaimd
root         5 [bdflush]        bdflush
root         6 [kupdate]        kupdate
root         7 [kreiserfsd]     reiserfs_journal_commit_thread
....
root      1704 mount -t iso9660 wait_on_buffer
....
root      1749 mount -t iso9660 down

it's stuck on something and i cant kill mount?

Shawn.


--------------EE8E13B6C341C2EB92F25ED0
Content-Type: text/plain; charset=iso-8859-15;
 name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kern.log"

Feb 23 04:44:01 coredump kernel: [process_timeout+0/72] [do_select+413/476] [sys_select+842/1172] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: netscape  S C1C53EF0     0  1671      1  1672  (NOTLB)    1706   156
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0023>] [<ffff002b>] [<eea41050>] [<c90e5700>] [<d9999999>] [<ffff0023>] 
Feb 23 04:44:01 coredump kernel:        [<ec110e02>] [<ec200c02>] [<ec200c02>] [<ec313103>] [<ec2a2501>] [<ec350703>] [<ec340703>] [<ec350703>] 
Feb 23 04:44:01 coredump kernel:        [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] [start_request+299/508] [start_request+388/508] 
Feb 23 04:44:01 coredump kernel:        [ide_do_request+642/712] [do_balance_mark_leaf_dirty+86/100] [do_balance_mark_leaf_dirty+86/100] [leaf_delete_items_entirely+432/444] [get_cnode+17/104] [journal_mark_dirty+477/768] [do_balance_mark_leaf_dirty+86/100] [leaf_insert_into_buf+606/620] 
Feb 23 04:44:01 coredump kernel:        [balance_leaf+8947/9688] [get_cnode+17/104] [journal_mark_dirty+477/768] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-797764/96] [do_balance_mark_leaf_dirty+86/100] [leaf_cut_from_buffer+989/1000] [balance_leaf_when_delete+374/876] [balance_leaf+68/9688] 
Feb 23 04:44:01 coredump kernel:        [create_virtual_node+687/1224] [create_virtual_node+1155/1224] [dc_check_balance_leaf+325/344] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] 
Feb 23 04:44:01 coredump kernel:        [do_rw_disk+307/800] [start_request+299/508] [start_request+388/508] [is_tree_node+67/88] [search_by_key+2103/3232] [send_signal+44/240] [deliver_signal+77/84] [send_sig_info+120/164] 
Feb 23 04:44:01 coredump kernel:        [send_sig+29/36] [send_sigio_to_task+227/240] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] [send_sig+29/36] [send_sigio_to_task+227/240] [send_sigio_to_task+227/240] 
Feb 23 04:44:01 coredump kernel:        [send_sigio_to_task+227/240] [deliver_signal+29/84] [send_sig_info+120/164] [ignored_signal+49/64] [send_sigio+74/144] [__kill_fasync+81/96] [kill_fasync+22/40] [n_tty_receive_buf+3715/3836] 
Feb 23 04:44:01 coredump kernel:        [n_tty_receive_buf+3779/3836] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] [it_real_fn+0/68] [send_sig+29/36] [process_timeout+0/72] [timer_bh+574/636] 
Feb 23 04:44:01 coredump kernel:        [tqueue_bh+22/28] [bh_action+27/92] [schedule_timeout+115/148] [process_timeout+0/72] [do_select+413/476] [sys_select+842/1172] [old_select+85/108] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: netscape  S C2025EF0     0  1672   1671        (NOTLB)        
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0020>] [<ffff002b>] [<fcd5abd2>] [<ffff0120>] [<cf555555>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cf555555>] [<cf555555>] [<cfcfcfcf>] [<cf555555>] [<cfcfcfcf>] [<cf555555>] 
Feb 23 04:44:01 coredump kernel:        [<dfdfdfdf>] [<cfcf5555>] [<cfcfcfcf>] [<cfcf5555>] [<cfcfcfcf>] [<cf555555>] [<cfcfcfcf>] [<cfcf5555>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cf555555>] [<cfcfcfcf>] [<cfcfcfcf>] [<cf555555>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcf5555>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cf555555>] [<cfcfcfcf>] [<cfcfcfcf>] [<cf555555>] [<cf555555>] [<cfcfcfcf>] [<cf555555>] 
Feb 23 04:44:01 coredump kernel:        [<dfdfdf00>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcf05f7>] [<cfcf5555>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcf55>] [<cfcfcf55>] [<cfcfcfcf>] [<cfcf03f7>] [<cfcf5555>] [<cfcfcf55>] [<cfcfcfcf>] [<cf555555>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcf0354>] [<cfcf5555>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cf555555>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcf0354>] 
Feb 23 04:44:01 coredump kernel:        [<cfcf5555>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcf0354>] [<cfcf5555>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcf5555>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcf03f7>] [<cfcf5555>] [<cfcfcf55>] [<cfcf5555>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcf04f7>] [<cfcf5555>] 
Feb 23 04:44:01 coredump kernel:        [<cfcf5555>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcf04f7>] [<cfcf5555>] [<cfcfcf55>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcf55>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcf0354>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] 
Feb 23 04:44:01 coredump kernel:        [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [<cfcfcfcf>] [is_tree_node+67/88] [search_by_key+2103/3232] [send_signal+44/240] 
Feb 23 04:44:01 coredump kernel:        [deliver_signal+77/84] [send_sig_info+120/164] [send_sig+29/36] [send_sigio_to_task+227/240] [_get_block_create_0+424/1072] [<f0000000>] [send_sigio+74/144] [__kill_fasync+81/96] 
Feb 23 04:44:01 coredump kernel:        [kill_fasync+22/40] [n_tty_receive_buf+3715/3836] [n_tty_receive_buf+3779/3836] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [process_timeout+0/72] 
Feb 23 04:44:01 coredump kernel:        [timer_bh+574/636] [tqueue_bh+22/28] [bh_action+27/92] [tasklet_hi_action+60/96] [do_softirq+64/100] [do_IRQ+161/176] [is_tree_node+67/88] [search_by_key+2103/3232] 
Feb 23 04:44:01 coredump kernel:        [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] [pathrelse+28/44] [send_signal+44/240] [send_signal+44/240] [deliver_signal+29/84] 
Feb 23 04:44:01 coredump kernel:        [send_sig_info+120/164] [send_sig+29/36] [send_sigio_to_task+227/240] [_get_block_create_0+1017/1072] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] [it_real_fn+0/68] 
Feb 23 04:44:01 coredump kernel:        [send_signal+44/240] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] [it_real_fn+0/68] [send_sig+29/36] [process_timeout+0/72] [ip_local_deliver_finish+0/248] 
Feb 23 04:44:01 coredump kernel:        [schedule_timeout+115/148] [process_timeout+0/72] [do_select+413/476] [sys_select+842/1172] [old_select+85/108] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: mount     D C17DFE44     4  1704    167        (NOTLB)           430
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0020>] [<ffff002b>] [<d8003ffe>] [<cb348ded>] [<ffff0120>] [<fffbfaef>] 
Feb 23 04:44:01 coredump kernel:        [is_tree_node+67/88] [search_by_key+2103/3232] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] [pathrelse+28/44] [_get_block_create_0+424/1072] 
Feb 23 04:44:01 coredump kernel:        [<f0000000>] [reiserfs_get_block+158/3408] [get_far_parent+77/540] [ide_set_handler+89/100] [get_cnode+17/104] [is_tree_node+67/88] [__alloc_pages_limit+142/172] [__alloc_pages+296/720] 
Feb 23 04:44:01 coredump kernel:        [__alloc_pages_limit+142/172] [__alloc_pages+296/720] [filemap_nopage+282/1032] [do_no_page+77/192] [handle_mm_fault+248/356] [do_page_fault+312/1020] [do_page_fault+0/1020] [ioctl_by_bdev+134/160] 
Feb 23 04:44:01 coredump kernel:        [insert_vm_struct+26/44] [do_munmap+88/584] [gdt+1220/3524] [clear_user+46/64] [padzero+28/32] [load_elf_binary+0/2564] [__make_request+273/1680] [generic_make_request+320/336] 
Feb 23 04:44:01 coredump kernel:        [__wait_on_buffer+106/140] [bread+74/104] [isofs_read_super+265/1708] [read_super+256/368] [get_sb_bdev+342/432] [error_code+52/64] [do_mount+380/692] [copy_mount_options+84/164] 
Feb 23 04:44:01 coredump kernel:        [sys_mount+132/196] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: gnome-terminal  S 7FFFFFFF     0  1706      1  1708  (NOTLB)    1751  1671
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0120>] [<ffff002b>] [<ffff0120>] [do_balance_mark_leaf_dirty+86/100] [do_balance_mark_leaf_dirty+86/100] [leaf_delete_items_entirely+432/444] 
Feb 23 04:44:01 coredump kernel:        [do_balance_mark_leaf_dirty+86/100] [leaf_insert_into_buf+606/620] [balance_leaf+8947/9688] [reiserfs_kfree+20/56] [unfix_nodes+341/352] [do_balance+240/256] [leaf_delete_items+91/344] [reiserfs_insert_item+154/256] 
Feb 23 04:44:01 coredump kernel:        [do_balance_mark_leaf_dirty+86/100] [leaf_delete_items_entirely+432/444] [leaf_delete_items+91/344] [balance_leaf_when_delete+107/876] [balance_leaf+68/9688] [create_virtual_node+1155/1224] [<e88e0000>] [handle_IRQ_event+47/88] 
Feb 23 04:44:01 coredump kernel:        [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] [send_sig+29/36] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] [send_sig+29/36] 
Feb 23 04:44:01 coredump kernel:        [send_sigio_to_task+227/240] [send_sigio_to_task+227/240] [kill_fasync+22/40] [kill_fasync+22/40] [n_tty_receive_buf+3715/3836] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] 
Feb 23 04:44:01 coredump kernel:        [send_sig+29/36] [send_sigio_to_task+227/240] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843560/96] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843776/96] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843560/96] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] 
Feb 23 04:44:01 coredump kernel:        [send_sigio+74/144] [__kill_fasync+81/96] [kill_fasync+22/40] [n_tty_receive_buf+3715/3836] [n_tty_receive_buf+3779/3836] [__alloc_pages+219/720] [__pollwait+135/140] [pty_chars_in_buffer+35/60] 
Feb 23 04:44:01 coredump kernel:        [normal_poll+247/280] [schedule_timeout+23/148] [do_poll+133/220] [do_poll+186/220] [sys_poll+467/720] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: gnome-pty-helpe  S 7FFFFFFF     4  1707   1706        (NOTLB)    1708
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0120>] [<ffff002b>] [<d72a67a8>] [<ffff0120>] [<cccccccd>] [<cccccccd>] 
Feb 23 04:44:01 coredump kernel:        [is_tree_node+67/88] [search_by_key+2103/3232] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] [pathrelse+28/44] [_get_block_create_0+424/1072] 
Feb 23 04:44:01 coredump kernel:        [<f0000000>] [reiserfs_get_block+158/3408] [send_signal+44/240] [deliver_signal+29/84] [__make_request+324/1680] [__make_request+382/1680] [__make_request+409/1680] [get_unused_buffer_head+52/144] 
Feb 23 04:44:01 coredump kernel:        [generic_make_request+320/336] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] [start_request+299/508] 
Feb 23 04:44:01 coredump kernel:        [start_request+388/508] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] [start_request+299/508] 
Feb 23 04:44:01 coredump kernel:        [start_request+388/508] [is_tree_node+67/88] [search_by_key+2103/3232] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] 
Feb 23 04:44:01 coredump kernel:        [send_sig+29/36] [send_sigio_to_task+227/240] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] 
Feb 23 04:44:01 coredump kernel:        [start_request+299/508] [start_request+388/508] [send_sigio+74/144] [schedule_timeout+23/148] [n_tty_receive_buf+3779/3836] [unix_stream_data_wait+174/224] [unix_stream_recvmsg+358/832] [sock_recvmsg+61/172] 
Feb 23 04:44:01 coredump kernel:        [sock_read+132/144] [sys_read+150/204] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: bash      S 00000000     0  1708   1706  1739  (NOTLB)          1707
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0120>] [<ffff002b>] [<d72a67a8>] [<ffff0120>] [ide_set_handler+89/100] [ide_dmaproc+317/516] 
Feb 23 04:44:01 coredump kernel:        [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [is_tree_node+67/88] [search_by_key+2103/3232] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] 
Feb 23 04:44:01 coredump kernel:        [pathrelse+28/44] [_get_block_create_0+424/1072] [piix_dmaproc+35/44] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] 
Feb 23 04:44:01 coredump kernel:        [do_rw_disk+307/800] [start_request+299/508] [start_request+388/508] [is_tree_node+67/88] [search_by_key+2103/3232] [pathrelse+28/44] [init_inode+364/512] [reiserfs_read_inode2+190/200] 
Feb 23 04:44:01 coredump kernel:        [get_new_inode+236/344] [iget4+194/212] [reiserfs_iget+36/100] [reiserfs_iget+58/100] [__alloc_pages_limit+142/172] [__alloc_pages+296/720] [do_wp_page+571/616] [handle_mm_fault+307/356] 
Feb 23 04:44:01 coredump kernel:        [do_page_fault+312/1020] [do_page_fault+0/1020] [timer_bh+574/636] [sys_wait4+877/924] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: bash      S 00000000     0  1739   1708  1749  (NOTLB)        
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0020>] [<ffff002b>] [<dce00000>] [<ffff0120>] [<fbad2088>] [<fbad2887>] 
Feb 23 04:44:01 coredump kernel:        [<fbad2086>] [<fbad2088>] [<fbad2084>] [<fbad2086>] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843776/96] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843776/96] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843560/96] [finish_output_interrupt+81/84] 
Feb 23 04:44:01 coredump kernel:        [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843536/96] [do_outputintr+422/432] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843536/96] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843536/96] [DMAbuf_outputintr+257/304] [sb_intr+198/260] [sbintr+62/68] [handle_IRQ_event+47/88] 
Feb 23 04:44:01 coredump kernel:        [end_8259A_irq+24/28] [__switch_to+44/184] [is_tree_node+67/88] [search_by_key+2103/3232] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] 
Feb 23 04:44:01 coredump kernel:        [pathrelse+28/44] [_get_block_create_0+424/1072] [<f0000000>] [reiserfs_get_block+158/3408] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843536/96] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843536/96] [DMAbuf_outputintr+257/304] [sb_intr+198/260] 
Feb 23 04:44:01 coredump kernel:        [sbintr+62/68] [handle_IRQ_event+47/88] [__make_request+324/1680] [__make_request+382/1680] [__make_request+409/1680] [get_unused_buffer_head+52/144] [generic_make_request+320/336] [ide_set_handler+89/100] 
Feb 23 04:44:01 coredump kernel:        [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] [start_request+299/508] [start_request+388/508] [is_tree_node+67/88] 
Feb 23 04:44:01 coredump kernel:        [send_signal+44/240] [deliver_signal+77/84] [send_sig_info+120/164] [send_sig+29/36] [send_sigio_to_task+227/240] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] 
Feb 23 04:44:01 coredump kernel:        [send_sigio+74/144] [__kill_fasync+81/96] [kill_fasync+22/40] [n_tty_receive_buf+3715/3836] [n_tty_receive_buf+3779/3836] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] 
Feb 23 04:44:01 coredump kernel:        [dma_timer_expiry+0/100] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843776/96] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843776/96] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843560/96] [finish_output_interrupt+81/84] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843536/96] [do_outputintr+422/432] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843536/96] 
Feb 23 04:44:01 coredump kernel:        [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-843536/96] [DMAbuf_outputintr+257/304] [sb_intr+198/260] [sbintr+62/68] [handle_IRQ_event+47/88] [reclaim_page+814/1048] [__alloc_pages_limit+124/172] [__alloc_pages+296/720] 
Feb 23 04:44:01 coredump kernel:        [do_wp_page+571/616] [handle_mm_fault+307/356] [do_page_fault+312/1020] [do_page_fault+0/1020] [sys_wait4+877/924] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: mount     D C025D6AC    80  1749   1739        (NOTLB)        
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0020>] [<ffff002b>] [<dce00000>] [<ffff0120>] [<fffbfaef>] [<f0000000>] 
Feb 23 04:44:01 coredump kernel:        [is_tree_node+67/88] [search_by_key+2103/3232] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] [pathrelse+28/44] [_get_block_create_0+424/1072] 
Feb 23 04:44:01 coredump kernel:        [<f0000000>] [reiserfs_get_block+158/3408] [get_cnode+17/104] [journal_mark_dirty+477/768] [get_cnode+17/104] [journal_mark_dirty+477/768] [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-797764/96] [do_balance_mark_leaf_dirty+86/100] 
Feb 23 04:44:01 coredump kernel:        [leaf_delete_items_entirely+432/444] [__switch_to+44/184] [is_tree_node+67/88] [__alloc_pages_limit+142/172] [__alloc_pages+296/720] [__alloc_pages_limit+142/172] [__alloc_pages+296/720] [filemap_nopage+282/1032] 
Feb 23 04:44:01 coredump kernel:        [do_no_page+77/192] [handle_mm_fault+248/356] [do_page_fault+312/1020] [do_page_fault+0/1020] [do_munmap+88/584] [insert_vm_struct+26/44] [do_munmap+88/584] [error_code+52/64] 
Feb 23 04:44:01 coredump kernel:        [clear_user+46/64] [padzero+28/32] [load_elf_binary+2247/2564] [load_elf_binary+0/2564] [is_tree_node+67/88] [search_by_key+2103/3232] [make_cpu_key+57/64] [reclaim_page+814/1048] 
Feb 23 04:44:01 coredump kernel:        [__alloc_pages_limit+124/172] [inactive_shortage+52/124] [process_timeout+0/72] [timer_bh+574/636] [__down+85/156] [__down_failed+8/12] [stext_lock+1005/4140] [do_mount+380/692] 
Feb 23 04:44:01 coredump kernel:        [copy_mount_options+84/164] [sys_mount+132/196] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: gnome-terminal  S C14BBF30     0  1751      1  1753  (NOTLB)          1706
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff4020>] [<ffff002b>] [<cc800000>] [<ffff0120>] [get_cnode+17/104] [journal_mark_dirty+477/768] 
Feb 23 04:44:01 coredump kernel:        [nls_cp437:__insmod_nls_cp437_O/lib/modules/2.4.2/kernel/fs/nls/nls_cp+-797764/96] [do_balance_mark_leaf_dirty+86/100] [do_balance_mark_leaf_dirty+86/100] [leaf_delete_items_entirely+432/444] [do_balance_mark_leaf_dirty+86/100] [do_balance_mark_leaf_dirty+86/100] [check_internal+14/20] [internal_insert_childs+506/520] 
Feb 23 04:44:01 coredump kernel:        [balance_internal+2353/2416] [reiserfs_kfree+20/56] [unfix_nodes+341/352] [do_balance+240/256] [reiserfs_insert_item+154/256] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] 
Feb 23 04:44:01 coredump kernel:        [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] [start_request+299/508] [start_request+388/508] [schedule+618/916] [__wait_on_buffer+128/140] [is_tree_node+67/88] 
Feb 23 04:44:01 coredump kernel:        [search_by_key+2103/3232] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] [send_sig+29/36] 
Feb 23 04:44:01 coredump kernel:        [send_sigio_to_task+227/240] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] [send_sig+29/36] [send_sigio_to_task+227/240] [kill_fasync+22/40] [send_sigio+74/144] 
Feb 23 04:44:01 coredump kernel:        [__kill_fasync+81/96] [kill_fasync+22/40] [n_tty_receive_buf+3715/3836] [n_tty_receive_buf+3779/3836] [send_signal+44/240] [deliver_signal+29/84] [send_sig_info+120/164] [it_real_fn+0/68] 
Feb 23 04:44:01 coredump kernel:        [send_sig+29/36] [alloc_skb+222/368] [memcpy_fromiovec+57/108] [unix_stream_sendmsg+516/696] [__alloc_pages+219/720] [__pollwait+135/140] [__pollwait+135/140] [schedule_timeout+115/148] 
Feb 23 04:44:01 coredump kernel:        [process_timeout+0/72] [do_poll+186/220] [sys_poll+467/720] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: gnome-pty-helpe  S 7FFFFFFF   152  1752   1751        (NOTLB)    1753
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0120>] [<ffff002b>] [<d72a67a8>] [<ffff0120>] [is_tree_node+67/88] [__alloc_pages_limit+142/172] 
Feb 23 04:44:01 coredump kernel:        [__alloc_pages+296/720] [__alloc_pages_limit+142/172] [__alloc_pages+296/720] [filemap_nopage+282/1032] [do_no_page+77/192] [handle_mm_fault+248/356] [do_page_fault+312/1020] [do_page_fault+0/1020] 
Feb 23 04:44:01 coredump kernel:        [do_munmap+88/584] [is_tree_node+67/88] [search_by_key+2103/3232] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [reiserfs_get_block+341/3408] [pathrelse+28/44] 
Feb 23 04:44:01 coredump kernel:        [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] [start_request+299/508] [start_request+388/508] 
Feb 23 04:44:01 coredump kernel:        [schedule_timeout+23/148] [free_shortage+25/168] [unix_stream_data_wait+174/224] [unix_stream_recvmsg+358/832] [sock_recvmsg+61/172] [sock_read+132/144] [sys_read+150/204] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: bash      S 00000000     0  1753   1751  1765  (NOTLB)          1752
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0120>] [<ffff002b>] [<d72a67a8>] [<ffff0120>] [is_tree_node+67/88] [__alloc_pages_limit+142/172] 
Feb 23 04:44:01 coredump kernel:        [__alloc_pages+296/720] [__alloc_pages_limit+142/172] [__alloc_pages+296/720] [filemap_nopage+282/1032] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] 
Feb 23 04:44:01 coredump kernel:        [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] [start_request+299/508] [start_request+388/508] 
Feb 23 04:44:01 coredump kernel:        [__switch_to+44/184] [schedule+618/916] [__wait_on_buffer+128/140] [is_tree_node+67/88] [search_by_key+2103/3232] [pathrelse+28/44] [init_inode+364/512] [reiserfs_read_inode2+190/200] 
Feb 23 04:44:01 coredump kernel:        [get_new_inode+236/344] [iget4+194/212] [reiserfs_iget+36/100] [reiserfs_iget+58/100] [reiserfs_lookup+177/196] [__alloc_pages+219/720] [do_wp_page+571/616] [handle_mm_fault+307/356] 
Feb 23 04:44:01 coredump kernel:        [do_page_fault+312/1020] [do_page_fault+0/1020] [sys_wait4+877/924] [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: bash      S 00000000     0  1765   1753  1786  (NOTLB)        
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0020>] [<ffff002b>] [<ff600000>] [<dfbcd8f2>] [<ffff0120>] [is_tree_node+67/88] 
Feb 23 04:44:01 coredump kernel:        [search_by_key+2103/3232] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] [pathrelse+28/44] [_get_block_create_0+424/1072] [<f0000000>] 
Feb 23 04:44:01 coredump kernel:        [reiserfs_get_block+158/3408] [__make_request+324/1680] [__make_request+382/1680] [__make_request+409/1680] [get_unused_buffer_head+52/144] [generic_make_request+320/336] [submit_bh+96/128] [block_read_full_page+529/552] 
Feb 23 04:44:01 coredump kernel:        [schedule+618/916] [__alloc_pages+219/720] [filemap_nopage+282/1032] [is_tree_node+67/88] [search_by_key+2103/3232] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] 
Feb 23 04:44:01 coredump kernel:        [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] [start_request+299/508] [start_request+388/508] [schedule+618/916] [__wait_on_buffer+128/140] [is_tree_node+67/88] 
Feb 23 04:44:01 coredump kernel:        [search_by_key+2103/3232] [end_8259A_irq+24/28] [pathrelse+28/44] [init_inode+364/512] [reiserfs_read_inode2+190/200] [get_new_inode+236/344] [iget4+194/212] [reiserfs_iget+36/100] 
Feb 23 04:44:01 coredump kernel:        [reiserfs_iget+58/100] [reiserfs_lookup+177/196] [__alloc_pages+219/720] [do_wp_page+571/616] [handle_mm_fault+307/356] [do_page_fault+312/1020] [do_page_fault+0/1020] [sys_wait4+877/924] 
Feb 23 04:44:01 coredump kernel:        [system_call+51/64] 
Feb 23 04:44:01 coredump kernel: tail      S C3181F88    20  1786   1765        (NOTLB)        
Feb 23 04:44:01 coredump kernel: Call Trace: [<ffff037f>] [<ffff0020>] [<ffff002b>] [<ff600000>] [<dfbcd8f2>] [<ffff0120>] [<e1481b22>] 
Feb 23 04:44:01 coredump kernel:        [<f3034b27>] [<f284e30b>] [<eae2b928>] [<f2e5a649>] [<e96ca9e5>] [<d738a696>] [<ee1414bd>] [<ee5a2b32>] 
Feb 23 04:44:02 coredump kernel:        [<cad62bab>] [<ce1ae74b>] [<e2f084c9>] [<ddb93a8d>] [<fbff580a>] [<cc0480dd>] [<eda2f0f4>] [<e2ee1ce6>] 
Feb 23 04:44:02 coredump kernel:        [<dfd5d71b>] [<d5140acd>] [<f1f1c519>] [<f564a6c7>] [<f726bec7>] [<d7aea658>] [<ffbf313e>] [<c5ffb5b7>] 
Feb 23 04:44:02 coredump kernel:        [<d75967bc>] [<ce7f50ff>] [<ce395270>] [<d8450ab3>] [<e75e8d51>] [<f55946c6>] [<fdd71f9e>] [<ecf3ffab>] 
Feb 23 04:44:02 coredump kernel:        [<de91e548>] [<eff8bf77>] [<fbb7f2a6>] [<fe7f1986>] [<ff752f29>] [<fd92d35c>] [<fdfffffa>] [<dd58d27e>] 
Feb 23 04:44:02 coredump kernel:        [<e55293c1>] [<ff4fd55e>] [<f3de1cfe>] [<f3ffe7ff>] [<dc18653c>] [<cb4f47bf>] [<f3e71874>] [<e640e301>] 
Feb 23 04:44:02 coredump kernel:        [<e1b25edf>] [<c4c02604>] [<fdbaf95c>] [<d5e4f140>] [<cdfbfc31>] [<efc3b9f3>] [<f72ebf9e>] [<ffff3fff>] 
Feb 23 04:44:02 coredump kernel:        [<d8fbffff>] [<ffdffb7f>] [<efffffff>] [<cf1fd6f3>] [<cefb6196>] [<d4950a96>] [<e7d6b394>] [<f43b4b29>] 
Feb 23 04:44:02 coredump kernel:        [<d5009049>] [<d2fbffa9>] [<ec4c8a4c>] [<e12d3855>] [<fdec935a>] [<cbbd1b6b>] [<ef1be632>] [<f3dde16f>] 
Feb 23 04:44:02 coredump kernel:        [<d9ddf9dc>] [<e65ceeff>] [<c8d06a7c>] [<d1fe5ad0>] [<d31c1671>] [<c554666a>] [<dc18e317>] [<f35f4fbf>] 
Feb 23 04:44:02 coredump kernel:        [<ff6e8d75>] [<f1bea555>] [<dfbe629c>] [<c6961554>] [<de8d971c>] [<c7b2b79e>] [<e6c32664>] [<dee9d0ec>] 
Feb 23 04:44:02 coredump kernel:        [<cb7c1ff6>] [<f24c95db>] [<e5ca4934>] [<f90b5c40>] [<d15461d2>] [<da82564b>] [is_tree_node+67/88] [search_by_key+2103/3232] 
Feb 23 04:44:02 coredump kernel:        [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] [pathrelse+28/44] [_get_block_create_0+424/1072] [<f0000000>] [reiserfs_get_block+158/3408] 
Feb 23 04:44:02 coredump kernel:        [send_sig_info+80/164] [send_signal+44/240] [ide_set_handler+89/100] [ide_dmaproc+317/516] [ide_dma_intr+0/160] [dma_timer_expiry+0/100] [piix_dmaproc+35/44] [do_rw_disk+307/800] 
Feb 23 04:44:02 coredump kernel:        [start_request+299/508] [start_request+388/508] [ide_do_request+642/712] [schedule+618/916] [__alloc_pages+219/720] [filemap_nopage+282/1032] [do_no_page+77/192] [handle_mm_fault+248/356] 
Feb 23 04:44:02 coredump kernel:        [do_page_fault+312/1020] [do_page_fault+0/1020] [do_munmap+88/584] [insert_vm_struct+26/44] [insert_vm_struct+35/44] [do_brk+308/356] [error_code+52/64] [clear_user+46/64] 
Feb 23 04:44:02 coredump kernel:        [padzero+28/32] [load_elf_binary+2247/2564] [load_elf_binary+0/2564] [send_signal+44/240] [deliver_signal+77/84] [send_sig_info+120/164] [it_real_fn+0/68] [send_sig+29/36] 
Feb 23 04:44:02 coredump kernel:        [process_timeout+0/72] [timer_bh+574/636] [tqueue_bh+22/28] [bh_action+27/92] [tasklet_hi_action+60/96] [do_softirq+64/100] [do_IRQ+161/176] [ret_from_intr+0/32] 
Feb 23 04:44:02 coredump kernel:        [inactive_shortage+52/124] [__find_get_page+45/104] [filemap_nopage+171/1032] [do_no_page+77/192] [handle_mm_fault+248/356] [do_page_fault+312/1020] [__switch_to+44/184] [schedule_timeout+115/148] 
Feb 23 04:44:02 coredump kernel:        [process_timeout+0/72] [sys_nanosleep+246/396] [system_call+51/64] 

--------------EE8E13B6C341C2EB92F25ED0--

