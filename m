Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbTEEQ3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTEEQ3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:29:19 -0400
Received: from franka.aracnet.com ([216.99.193.44]:64201 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263664AbTEEQ2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:28:11 -0400
Date: Mon, 05 May 2003 09:40:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 644] New: Unable to handle kernel paging request
Message-ID: <11210000.1052152801@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=644

           Summary: Unable to handle kernel paging request
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: jochen@jochen.org


Distribution: Debian sarge
Hardware Environment: IBM Thinkpad 600

Problem Description:
After 10 minutes ofuptime the machine crashed with the following in
the syslog:

Apr 25 15:32:51 gswi1164 kernel: Linux agpgart interface v0.100 (c) Dave Jones
Apr 25 15:41:40 gswi1164 kernel:  printing eip:
Apr 25 15:41:40 gswi1164 kernel: c0232f36
Apr 25 15:41:40 gswi1164 kernel: Oops: 0002 [#1]
Apr 25 15:41:40 gswi1164 kernel: CPU:    0
Apr 25 15:41:40 gswi1164 kernel: EIP:    0060:[cfb_imageblit+630/1680]    Not tainted
Apr 25 15:41:40 gswi1164 kernel: EFLAGS: 00010246
Apr 25 15:41:40 gswi1164 kernel: EIP is at cfb_imageblit+0x276/0x690
Apr 25 15:41:40 gswi1164 kernel: eax: c6c0e000   ebx: 00000000   ecx: c6c0e004   edx: c0375ff8
Apr 25 15:41:40 gswi1164 kernel: esi: c10fb6d0   edi: 0000004b   ebp: c4825a40   esp: c4825970
Apr 25 15:41:40 gswi1164 kernel: ds: 007b   es: 007b   ss: 0068
Apr 25 15:41:40 gswi1164 kernel: Process less (pid: 2137, threadinfo=c4824000 task=c443f2f0)
Apr 25 15:41:40 gswi1164 kernel: Stack: c6c0e000 c030d904 0000011d c10fb6f6 ffffffff 00000026 00000010 07070707
Apr 25 15:41:40 gswi1164 kernel:        003102a0 00000000 00000280 0000000e c10fb6f6 c45a0c68 00000000 c119b6e4
Apr 25 15:41:40 gswi1164 kernel:        c48259d0 c012b77f c48259c8 c02037f6 c5f7fe3c c1096c88 c48259d8 c015f413
Apr 25 15:41:40 gswi1164 kernel: Call Trace:
Apr 25 15:41:40 gswi1164 kernel:  [add_to_page_cache+63/220] add_to_page_cache+0x3f/0xdc
Apr 25 15:41:40 gswi1164 kernel:  [submit_bio+86/100] submit_bio+0x56/0x64
Apr 25 15:41:40 gswi1164 kernel:  [mpage_bio_submit+35/44] mpage_bio_submit+0x23/0x2c
Apr 25 15:41:40 gswi1164 kernel:  [mpage_readpages+276/288] mpage_readpages+0x114/0x120
Apr 25 15:41:40 gswi1164 kernel:  [try_to_wake_up+297/452] try_to_wake_up+0x129/0x1c4
Apr 25 15:41:40 gswi1164 kernel:  [neofb_imageblit+41/48] neofb_imageblit+0x29/0x30
Apr 25 15:41:40 gswi1164 kernel:  [putcs_aligned+312/364] putcs_aligned+0x138/0x16c
Apr 25 15:41:40 gswi1164 kernel:  [accel_putcs+140/184] accel_putcs+0x8c/0xb8
Apr 25 15:41:40 gswi1164 kernel:  [mempool_free_slab+16/20] mempool_free_slab+0x10/0x14
Apr 25 15:41:40 gswi1164 kernel:  [fbcon_putcs+109/120] fbcon_putcs+0x6d/0x78
Apr 25 15:41:40 gswi1164 kernel:  [vt_console_print+619/708] vt_console_print+0x26b/0x2c4
Apr 25 15:41:40 gswi1164 kernel:  [__call_console_drivers+59/80] __call_console_drivers+0x3b/0x50
Apr 25 15:41:40 gswi1164 kernel:  [_call_console_drivers+80/88] _call_console_drivers+0x50/0x58
Apr 25 15:41:40 gswi1164 kernel:  [call_console_drivers+220/232] call_console_drivers+0xdc/0xe8
Apr 25 15:41:40 gswi1164 kernel:  [release_console_sem+91/208] release_console_sem+0x5b/0xd0
Apr 25 15:41:40 gswi1164 kernel:  [printk+295/344] printk+0x127/0x158
Apr 25 15:41:40 gswi1164 kernel:  [do_page_fault+603/1038] do_page_fault+0x25b/0x40e
Apr 25 15:41:40 gswi1164 kernel:  [do_page_fault+0/1038] do_page_fault+0x0/0x40e
Apr 25 15:41:40 gswi1164 kernel:  [update_wall_time+14/56] update_wall_time+0xe/0x38
Apr 25 15:41:40 gswi1164 kernel:  [do_timer+77/212] do_timer+0x4d/0xd4
Apr 25 15:41:40 gswi1164 kernel:  [cfb_imageblit+624/1680] cfb_imageblit+0x270/0x690
Apr 25 15:41:40 gswi1164 kernel:  [do_softirq+81/176] do_softirq+0x51/0xb0
Apr 25 15:41:40 gswi1164 kernel:  [cfb_imageblit+624/1680] cfb_imageblit+0x270/0x690
Apr 25 15:41:40 gswi1164 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Apr 25 15:41:40 gswi1164 kernel:  [error_code+45/56] error_code+0x2d/0x38
Apr 25 15:41:40 gswi1164 kernel:  [neofb_set_par+1427/2132] neofb_set_par+0x593/0x854
Apr 25 15:41:40 gswi1164 kernel:  [bitfill32+153/480] bitfill32+0x99/0x1e0
Apr 25 15:41:40 gswi1164 kernel:  [bitfill32+0/480] bitfill32+0x0/0x1e0
Apr 25 15:41:40 gswi1164 kernel:  [cfb_fillrect+384/656] cfb_fillrect+0x180/0x290
Apr 25 15:41:40 gswi1164 kernel:  [neofb_imageblit+41/48] neofb_imageblit+0x29/0x30
Apr 25 15:41:40 gswi1164 kernel:  [neofb_fillrect+41/48] neofb_fillrect+0x29/0x30
Apr 25 15:41:40 gswi1164 kernel:  [accel_clear+122/132] accel_clear+0x7a/0x84
Apr 25 15:41:40 gswi1164 kernel:  [fbcon_clear+270/280] fbcon_clear+0x10e/0x118
Apr 25 15:41:40 gswi1164 kernel:  [fbcon_scroll+1856/2420] fbcon_scroll+0x740/0x974
Apr 25 15:41:40 gswi1164 kernel:  [scrup+113/264] scrup+0x71/0x108
Apr 25 15:41:40 gswi1164 kernel:  [lf+51/100] lf+0x33/0x64
Apr 25 15:41:40 gswi1164 kernel:  [do_con_trol+373/3620] do_con_trol+0x175/0xe24
Apr 25 15:41:40 gswi1164 kernel:  [do_con_write+1442/1624] do_con_write+0x5a2/0x658
Apr 25 15:41:40 gswi1164 kernel:  [con_put_char+45/52] con_put_char+0x2d/0x34
Apr 25 15:41:40 gswi1164 kernel:  [opost+406/420] opost+0x196/0x1a4
Apr 25 15:41:40 gswi1164 kernel:  [write_chan+309/500] write_chan+0x135/0x1f4
Apr 25 15:41:40 gswi1164 kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Apr 25 15:41:40 gswi1164 kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Apr 25 15:41:40 gswi1164 kernel:  [tty_write+468/648] tty_write+0x1d4/0x288
Apr 25 15:41:40 gswi1164 kernel:  [write_chan+0/500] write_chan+0x0/0x1f4
Apr 25 15:41:40 gswi1164 kernel:  [vfs_write+183/240] vfs_write+0xb7/0xf0
Apr 25 15:41:40 gswi1164 kernel:  [sys_write+42/64] sys_write+0x2a/0x40
Apr 25 15:41:40 gswi1164 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 25 15:41:40 gswi1164 kernel:
Apr 25 15:41:40 gswi1164 kernel: Code: 89 18 83 c4 0c 83 7d c0 00 75 08 c7 45 c0 08 00 00 00 46 83
Apr 25 15:41:40 gswi1164 kernel:  <1>Unable to handle kernel paging request at virtual address c6c0e000
Apr 25 15:41:40 gswi1164 kernel:  printing eip:
Apr 25 15:41:40 gswi1164 kernel: c0232f36
Apr 25 15:41:40 gswi1164 kernel: Oops: 0002 [#2]
Apr 25 15:41:40 gswi1164 kernel: CPU:    0
Apr 25 15:41:40 gswi1164 kernel: EIP:    0060:[cfb_imageblit+630/1680]    Not tainted
Apr 25 15:41:40 gswi1164 kernel: EFLAGS: 00010246
Apr 25 15:41:40 gswi1164 kernel: EIP is at cfb_imageblit+0x276/0x690
Apr 25 15:41:40 gswi1164 kernel: eax: c6c0e000   ebx: 00000000   ecx: c6c0e004   edx: c0375ff8
Apr 25 15:41:40 gswi1164 kernel: esi: c10fb930   edi: 00000001   ebp: c5f83d54   esp: c5f83c84
Apr 25 15:41:40 gswi1164 kernel: ds: 007b   es: 007b   ss: 0068
Apr 25 15:41:40 gswi1164 kernel: Process events/0 (pid: 3, threadinfo=c5f82000 task=c5f92c60)
Apr 25 15:41:40 gswi1164 kernel: Stack: c6c0e000 c030d904 0000011d 00000010 c5f83e34 c5ef6918 00000010 07070707
Apr 25 15:41:40 gswi1164 kernel:        c5f83cb4 c012e1ac c5fc1340 0000000e c10fb931 c012e17e c34ad80c c5fc1340
Apr 25 15:41:40 gswi1164 kernel:        c34ad80c 00000000 c03def8c c5f83ce4 c0147995 c34ad80c c5fc889c c34ad80c
Apr 25 15:41:40 gswi1164 kernel: Call Trace:
Apr 25 15:41:40 gswi1164 kernel:  [mempool_free_slab+16/20] mempool_free_slab+0x10/0x14
Apr 25 15:41:40 gswi1164 kernel:  [mempool_free+122/132] mempool_free+0x7a/0x84
Apr 25 15:41:40 gswi1164 kernel:  [bio_destructor+69/76] bio_destructor+0x45/0x4c
Apr 25 15:41:40 gswi1164 kernel:  [bio_put+44/48] bio_put+0x2c/0x30
Apr 25 15:41:40 gswi1164 kernel:  [end_bio_bh_io_sync+35/52] end_bio_bh_io_sync+0x23/0x34
Apr 25 15:41:40 gswi1164 kernel:  [bio_endio+69/80] bio_endio+0x45/0x50
Apr 25 15:41:40 gswi1164 kernel:  [neofb_imageblit+41/48] neofb_imageblit+0x29/0x30
Apr 25 15:41:40 gswi1164 kernel:  [soft_cursor+514/544] soft_cursor+0x202/0x220
Apr 25 15:41:40 gswi1164 kernel:  [bio_destructor+69/76] bio_destructor+0x45/0x4c
Apr 25 15:41:40 gswi1164 kernel:  [bio_put+44/48] bio_put+0x2c/0x30
Apr 25 15:41:40 gswi1164 kernel:  [fbcon_cursor+837/860] fbcon_cursor+0x345/0x35c
Apr 25 15:41:40 gswi1164 kernel:  [mtrr_del_page+123/368] mtrr_del_page+0x7b/0x170
Apr 25 15:41:40 gswi1164 kernel:  [default_wake_function+23/28] default_wake_function+0x17/0x1c
Apr 25 15:41:40 gswi1164 kernel:  [__wake_up_common+54/80] __wake_up_common+0x36/0x50
Apr 25 15:41:40 gswi1164 kernel:  [set_cursor+109/132] set_cursor+0x6d/0x84
Apr 25 15:41:40 gswi1164 kernel:  [con_flush_chars+45/60] con_flush_chars+0x2d/0x3c
Apr 25 15:41:40 gswi1164 kernel:  [n_tty_receive_buf+4033/4188] n_tty_receive_buf+0xfc1/0x105c
Apr 25 15:41:40 gswi1164 kernel:  [soft_cursor+514/544] soft_cursor+0x202/0x220
Apr 25 15:41:40 gswi1164 kernel:  [fb_flashcursor+0/52] fb_flashcursor+0x0/0x34
Apr 25 15:41:40 gswi1164 kernel:  [mod_timer+250/356] mod_timer+0xfa/0x164
Apr 25 15:41:40 gswi1164 kernel:  [flush_to_ldisc+227/240] flush_to_ldisc+0xe3/0xf0
Apr 25 15:41:40 gswi1164 kernel:  [flush_to_ldisc+0/240] flush_to_ldisc+0x0/0xf0
Apr 25 15:41:40 gswi1164 kernel:  [worker_thread+419/624] worker_thread+0x1a3/0x270
Apr 25 15:41:40 gswi1164 kernel:  [worker_thread+0/624] worker_thread+0x0/0x270
Apr 25 15:41:40 gswi1164 kernel:  [flush_to_ldisc+0/240] flush_to_ldisc+0x0/0xf0
Apr 25 15:41:40 gswi1164 kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Apr 25 15:41:40 gswi1164 kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Apr 25 15:41:40 gswi1164 kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Apr 25 15:41:40 gswi1164 kernel:
Apr 25 15:41:40 gswi1164 kernel: Code: 89 18 83 c4 0c 83 7d c0 00 75 08 c7 45 c0 08 00 00 00 46 83


