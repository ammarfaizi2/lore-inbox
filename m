Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSKVNsO>; Fri, 22 Nov 2002 08:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbSKVNsO>; Fri, 22 Nov 2002 08:48:14 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:32190 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S264706AbSKVNsK>; Fri, 22 Nov 2002 08:48:10 -0500
Date: Fri, 22 Nov 2002 14:55:18 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48bk3: OOPS: Unable to handle kernel paging request
Message-ID: <20021122145518.A22062@cistron.nl>
References: <arl62a$m5a$1@ncc1701.cistron.net> <20021122120151.GK11884@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021122120151.GK11884@suse.de>; from axboe@suse.de on Fri, Nov 22, 2002 at 01:01:51PM +0100
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Jens Axboe:
> On Fri, Nov 22 2002, Miquel van Smoorenburg wrote:
> > 
> > This is still the same NNTP news server. I've loaded 2.5.48bk3,
> > since it died with 2.5.46bk3 during my vacation and crashes of
> > a few releases ago are probably not that interesting.
> 
> Most likely fixed by:
> 
> http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.48/2.5.48-mm1/broken-out/plugbug.patch

Okay, I did not reboot after the oops, and shortly thereafter the
machine locked up completely with the below messages. It might be
ofcourse that the OOPS got the machine generally unstable, but
I'm posting the logs here anyway just in case. Hope it is helpful.


Unable to handle kernel paging request at virtual address 1a3e7d69
 printing eip:
c17d007f
*pde = 00000000
Oops: 0002
CPU:	0
EIP:	0060:[<c17d007f>]    Not tainted
EFLAGS: 00010212
EIP is at 0xc17d007f
eax: c17d0069	ebx: f7d11cc8	ecx: f7692000	edx: f7693d2c
esi: f7693dcc	edi: 0039db67	ebp: f7693e0c	esp: f7693db8
ds: 0068   es: 0068   ss: 0068
Process innfeed (pid: 224, threadinfo=f7692000 task=f79c5940)
Stack: 02010010 c01dc170 f7693d2c f7692000 000003d0 f76975cc f7693dcc c013d580
       f778fed0 f773d3a0 f7693e04 00000020 f773d3ec 00000020 f773d3a0 00000020
       f778fee0 00000020 0043cf44 f7693e04 f7693e04 f778fed0 c013d698 f778fed0
Call Trace:
 [<c01dc170>] blk_run_queues+0xb0/0xc0
 [<c013d580>] do_page_cache_readahead+0x158/0x178
 [<c013d698>] page_cache_readahead+0xf8/0x124
 [<c012f7ed>] do_generic_mapping_read+0x51/0x378
 [<c012fdcd>] __generic_file_aio_read+0x1b9/0x1d4
 [<c012fb54>] file_read_actor+0x0/0xc0
 [<c012feb3>] generic_file_read+0x7b/0x98
 [<c012d341>] handle_mm_fault+0x85/0x130
 [<c01144c0>] do_page_fault+0x0/0x434
 [<c010eaa2>] old_mmap+0xda/0x114
 [<c0143c72>] vfs_read+0xc6/0x17c
 [<c014400c>] sys_pread64+0x3c/0x50
 [<c0108b4b>] syscall_call+0x7/0xb

Code: 00 a8 00 7d c1 58 00 7d c1 30 ec 97 f7 ba 79 3e 00 b8 00 7d

buffer layer error at fs/buffer.c:1644
Pass this trace through ksymoops for reporting
Call Trace:
 [<c01455a3>] __buffer_error+0x33/0x38
 [<c0146cdf>] __block_write_full_page+0x7f/0x3bc
 [<c0147d69>] block_write_full_page+0x2d/0x9c
 [<c014a284>] blkdev_get_block+0x0/0x48
 [<c014a383>] blkdev_writepage+0xf/0x14
 [<c014a284>] blkdev_get_block+0x0/0x48
 [<c0161bb6>] mpage_writepages+0x21a/0x398
 [<c014a374>] blkdev_writepage+0x0/0x14
 [<c014b49d>] generic_writepages+0x11/0x15
 [<c013e048>] do_writepages+0x18/0x30
 [<c013e022>] generic_vm_writeback+0x32/0x40
 [<c0136140>] shrink_list+0x2e0/0x510
 [<c0135815>] __pagevec_release+0x15/0x20
 [<c0136c22>] refill_inactive_zone+0x562/0x630
 [<c0136556>] shrink_cache+0x1e6/0x350
 [<c0136d70>] shrink_zone+0x80/0x88
 [<c0136f7e>] balance_pgdat+0x9e/0xfc
 [<c01370e4>] kswapd+0x108/0x112
 [<c0136fdc>] kswapd+0x0/0x112
 [<c0118518>] autoremove_wake_function+0x0/0x40
 [<c0118518>] autoremove_wake_function+0x0/0x40
 [<c0106ea1>] kernel_thread_helper+0x5/0xc

invalid operand: 0000
CPU:	0
EIP:	0060:[<c0140068>]    Not tainted
EFLAGS: 00010206
EIP is at .text.lock.swap_state+0x9/0x41
eax: c0140068	ebx: f7d11cc8	ecx: f7692000	edx: f7693d54
esi: f7693df4	edi: f7693e44	ebp: 00000000	esp: f7693de4
ds: 0068   es: 0068   ss: 0068
Process innfeed (pid: 604, threadinfo=f7692000 task=f79c5940)
Stack: c01dc170 f7693d54 c11a23e0 f7693e30 f7693df4 f7693df4 c0148179 c012f298
       c11a23e0 f7692000 c11a23e0 00000000 00409ddf c1a025c0 00000000 f79c5940
       c0118518 f7693e3c f7693e3c 00000000 f79c5940 c0118518 c1a025c4 c1a025c4
