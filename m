Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264197AbUEMNst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbUEMNst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUEMNst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:48:49 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:5805 "EHLO
	mail-relay-2.tiscali.i") by vger.kernel.org with ESMTP
	id S264197AbUEMNsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:48:42 -0400
Date: Thu, 13 May 2004 15:48:47 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040513134847.GA2024@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I tried 2.6.6 + 4KB stack and I see a hard lockup (no ping, no sysrq)
when switching from X to console. 
I'm using the new radeonfb and XFree 4.3.0 with "ati" driver (not the
binary one).

I captured the log via netconsole:

[XFree started]
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
[Switch]
hStart = 1048, hEnd = 1184, hTotal = 1344
vStart = 771, vEnd = 777, vTotal = 806
h_total_disp = 0x7f00a7	   hsync_strt_wid = 0x910422
v_total_disp = 0x2ff0325	   vsync_strt_wid = 0x860302
pixclock = 15384
freq = 6500
post div = 0x2
fb_div = 0x74
ppll_div_3 = 0x20074
do_IRQ: stack overflow: 460
Call Trace:
 [<c01086be>] do_IRQ+0x3fe/0x410
 [<c011c902>] __wake_up_locked+0x22/0x30
 [<c010633c>] common_interrupt+0x18/0x20
 [<c02e1baa>] radeon_write_pll_regs+0xbaa/0x1e10
 [<c011c902>] __wake_up_locked+0x22/0x30
 [<c02e3c5c>] radeon_calc_pll_regs+0xfc/0x120
 [<c02e333c>] radeon_write_mode+0x35c/0xb80
 [<c02e4509>] radeonfb_set_par+0x889/0xb50
 [<c011b59e>] recalc_task_prio+0x8e/0x1b0
 [<c014dd24>] buffered_rmqueue+0xf4/0x2c0
 [<c011b81a>] try_to_wake_up+0x15a/0x290
 [<c011c75a>] __wake_up_common+0x3a/0x60
 [<c0137397>] queue_work+0x57/0x70
 [<c02885b9>] as_add_request+0x199/0x200
 [<c027ec9d>] __elv_add_request+0x2d/0x40
 [<c02829f3>] __make_request+0x463/0x730
 [<c0103aa6>] __switch_to+0x116/0x180
 [<c0378aed>] schedule+0x3ad/0x8d0
 [<c0173922>] __wait_on_buffer+0xa2/0xc0
 [<c0176416>] __find_get_block+0x76/0x110
 [<c01764df>] __getblk+0x2f/0x60
 [<c01e13a2>] is_tree_node+0x62/0x70
 [<c01e1aa1>] search_by_key+0x6f1/0xee0
 [<f1a13b2f>] xfs_bmbt_get_state+0x2f/0x40 [xfs]
 [<f1a0ab67>] xfs_bmap_do_search_extents+0xd7/0x3c0 [xfs]
 [<c01e2430>] search_for_position_by_key+0x1a0/0x3c0
 [<c01c93c4>] make_cpu_key+0x54/0x60
 [<c01e10d3>] pathrelse+0x23/0x40
 [<c01c9bb1>] _get_block_create_0+0x711/0x7b0
 [<c0207354>] __delay+0x14/0x20
 [<c01cb78e>] reiserfs_get_block+0x158e/0x1770
 [<c014bec3>] mempool_alloc+0x63/0x2d0
 [<c028763f>] as_update_iohist+0x11f/0x220
 [<c028776c>] as_update_arq+0x2c/0x70
 [<c02885b9>] as_add_request+0x199/0x200
 [<c02814c9>] get_request+0x279/0x5a0
 [<c027ec9d>] __elv_add_request+0x2d/0x40
 [<c0282941>] __make_request+0x3b1/0x730
 [<c0282e1d>] generic_make_request+0x15d/0x1e0
 [<c014bec3>] mempool_alloc+0x63/0x2d0
 [<c011e850>] autoremove_wake_function+0x0/0x50
 [<c014d62f>] __rmqueue+0xbf/0x110
 [<c014dd24>] buffered_rmqueue+0xf4/0x2c0
 [<c014df92>] __alloc_pages+0xa2/0x300
 [<c02f2d8a>] radeon_match_mode+0xaa/0x1a0
 [<c02dffd0>] radeonfb_check_var+0x0/0x380
 [<c02e000a>] radeonfb_check_var+0x3a/0x380
 [<c02da3c6>] fb_set_var+0xe6/0xf0
 [<c02d8319>] fbcon_blank+0xb9/0x220
 [<c0176416>] __find_get_block+0x76/0x110
 [<c026532a>] do_unblank_screen+0x8a/0x160
 [<c025aba6>] vt_ioctl+0x366/0x1b60
 [<c0148946>] unlock_page+0x16/0x50
 [<c015cad2>] do_wp_page+0x422/0x5a0
 [<c015e430>] handle_mm_fault+0x220/0x300
 [<c011a2d0>] do_page_fault+0x360/0x57e
 [<c025a840>] vt_ioctl+0x0/0x1b60
 [<c025379e>] tty_ioctl+0x51e/0x610
 [<c019a763>] iput+0x63/0x80
 [<c018c165>] sys_ioctl+0x205/0x3e0
 [<c01059cf>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address 76656467
 printing eip:
c011c1b2
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c011c1b2>]    Not tainted
EFLAGS: 00013897   (2.6.64kstack) 
EIP is at scheduler_tick+0x102/0x650
eax: 7665645f   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: c03d3830   edi: c0492020   ebp: c048df6c   esp: c048df3c
ds: 007b   es: 007b   ss: 0068
Process _driver (pid: 1701076837, threadinfo=c048d000 task=c03d3830)
Stack: 00000000 00000000 c027efdf efde5400 c048df8c c02a40fb efde5400 00000000 
       00000000 00000000 00000001 00000000 c048df8c c012cc56 00000000 00000001 
       00000001 00000000 00000000 ef373240 c048df9c c012d0f5 00000000 00000000 
