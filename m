Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbTDVV1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTDVV1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:27:41 -0400
Received: from [66.212.224.118] ([66.212.224.118]:18697 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S263872AbTDVV1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:27:39 -0400
Date: Tue, 22 Apr 2003 17:31:46 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.68-mm1 ext3 block allocator hates me
Message-ID: <Pine.LNX.4.50.0304221729200.2085-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel paging request at virtual address c3900f24
 printing eip:
c019948c
*pde = 0000f067
*pte = 03900000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c019948c>]    Not tainted VLI
EFLAGS: 00010246
EIP is at find_next_usable_block+0x1bc/0x310
eax: ffffffff   ebx: c390046c   ecx: 00000037   edx: 00000000
esi: 00000013   edi: c3900f24   ebp: 0000234d   esp: c4d3bb4c
ds: 007b   es: 007b   ss: 0068
Process dbench (pid: 1213, threadinfo=c4d3a000 task=c462ed00)
Stack: cbcd8efc 00000000 c015f187 cbcd8efc 00008000 ffffffff 00000000 c4e8573c 
       c0199626 ffffffff c4e8573c 00008000 00000000 00000016 cb7242c0 c3926994 
       cbdd9b40 c0199de3 cbdd9b40 c3336d0c 00000016 c4e8573c ffffffff c4d3bbe0 
Call Trace:
 [<c015f187>] __getblk+0x17/0x30
 [<c0199626>] ext3_try_to_allocate+0x46/0x190
 [<c0199de3>] ext3_new_block+0x673/0x780
 [<c010a49a>] apic_timer_interrupt+0x1a/0x20
 [<c0142900>] check_poison_obj+0x30/0x170
 [<c019c26d>] ext3_alloc_block+0x1d/0x30
 [<c019c5ef>] ext3_alloc_branch+0x3f/0x250
 [<c0142900>] check_poison_obj+0x30/0x170
 [<c01a7017>] do_get_write_access+0x3e7/0x7b0
 [<c019caf5>] ext3_get_block_handle+0x155/0x2c0
 [<c0142900>] check_poison_obj+0x30/0x170
 [<c0142900>] check_poison_obj+0x30/0x170
 [<c014436a>] kmem_cache_alloc+0x11a/0x170
 [<c01615d3>] alloc_buffer_head+0x13/0x60
 [<c015eaee>] create_buffers+0x4e/0x90
 [<c019cc97>] ext3_get_block+0x37/0x70
 [<c015fb87>] __block_prepare_write+0x1f7/0x4b0
 [<c026afdf>] n_tty_receive_buf+0x24f/0x1500
 [<c026af95>] n_tty_receive_buf+0x205/0x1500
 [<c014601e>] release_pages+0x21e/0x260
 [<c0142900>] check_poison_obj+0x30/0x170
 [<c01a6338>] start_this_handle+0xa8/0x1e0
 [<c0160620>] block_prepare_write+0x20/0x40
 [<c019cc60>] ext3_get_block+0x0/0x70
 [<c019d0e5>] ext3_prepare_write+0x45/0xe0
 [<c019cc60>] ext3_get_block+0x0/0x70
 [<c013ddae>] generic_file_aio_write_nolock+0x32e/0xa40
 [<c026e267>] pty_write+0x177/0x180
 [<c013e5c0>] generic_file_aio_write+0x70/0x90
 [<c019abaa>] ext3_file_write+0x2a/0xc0
 [<c015c35d>] do_sync_write+0x7d/0xb0
 [<c01169d5>] smp_apic_timer_interrupt+0xf5/0x160
 [<c0267415>] tty_write+0x215/0x3b0
 [<c026d130>] write_chan+0x0/0x260
 [<c015c43c>] vfs_write+0xac/0xf0
 [<c015c4ea>] sys_write+0x2a/0x40
 [<c01094f7>] syscall_call+0x7/0xb

Code: d0 5b 5e 5f 5d c3 89 c6 83 c7 04 89 f8 8b 5c 24 2c 29 d0 31 d2 c1 e0 
03 29 c3 74 23 8d 4b 1f 89 fb c1 e9 05 b8 ff ff ff ff 31 d2 <f3> af 74

0xc0199466 <find_next_usable_block+406>:        ret
0xc0199467 <find_next_usable_block+407>:        mov    %eax,%esi
0xc0199469 <find_next_usable_block+409>:        add    $0x4,%edi
0xc019946c <find_next_usable_block+412>:        mov    %edi,%eax
0xc019946e <find_next_usable_block+414>:        mov    0x2c(%esp,1),%ebx
0xc0199472 <find_next_usable_block+418>:        sub    %edx,%eax
0xc0199474 <find_next_usable_block+420>:        xor    %edx,%edx
0xc0199476 <find_next_usable_block+422>:        shl    $0x3,%eax
0xc0199479 <find_next_usable_block+425>:        sub    %eax,%ebx
0xc019947b <find_next_usable_block+427>:        je     0xc01994a0 <find_next_usable_block+464>
0xc019947d <find_next_usable_block+429>:        lea    0x1f(%ebx),%ecx
0xc0199480 <find_next_usable_block+432>:        mov    %edi,%ebx
0xc0199482 <find_next_usable_block+434>:        shr    $0x5,%ecx
0xc0199485 <find_next_usable_block+437>:        mov    $0xffffffff,%eax
0xc019948a <find_next_usable_block+442>:        xor    %edx,%edx
0xc019948c <find_next_usable_block+444>:        repz scas %es:(%edi),%eax <=========
0xc019948e <find_next_usable_block+446>:        je     0xc0199499 <find_next_usable_block+457>
0xc0199490 <find_next_usable_block+448>:        xor    0xfffffffc(%edi),%eax
0xc0199493 <find_next_usable_block+451>:        sub    $0x4,%edi
0xc0199496 <find_next_usable_block+454>:        bsf    %eax,%edx
0xc0199499 <find_next_usable_block+457>:        sub    %ebx,%edi
0xc019949b <find_next_usable_block+459>:        shl    $0x3,%edi
0xc019949e <find_next_usable_block+462>:        add    %edi,%edx
0xc01994a0 <find_next_usable_block+464>:        lea    (%esi,%ebp,1),%eax
0xc01994a3 <find_next_usable_block+467>:        add    %edx,%eax
0xc01994a5 <find_next_usable_block+469>:        jmp    0xc019944a <find_next_usable_block+378>
