Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbUCJSEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbUCJSEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:04:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40583 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262726AbUCJSAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:00:53 -0500
Date: Wed, 10 Mar 2004 13:03:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Michael Sauer <sauer@okolni.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: bad: scheduling while atomic! / kernel 2.6.2
In-Reply-To: <200403101834.59148.sauer@okolni.de>
Message-ID: <Pine.LNX.4.53.0403101252250.18608@chaos>
References: <200403101834.59148.sauer@okolni.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Michael Sauer wrote:

> I get this about once in a month and filled a bugreport in february (via
> e-mail), but didn't hear anything, trying here now.
>
> Symptoms: Running some random x application, the system seems to freeze
> short,
> then i get input back for about 1 minute but cannot run any new application
> (can't even login at console). The example below was triggered by opera.
> > Important hardware: amd duron 1300 (not overclocked), gigabye 7zxr,
nvidia  gforce 2 (with newest nvidia drivers 1.0-5336)
> [18:25:52]root@vivane:/proc>cat interrupts
> CPU0
> 0: 1642874 XT-PIC  timer
> 2: 0 XT-PIC  cascade
> 5: 2 XT-PIC  bttv0
> 8: 4 XT-PIC  rtc
> 9: 30416 XT-PIC  Ensoniq AudioPCI, eth0
> 10: 203081 XT-PIC  Ensoniq AudioPCI, uhci_hcd, uhci_hcd
> 11: 132737 XT-PIC  nvidia
> 14: 17761 XT-PIC  ide0
> 15: 20 XT-PIC  ide1
> NMI: 0
> LOC: 1642806
> ERR: 3649
> MIS: 0
> [18:25:54]root@vivane:/proc>cat dma
> 4: cascade
>
> taken from kern.log:
> 17:55:58 vivane kernel: Unable to handle kernel paging request at virtual
> address 1400000c
> 17:55:58 vivane kernel:  printing eip:
> 17:55:58 vivane kernel: c013f22e
> 17:55:58 vivane kernel: *pde = 00000000
> 17:55:58 vivane kernel: Oops: 0002 [#1]
> 17:55:58 vivane kernel: CPU:    0
> 17:55:58 vivane kernel: EIP:    0060:[<c013f22e>]    Tainted: P
> 17:55:58 vivane kernel: EFLAGS: 00010002
> 17:55:58 vivane kernel: EIP is at cache_alloc_refill+0xce/0x220
> 17:55:58 vivane kernel: eax: 14000008   ebx: f7e0dac0   ecx: 0000000b   edx:
> c1be1a50
> 17:55:58 vivane kernel: esi: d2be0080   edi: c1be1a44   ebp: f7e0dad0   esp:
> d8061e0c
> 17:55:58 vivane kernel: ds: 007b   es: 007b   ss: 0068
> 17:55:58 vivane kernel: Process opera (pid: 13216, threadinfo=d8060000
> task=f747acc0)
> 17:55:58 vivane kernel: Stack: 00000010 00000202 c03e2914 d436d0d8 c1be1a50
> c1be1a58 00000246 00000050
> 17:55:58 vivane kernel:        c1be1a44 df0b48c0 c013f5d6 c1be1a44 00000050
> ec2c494c f7973e00 ec2c494c
> 17:55:58 vivane kernel:        c0196b98 c1be1a44 00000050 c016d5dc f7973e00
> e138de74 ec2c494c d100b3c8
> 17:55:58 vivane kernel: Call Trace:
> 17:55:58 vivane kernel:  [<c013f5d6>] kmem_cache_alloc+0x56/0x70
> 17:55:58 vivane kernel:  [<c0196b98>] ext3_alloc_inode+0x18/0x40
> 17:55:58 vivane kernel:  [<c016d5dc>] alloc_inode+0x1c/0x150
> 17:55:58 vivane kernel:  [<c016dfcc>] new_inode+0x1c/0x80
> 17:55:58 vivane kernel:  [<c018d7c5>] ext3_new_inode+0x45/0x790
> 17:55:58 vivane kernel:  [<c016c410>] d_alloc+0x20/0x200
> 17:55:58 vivane kernel:  [<c0194d75>] ext3_create+0x55/0xb0
> 17:55:58 vivane kernel:  [<c0163656>] vfs_create+0x76/0xd0
> 17:55:58 vivane kernel:  [<c0163c49>] open_namei+0x3e9/0x450
> 17:55:58 vivane kernel:  [<c015355e>] filp_open+0x3e/0x70
> 17:55:58 vivane kernel:  [<c0153a1b>] sys_open+0x5b/0x90
> 17:55:58 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
> 17:55:58 vivane kernel:
> 17:55:58 vivane kernel: Code: 89 50 04 89 02 c7 46 04 00 02 20 00 83 7e 14 ff
> c7 06 00 01
> 17:55:58 vivane kernel:  <6>note: opera[13216] exited with preempt_count 1
> 17:55:58 vivane kernel: Debug: sleeping function called from invalid context
> at include/linux/rwsem.h:43
> 17:55:58 vivane kernel: in_atomic():1, irqs_disabled():0
> 17:55:58 vivane kernel: Call Trace:
> 17:55:58 vivane kernel:  [<c011d02b>] __might_sleep+0xab/0xd0
> 17:55:58 vivane kernel:  [<c0121667>] do_exit+0xa7/0x440
> 17:55:58 vivane kernel:  [<c01199c0>] do_page_fault+0x0/0x53c
> 17:55:58 vivane kernel:  [<c010a501>] die+0xe1/0xf0
> 17:55:58 vivane kernel:  [<c0119b9e>] do_page_fault+0x1de/0x53c
> 17:55:58 vivane kernel:  [<c018ed6c>] ext3_get_block_handle+0xac/0x360
> 17:55:58 vivane kernel:  [<c015706e>] __find_get_block+0x6e/0x100
> 17:55:58 vivane kernel:  [<c01199c0>] do_page_fault+0x0/0x53c
> 17:55:58 vivane kernel:  [<c0109e45>] error_code+0x2d/0x38
> 17:55:58 vivane kernel:  [<c013f22e>] cache_alloc_refill+0xce/0x220
> 17:55:58 vivane kernel:  [<c013f5d6>] kmem_cache_alloc+0x56/0x70
> 17:55:58 vivane kernel:  [<c0196b98>] ext3_alloc_inode+0x18/0x40
> 17:55:58 vivane kernel:  [<c016d5dc>] alloc_inode+0x1c/0x150
> 17:55:58 vivane kernel:  [<c016dfcc>] new_inode+0x1c/0x80
> 17:55:58 vivane kernel:  [<c018d7c5>] ext3_new_inode+0x45/0x790
> 17:55:58 vivane kernel:  [<c016c410>] d_alloc+0x20/0x200
> 17:55:58 vivane kernel:  [<c0194d75>] ext3_create+0x55/0xb0
> 17:55:58 vivane kernel:  [<c0163656>] vfs_create+0x76/0xd0
> 17:55:58 vivane kernel:  [<c0163c49>] open_namei+0x3e9/0x450
> 17:55:58 vivane kernel:  [<c015355e>] filp_open+0x3e/0x70
> 17:55:58 vivane kernel:  [<c0153a1b>] sys_open+0x5b/0x90
> 17:55:58 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
> 17:55:58 vivane kernel:
> 17:55:58 vivane kernel: bad: scheduling while atomic!
> 17:55:58 vivane kernel: Call Trace:
> 17:55:58 vivane kernel:  [<c011bbdd>] schedule+0x56d/0x580
> 17:55:58 vivane kernel:  [<c0144aa3>] unmap_page_range+0x43/0x70
> 17:55:58 vivane kernel:  [<c0144c84>] unmap_vmas+0x1b4/0x210
> 17:55:58 vivane kernel:  [<c0148bab>] exit_mmap+0x7b/0x190
> 17:55:58 vivane kernel:  [<c011d6e4>] mmput+0x64/0xc0
> 17:55:58 vivane kernel:  [<c01216c6>] do_exit+0x106/0x440
> 17:55:58 vivane kernel:  [<c01199c0>] do_page_fault+0x0/0x53c
> 17:55:58 vivane kernel:  [<c010a501>] die+0xe1/0xf0
> 17:55:58 vivane kernel:  [<c0119b9e>] do_page_fault+0x1de/0x53c
> 17:55:58 vivane kernel:  [<c018ed6c>] ext3_get_block_handle+0xac/0x360
> 17:55:58 vivane kernel:  [<c015706e>] __find_get_block+0x6e/0x100
> 17:55:58 vivane kernel:  [<c01199c0>] do_page_fault+0x0/0x53c
> 17:55:58 vivane kernel:  [<c0109e45>] error_code+0x2d/0x38
> 17:55:58 vivane kernel:  [<c013f22e>] cache_alloc_refill+0xce/0x220
> 17:55:58 vivane kernel:  [<c013f5d6>] kmem_cache_alloc+0x56/0x70
> 17:55:58 vivane kernel:  [<c0196b98>] ext3_alloc_inode+0x18/0x40
> 17:55:58 vivane kernel:  [<c016d5dc>] alloc_inode+0x1c/0x150
> 17:55:58 vivane kernel:  [<c016dfcc>] new_inode+0x1c/0x80
> 17:55:58 vivane kernel:  [<c018d7c5>] ext3_new_inode+0x45/0x790
> 17:55:58 vivane kernel:  [<c016c410>] d_alloc+0x20/0x200
> 17:55:58 vivane kernel:  [<c0194d75>] ext3_create+0x55/0xb0
> 17:55:58 vivane kernel:  [<c0163656>] vfs_create+0x76/0xd0
> 17:55:58 vivane kernel:  [<c0163c49>] open_namei+0x3e9/0x450
> 17:55:58 vivane kernel:  [<c015355e>] filp_open+0x3e/0x70
> 17:55:58 vivane kernel:  [<c0153a1b>] sys_open+0x5b/0x90
> 17:55:58 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
>
> The bad: scheduling while atomic! messages didn't stop so i only took the
> first one. I had to reset the computer because no input was possible anymore.
> --
> 	mIc

17:55:58 vivane kernel: EIP:    0060:[<c013f22e>]    Tainted: P
                                                    ^^^^^^^^^^^
NVida Gforce 2 -------------------------------------|

Important hardware: amd duron 1300 (not overclocked), gigabye 7zxr,
nvidia  gforce 2 (with newest nvidia drivers 1.0-5336)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        |_____________ Looks like somebody tried to fault-
in a new page, but couldn't because the interrupts were
disabled. This could, of course, be a problem in the ext3
file-system code, but is more likely caused by the Nvida
driver allowing a schedule under a spin-lock or at least
with the interrupts disabled.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