Call Trace:
 [<c01dc170>] blk_run_queues+0xb0/0xc0
 [<c0148179>] block_sync_page+0x5/0x8
 [<c012f298>] wait_on_page_bit+0x8c/0xb8
 [<c0118518>] autoremove_wake_function+0x0/0x40
 [<c0118518>] autoremove_wake_function+0x0/0x40
 [<c012f9a5>] do_generic_mapping_read+0x209/0x378
 [<c012fdcd>] __generic_file_aio_read+0x1b9/0x1d4
 [<c012fb54>] file_read_actor+0x0/0xc0
 [<c012feb3>] generic_file_read+0x7b/0x98
 [<c012d341>] handle_mm_fault+0x85/0x130
 [<c01144c0>] do_page_fault+0x0/0x434
 [<c010eaa2>] old_mmap+0xda/0x114
 [<c0143c72>] vfs_read+0xc6/0x17c
 [<c014400c>] sys_pread64+0x3c/0x50
 [<c0108b4b>] syscall_call+0x7/0xb

Code: ff e8 e2 7b fc ff e9 dc fb ff ff e8 d8 7b fc ff e9 e5 fb ff
 <1>Unable to handle kernel paging request at virtual address 08dc7501
 printing eip:
08dc7501
*pde = 00000000
Oops: 0000
CPU:	1
EIP:	0060:[<08dc7501>]    Not tainted
EFLAGS: 00010006
EIP is at 0x8dc7501
eax: 08dc7501	ebx: 00000000	ecx: 00000003	edx: f7693e3c
esi: 00000000	edi: fe192000	ebp: f7693bc8	esp: f7693bac
ds: 0068   es: 0068   ss: 0068
Process innd (pid: 7182, threadinfo=f7692000 task=f79c5940)
Stack: c0116753 f7693e30 00000003 00000000 f7692000 00000286 c1a025c0 f7693bec
       c0116798 c1a025c0 00000003 00000000 00000000 c10e3300 c1a025c0 00000007
       0000002a c012f2fd c10e3300 00000010 c013ff69 c10e3300 c12793e0 c0413670
Call Trace:
 [<c0116753>] __wake_up_common+0x33/0x4c
 [<c0116798>] __wake_up+0x2c/0x50
 [<c012f2fd>] unlock_page+0x39/0x3c
 [<c013ff69>] free_pages_and_swap_cache+0x51/0x80
 [<c012bdea>] zap_pte_range+0x1a2/0x1f0
 [<c012be6d>] zap_pmd_range+0x35/0x50
 [<c012bec2>] unmap_page_range+0x3a/0x5c
 [<c012ec06>] exit_mmap+0xe2/0x1e4
 [<c01187c6>] mmput+0x52/0x6c
 [<c014ca22>] exec_mmap+0x1da/0x204
 [<c014cae6>] flush_old_exec+0x2a/0x800
 [<c01676fe>] load_elf_binary+0x2ea/0xb1c
 [<c0167871>] load_elf_binary+0x45d/0xb1c
 [<c0167414>] load_elf_binary+0x0/0xb1c
 [<c0210e35>] sym_queue_scsiio+0x1f9/0x204
 [<c014d624>] search_binary_handler+0xe4/0x2c0
 [<c014d9a3>] do_execve+0x1a3/0x250
 [<c014d9ba>] do_execve+0x1ba/0x250
 [<c01075bb>] sys_execve+0x2f/0x60
 [<c0108b4b>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <6>note: innd[7182] exited with preempt_count 2
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c01180a8>] __might_sleep+0x54/0x58
 [<c011c5f2>] do_exit+0xf6/0x458
 [<c0109ad7>] die+0x87/0x88
 [<c01147b7>] do_page_fault+0x2f7/0x434
 [<c01144c0>] do_page_fault+0x0/0x434
 [<c0116709>] default_wake_function+0x1d/0x34
 [<c0116753>] __wake_up_common+0x33/0x4c
 [<c0116798>] __wake_up+0x2c/0x50
 [<c01157a5>] try_to_wake_up+0x20d/0x218
 [<c010958d>] error_code+0x2d/0x38
 [<c0110068>] ipi_handler+0xc/0x64
 [<c0116753>] __wake_up_common+0x33/0x4c
 [<c0116798>] __wake_up+0x2c/0x50
 [<c012f2fd>] unlock_page+0x39/0x3c
 [<c013ff69>] free_pages_and_swap_cache+0x51/0x80
 [<c012bdea>] zap_pte_range+0x1a2/0x1f0
 [<c012be6d>] zap_pmd_range+0x35/0x50
 [<c012bec2>] unmap_page_range+0x3a/0x5c
 [<c012ec06>] exit_mmap+0xe2/0x1e4
 [<c01187c6>] mmput+0x52/0x6c
 [<c014ca22>] exec_mmap+0x1da/0x204
 [<c014cae6>] flush_old_exec+0x2a/0x800
 [<c01676fe>] load_elf_binary+0x2ea/0xb1c
 [<c0167871>] load_elf_binary+0x45d/0xb1c
 [<c0167414>] load_elf_binary+0x0/0xb1c
 [<c0210e35>] sym_queue_scsiio+0x1f9/0x204
 [<c014d624>] search_binary_handler+0xe4/0x2c0
 [<c014d9a3>] do_execve+0x1a3/0x250
 [<c014d9ba>] do_execve+0x1ba/0x250
 [<c01075bb>] sys_execve+0x2f/0x60
 [<c0108b4b>] syscall_call+0x7/0xb


** as dead in the water as the Prestige at this point **

Mike.