Call Trace:
 [<c027efdf>] elv_queue_empty+0x1f/0x30
 [<c02a40fb>] ide_do_request+0x5b/0x4b0
 [<c012cc56>] update_process_times+0x46/0x50
 [<c012d0f5>] do_timer+0x35/0xf0
 [<c010e1a6>] timer_interrupt+0x176/0x3b0
 [<c02ace90>] ide_dma_intr+0x0/0xb0
 [<c0107dcb>] handle_IRQ_event+0x3b/0x70
 [<c010843d>] do_IRQ+0x17d/0x410
 =======================
 [<c011c902>] __wake_up_locked+0x22/0x30
 [<c010633c>] common_interrupt+0x18/0x20
 [<c02e1baa>] radeon_write_pll_regs+0xbaa/0x1e10
 [<c011c902>] __wake_up_locked+0x22/0x30
 [<c02e3c5c>] radeon_calc_pll_regs+0xfc/0x120
 [<c02e333c>] radeon_write_mode+0x35c/0xb80
 [<c02e4509>] radeonfb_set_par+0x889/0xb50
 [<c011b59e>] recalc_task_prio+0x8e/0x1b0
 [<c014dd24>] buffered_rmqueue+0xf4/0x2c0
 [<c011b81a>] try_to_wake_up+0x15a/0x290
 [<c011c75a>] __wake_up_common+0x3a/0x60
 [<c0137397>] queue_work+0x57/0x70
 [<c02885b9>] as_add_request+0x199/0x200
 [<c027ec9d>] __elv_add_request+0x2d/0x40
 [<c02829f3>] __make_request+0x463/0x730
 [<c0103aa6>] __switch_to+0x116/0x180
 [<c0378aed>] schedule+0x3ad/0x8d0
 [<c0173922>] __wait_on_buffer+0xa2/0xc0
 [<c0176416>] __find_get_block+0x76/0x110
 [<c01764df>] __getblk+0x2f/0x60
 [<c01e13a2>] is_tree_node+0x62/0x70
 [<c01e1aa1>] search_by_key+0x6f1/0xee0
 [<f1a13b2f>] xfs_bmbt_get_state+0x2f/0x40 [xfs]
 [<f1a0ab67>] xfs_bmap_do_search_extents+0xd7/0x3c0 [xfs]
 [<c01e2430>] search_for_position_by_key+0x1a0/0x3c0
 [<c01c93c4>] make_cpu_key+0x54/0x60
 [<c01e10d3>] pathrelse+0x23/0x40
 [<c01c9bb1>] _get_block_create_0+0x711/0x7b0
 [<c0207354>] __delay+0x14/0x20
 [<c01cb78e>] reiserfs_get_block+0x158e/0x1770
 [<c014bec3>] mempool_alloc+0x63/0x2d0
 [<c028763f>] as_update_iohist+0x11f/0x220
 [<c028776c>] as_update_arq+0x2c/0x70
 [<c02885b9>] as_add_request+0x199/0x200
 [<c02814c9>] get_request+0x279/0x5a0
 [<c027ec9d>] __elv_add_request+0x2d/0x40
 [<c0282941>] __make_request+0x3b1/0x730
 [<c0282e1d>] generic_make_request+0x15d/0x1e0
 [<c014bec3>] mempool_alloc+0x63/0x2d0
 [<c011e850>] autoremove_wake_function+0x0/0x50
 [<c014d62f>] __rmqueue+0xbf/0x110
 [<c014dd24>] buffered_rmqueue+0xf4/0x2c0
 [<c014df92>] __alloc_pages+0xa2/0x300
 [<c02f2d8a>] radeon_match_mode+0xaa/0x1a0
 [<c02dffd0>] radeonfb_check_var+0x0/0x380
 [<c02e000a>] radeonfb_check_var+0x3a/0x380
 [<c02da3c6>] fb_set_var+0xe6/0xf0
 [<c02d8319>] fbcon_blank+0xb9/0x220
 [<c0176416>] __find_get_block+0x76/0x110
 [<c026532a>] do_unblank_screen+0x8a/0x160
 [<c025aba6>] vt_ioctl+0x366/0x1b60
 [<c0148946>] unlock_page+0x16/0x50
 [<c015cad2>] do_wp_page+0x422/0x5a0
 [<c015e430>] handle_mm_fault+0x220/0x300
 [<c011a2d0>] do_page_fault+0x360/0x57e
 [<c025a840>] vt_ioctl+0x0/0x1b60
 [<c025379e>] tty_ioctl+0x51e/0x610
 [<c019a763>] iput+0x63/0x80
 [<c018c165>] sys_ioctl+0x205/0x3e0
 [<c01059cf>] syscall_call+0x7/0xb

Code: 0f ba 68 08 03 83 c4 24 5b 5e 5f c9 c3 90 b8 00 f0 ff ff 21 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

I don't see why reiserfs and xfs are both on the call stack, but the
problem seems related to radeonfb.

Full dmesg and config are attached.

Luca
-- 
Home: http://kronoz.cjb.net
Una donna sposa un uomo sperando che cambi, e lui non cambiera`. Un
uomo sposa una donna sperando che non cambi, e lei cambiera`.
