Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTF1QBn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTF1QBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 12:01:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:29850 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265269AbTF1QBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 12:01:19 -0400
Date: Sat, 28 Jun 2003 08:36:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.73-mm1 falling over in SDET
Message-ID: <49400000.1056814561@[10.10.2.4]>
In-Reply-To: <45120000.1056810681@[10.10.2.4]>
References: <45120000.1056810681@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The killer SDET has got you, but this is all I got from the chewed
> remains. Maybe the EIP is enough? ;-) I guess that's a NULL ptr
> dereference, though garbled somewhat.

Repeated it and got a much better panic. This is with feral isp driver
+ Mike's patch, BTW. Maybe it's just some stack overflow?

M.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c01c437d
*pde = 00104001
*pte = 00000000
Oops: 0002 [#1]
SMP 
CPU:    -1072977734
EIP:    0060:[<c01c437d>]    Not tainted VLI
EFLAGS: 00010003
EIP is at drive_stat_acct+0x79/0xcc
eax: 00000000   ebx: ec7dfa40   ecx: c0338000   edx: ef6089a0
esi: 00000001   edi: 00000400   ebp: 00001055   esp: c03381a4
ds: 007b   es: 007b   ss: 0068
Process 2 pages of KVA for lmem_map of node 3
Shrinking node 3 from 4194304 pages to 4183552 pages
Reserving total of 32256 pages for numa KVA remap
15488MB HIGHMEM available.
770MB LOWMEM available.
min_low_pfn = 952, max_low_pfn = 197120, highstart_pfn = 229376
Low memory ends at vaddr f0200000
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f5600000 - f8000000
node 2 will remap to vaddr f2c00000 - f5600000
node 3 will remap to vaddr f0200000 - f2c00000
High memory starts at vaddr f8000000
found SMP MP-table at 000f6040
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 193024 pages, LIFO batch:16
  HighMem zone: 851456 pages, LIFO batch:16
BUG: wrong zone alignment, it will crash
On node 1 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO 
Stack: ec7dfa40 ef611e00 00000206 c01c42d3 ec7dfa40 00000400 00000001 ef599c00 
       c3b9c000 ed83b820 c01d3679 ef611e00 ec7dfa40 00000001 ed83b820 ef599c00 
       00000293 ef599c00 c3b9c000 ed83b820 c01d05a4 ed83b820 00001055 ed83b820 
Call Trace:
 [<c01c42d3>] blk_insert_request+0x47/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c42f1>] blk_insert_request+0x65/0x78
 [<c01d3679>] scsi_queue_insert+0x71/0x7c
 [<c01d05a4>] scsi_dispatch_cmd+0x180/0x190
 [<c01d465c>] scsi_request_fn+0x1f4/0x264
 [<c01c3b83>] blk_run_queue+0x27/0x38
 [<c01d3b02>] scsi_run_queue+0xba/0xc4
 [<c01d3b9f>] scsi_next_command+0x17/0x1c
 [<c01d3c6a>] scsi_end_request+0x8e/0x9c
 [<c01d3feb>] scsi_io_completion+0x1ef/0x420
 [<c01dd061>] isplinux_intr+0x37d/0x39c
 [<c01eeebe>] sd_rw_intr+0x1da/0x1e4
 [<c01d08e1>] scsi_finish_command+0x89/0x90
 [<c01d0815>] scsi_softirq+0xc1/0xd8
 [<c011feca>] do_softirq+0x6a/0xbc
 [<c010ae66>] do_IRQ+0x106/0x118
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0105000>] _stext+0x0/0x48
 [<c0109634>] common_interrupt+0x18/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0105000>] _stext+0x0/0x48
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c0105045>] _stext+0x45/0x48
 [<c033a7af>] start_kernel+0x147/0x150

Code: f7 d2 c1 e0 02 8b 04 10 ff 40 10 eb 3c 90 83 fa 01 75 36 8b 90 c4 00 00 00 b9 00 e0 ff ff 21 e1 8b 41 10 f7 d2 c1 e0 02 8b 04 10 <01> 78 04 85 f6 75 1b 8b 43 48 8b 90 c4 00 00 00 8b 41 10 f7 d2 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000005c
 printing eip:
c01163c0
*pde = 00104001
*pte = 00000000
Oops: 0000 [#2]
SMP 
CPU:    -1070407664
EIP:    0060:[<c01163c0>]    Not tainted VLI
EFLAGS: 00010013
EIP is at do_page_fault+0x40/0x478
eax: c0330000   ebx: c011cc58   ecx: 0000007b   edx: c03300e8
esi: 00000000   edi: c0116380   ebp: c0338068   esp: c0330034
ds: 007b   es: 007b   ss: 0068
Process  (pid: -1070407560, threadinfo=c032e000 task=c032e000)
Stack: c011cc58 00000000 c0116380 c0338068 0000005c 00000000 00000000 00000000 
       00000000 00000000 00000000 c0330060 c0330060 00000000 00000000 00000000 
       00000000 00000000 00000000 00000001 00000000 00000000 00000000 00000000 
Call Trace:
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c01163c0>] do_page_fault+0x40/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478

Code: 44 24 10 f6 42 31 02 74 01 fb b8 00 e0 ff ff 21 e0 8b 30 81 7c 24 10 ff ff ff bf 76 0e f6 84 24 b0 00 00 00 05 0f 84 90 03 00 00 <8b> 5e 5c c7 44 24 30 01 00 03 00 83 78 14 00 0f 85 cb 01 00 00 
 <1>Unable to handle kernel paging request at virtual address b6968034
 printing eip:
c011961d
*pde = 00000000
int3: 0000 [#3]
SMP 
CPU:    13
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: c3bbe000   edx: 000001a0
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: c3bbff4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c3bbe000 task=f01866b0)
Stack: c0331ee8 00000034 c037f088 0000000d c3bbff78 c01140ef c3bbe000 c0106dd0 
       00128868 00000000 c3bbff80 00041000 c01096b6 c3bbe000 ed8b72f0 c3bbe000 
       c0106dd0 00128868 00041000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 <0>Kernel panic: Fatal except F<4at>axcl epet<io0>n Iin ni innteterrrrupupt t
ndSleMPr  -                                                                   ha
 nCotPU s: yn  ci -ng10
704 07664
EIP:    0060:[<c011961d>]    Not tainted VLI
EFLAGS: 00010847
EIP is at idle_cpu+0xd/0x20
eax: f6649e00   ebx: c032e010   ecx: 00001249   edx: c032e000
esi: c032e010   edi: c032e000   ebp: c032feb4   esp: c032fe74
ds: 007b   es: 007b   ss: 0068
Process  (pid: -1070407560, threadinfo=c032e000 task=c032e000)
Stack: c012ab9b c032e010 00000000 c032e010 c01186d8 c032e010 00000000 00000001 
       00000000 c032e010 0000005d 00000046 c01a1ecb c0387e60 00000096 b6968020 
       c032fef8 c0123788 00000000 00000001 c032e000 00000000 00000001 c032e010 
Call Trace:
 [<c012ab9b>] rcu_check_callbacks+0x13/0x7c
 [<c01186d8>] scheduler_tick+0x8c/0x3d0
 [<c01a1ecb>] vsnprintf+0x3eb/0x42c
 [<c0123788>] update_process_times+0x2c/0x34
 [<c01140bf>] smp_apic_timer_interrupt+0x11b/0x158
 [<c011ce38>] printk+0x94/0x184
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
Code: e5 8b 55 08 8b 42 04 69 40 10 e0 09 00 00 89 ec 5d 39 90 34 e2 31 c0 0f 94 c0 0f b6 c0 c3 55 89 e5 69 45 08 e0 09 00 00 89 ec 5d <8b> 90 34 e2 31 c0 3b 90 38 e2 31 c0 0f 94 c0 0f b6 c0 c3 55 89 
 <1>Unable to handle kernel paging request at virtual address b6968034
 pr3: ing eip:
c011961d
<1>*pde = 0000000
SMP 
CPU:    5
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: f0190000   edx: 000000a0
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: f0191f4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f0190000 task=f0193920)
Stack: c0331ee8 00000014 c037f088 00000005 f0191f78 c01140ef f0190000 c0106dd0 
       00128868 00000000 f0191f80 00041000 c01096b6 f0190000 ed9bd900 f0190000 
       c0106dd0 00128868 00041000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 Oops: 0000 [#6]
SMP 
CPU:    -1070407664
EIP:    0060:[<c011961d>]    Not tainted VLI
EFLAGS: 00010847
EIP is at idle_cpu+0xd/0x20
eax: f6649e00   ebx: c032e010   ecx: 00001249   edx: c032e000
esi: c032e010   edi: c032e000   ebp: c032fcf4   esp: c032fcb4
ds: 007b   es: 007b   ss: 0068
Process  (pid: -1070407560, threadinfo=c032e000 task=c032e000)
Stack: c012ab9b c032e010 00000000 c032e010 c01186d8 c032e010 00000000 00000001 
       00000000 c032e010 00000000 00000046 c01a1ecb c0387e60 00000082 b6968020 
       c032fd38 c0123788 00000000 00000001 c032e000 00000000 00000001 c032e010 
Call Trace:
 [<c012ab9b>] rcu_check_callbacks+0x13/0x7c
 [<c01186d8>] scheduler_tick+0x8c/0x3d0
 [<c01a1ecb>] vsnprintf+0x3eb/0x42c
 [<c0123788>] update_process_times+0x2c/0x34
 [<c01140bf>] smp_apic_timer_interrupt+0x11b/0x158
 [<c011ce38>] printk+0x94/0x184
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c0116380>] do_page_fault+0x0/0x478
 [<c011ce38>] printk+0x94/0x184
 [<c011cea3>] printk+0xff/0x184
 [<c0130ada>] __print_symbol+0x106/0x114
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011961d>] idle_cpu+0xd/0x20
 [<c012ab9b>] rcu_check_callbacks+0x13/0x7c
 [<c01186d8>] scheduler_tick+0x8c/0x3d0
 [<c01a1ecb>] vsnprintf+0x3eb/0x42c
 [<c0123788>] update_process_times+0x2c/0x34
 [<c01140bf>] smp_apic_timer_interrupt+0x11b/0x158
 [<c011ce38>] printk+0x94/0x184
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38

Code: e5 8b 55 08 8b 42 04 69 40 10 e0 09 00 00 89 ec 5d 39 90 34 e2 31 c0 0f 94 c0 0f b6 c0 c3 55 89 e5 69 45 08 e0 09 00 00 89 ec 5d <8b> 90 34 e2 31 c0 3b 90 38 e2 31 c0 0f 94 c0 0f b6 c0 c3 55 89 
 <1>Unable to handle kernel paging request at virtual address b83e91a8
 printing eip:
c0113a73
*pde = 00000000
SMP 
CPU:    14
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: c3bbc000   edx: 000001c0
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: c3bbdf4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c3bbc000 task=f0186080)
Stack: c0331ee8 00000038 c037f088 0000000e c3bbdf78 c01140ef c3bbc000 c0106dd0 
       00128868 00000000 c3bbdf80 00043000 c01096b6 c3bbc000 ef0e52d0 c3bbc000 
       c0106dd0 00128868 00043000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 int3: 0000 [#8]
SMP 
CPU:    15
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: c3bb8000   edx: 000001e0
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: c3bb9f4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c3bb8000 task=c3bbb960)
Stack: c0331ee8 0000003c c037f088 0000000f c3bb9f78 c01140ef c3bb8000 c0106dd0 
       00128868 00000000 c3bb9f80 00042000 c01096b6 c3bb8000 ed78d2d0 c3bb8000 
       c0106dd0 00128868 00042000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 int3: 0000 [#9]
SMP CPU:    12
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: f0180000   edx: 00000180
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: f0181f4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f0180000 task=f0186ce0)
Stack: c0331ee8 00000030 c037f088 0000000c f0181f78 c01140ef f0180000 c0106dd0 
       00128868 00000000 f0181f80 00044000 c01096b6 f0180000 ee16d310 f0180000 
       c0106dd0 00128868 00044000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 Oops: 0002 [#10]
SMP 
CPU:    -1070407664
EIP:    0060:[<c0113a73>]    Not tainted VLI
EFLAGS: 00010086
EIP is at stop_this_cpu+0xb/0x30
eax: c032e010   ebx: c032e000   ecx: c0113a68   edx: 00000000
esi: 00000000   edi: c032fc80   ebp: c032fcf4   esp: c032fb68
ds: 007b   es: 007b   ss: 0068
Process  (pid: -1070407560, threadinfo=c032e000 task=c032e000)
Stack: c032e000 c0113af9 00000000 ffffe000 c032fc80 c0109696 ffffe000 c032e010 
       0000085e c032fc80 c032fc80 c032fcf4 00000001 c011007b c025007b fffffffb 
       c0109cd3 00000060 00000296 00000000 c032e000 c0116678 c0252c5e c032fc80 
Call Trace:
 [<c0113af9>] smp_call_function_interrupt+0x39/0x78
 [<c0109696>] call_function_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c0116380>] do_page_fault+0x0/0x478
 [<c011ce38>] printk+0x94/0x184
 [<c011cea3>] printk+0xff/0x184
 [<c0130ada>] __print_symbol+0x106/0x114
 [<c0130a00>] __print_symbol+0x2c/0x114
 [<c0109731>] error_code+0x2d/0x38
 [<c0109731>] error_code+0x2d/0x38
 [<c0109731>] error_code+0x2d/0x38
 [<c011961d>] idle_cpu+0xd/0x20
 [<c012ab9b>] rcu_check_callbacks+0x13/0x7c
 [<c01186d8>] scheduler_tick+0x8c/0x3d0
 [<c01a1ecb>] vsnprintf+0x3eb/0x42c
 [<c0123788>] update_process_times+0x2c/0x34
 [<c01140bf>] smp_apic_timer_interrupt+0x11b/0x158
 [<c011ce38>] printk+0x94/0x184
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c0116380>] do_page_fault+0x0/0x478
 [<c011ce38>] printk+0x94/0x184
 [<c011cea3>] printk+0xff/0x184
 [<c0130ada>] __print_symbol+0x106/0x114
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011961d>] idle_cpu+0xd/0x20
 [<c012ab9b>] rcu_check_callbacks+0x13/0x7c
 [<c01186d8>] scheduler_tick+0x8c/0x3d0
 [<c01a1ecb>] vsnprintf+0x3eb/0x42c
 [<c0123788>] update_process_times+0x2c/0x34
 [<c01140bf>] smp_apic_timer_interrupt+0x11b/0x158
 [<c011ce38>] printk+0x94/0x184
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38

Code: f8 85 f6 74 0b eb 01 90 8b 44 24 14 39 d8 75 f8 c6 05 dc 4b 2e c0 01 90 31 c0 5b 5e 83 c4 14 c3 53 bb 00 e0 ff ff 21 e3 8b 43 10 <f0> 0f b3 05 a8 35 38 c0 fa e8 67 04 00 00 8b 43 10 8d 04 80 c1 
 <1>Unable to handle kernel paging request at virtual address b6968034
 printing eip:
c011961d
*pde = 00000000
int3: 0000 [#11]
SMP 
CPU:    10
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: f0184000   edx: 00000140
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: f0185f4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f0184000 task=f0187940)
Stack: c0331ee8 00000028 c037f088 0000000a f0185f78 c01140ef f0184000 c0106dd0 
       00128868 00000000 f0185f80 00043000 c01096b6 f0184000 ee7240c0 f0184000 
       c0106dd0 00128868 00043000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 int3: 0000 [#12]
SMP 
CPU:    9
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: f0188000   edx: 00000120
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: f0189f4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f0188000 task=f0192060)
Stack: c0331ee8 00000024 c037f088 00000009 f0189f78 c01140ef f0188000 c0106dd0 
       00128868 00000000 f0189f80 00041000 c01096b6 f0188000 ede466f0 f0188000 
       c0106dd0 00128868 00041000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 int3: 0000 [#13]
SMP 
CPU:    8
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: f018a000   edx: 00000100
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: f018bf4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f018a000 task=f0192690)
Stack: c0331ee8 00000020 c037f088 00000008 f018bf78 c01140ef f018a000 c0106dd0 
       00128868 00000000 f018bf80 00044000 c01096b6 f018a000 eccb0ce0 f018a000 
       c0106dd0 00128868 00044000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 Oops: 0000 [#14]
SMP 
CPU:    -1070407664
EIP:    0060:[<c011961d>]    Not tainted VLI
EFLAGS: 00010847
EIP is at idle_cpu+0xd/0x20
eax: f6649e00   ebx: c032e010   ecx: 00001249   edx: c032e000
esi: c032e010   edi: c032e000   ebp: c032f9e8   esp: c032f9a8
ds: 007b   es: 007b   ss: 0068
Process  (pid: -1070407560, threadinfo=c032e000 task=c032e000)
Stack: c012ab9b c032e010 00000000 c032e010 c01186d8 c032e010 00000000 00000001 
       00000000 c032e010 00000000 00000046 c01a1ecb c0387e60 00000082 b6968020 
       c032fa2c c0123788 00000000 00000001 c032e000 00000000 00000001 c032e010 
Call Trace:
 [<c012ab9b>] rcu_check_callbacks+0x13/0x7c
 [<c01186d8>] scheduler_tick+0x8c/0x3d0
 [<c01a1ecb>] vsnprintf+0x3eb/0x42c
 [<c0123788>] update_process_times+0x2c/0x34
 [<c01140bf>] smp_apic_timer_interrupt+0x11b/0x158
 [<c011ce38>] printk+0x94/0x184
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c01a1ecb>] vsnprintf+0x3eb/0x42c
 [<c0109731>] error_code+0x2d/0x38
 [<c0113a68>] stop_this_cpu+0x0/0x30
 [<c0113a73>] stop_this_cpu+0xb/0x30
 [<c0113af9>] smp_call_function_interrupt+0x39/0x78
 [<c0109696>] call_function_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c0116380>] do_page_fault+0x0/0x478
 [<c011ce38>] printk+0x94/0x184
 [<c011cea3>] printk+0xff/0x184
 [<c0130ada>] __print_symbol+0x106/0x114
 [<c0130a00>] __print_symbol+0x2c/0x114
 [<c0109731>] error_code+0x2d/0x38
 [<c0109731>] error_code+0x2d/0x38
 [<c0109731>] error_code+0x2d/0x38
 [<c011961d>] idle_cpu+0xd/0x20
 [<c012ab9b>] rcu_check_callbacks+0x13/0x7c
 [<c01186d8>] scheduler_tick+0x8c/0x3d0
 [<c01a1ecb>] vsnprintf+0x3eb/0x42c
 [<c0123788>] update_process_times+0x2c/0x34
 [<c01140bf>] smp_apic_timer_interrupt+0x11b/0x158
 [<c011ce38>] printk+0x94/0x184
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c0116380>] do_page_fault+0x0/0x478
 [<c011ce38>] printk+0x94/0x184
 [<c011cea3>] printk+0xff/0x184
 [<c0130ada>] __print_symbol+0x106/0x114
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38
 [<c011961d>] idle_cpu+0xd/0x20
 [<c012ab9b>] rcu_check_callbacks+0x13/0x7c
 [<c01186d8>] scheduler_tick+0x8c/0x3d0
 [<c01a1ecb>] vsnprintf+0x3eb/0x42c
 [<c0123788>] update_process_times+0x2c/0x34
 [<c01140bf>] smp_apic_timer_interrupt+0x11b/0x158
 [<c011ce38>] printk+0x94/0x184
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c011007b>] set_fpregs+0x37/0x40
 [<c0109cd3>] die+0x93/0xe8
 [<c0116678>] do_page_fault+0x2f8/0x478
 [<c011cc58>] _call_console_drivers+0x50/0x58
 [<c0116380>] do_page_fault+0x0/0x478
 [<c0109731>] error_code+0x2d/0x38

Code: e5 8b 55 08 8b 42 04 69 40 10 e0 09 00 00 89 ec 5d 39 90 34 e2 31 c0 0f 94 c0 0f b6 c0 c3 55 89 e5 69 45 08 e0 09 00 00 89 ec 5d <8b> 90 34 e2 31 c0 3b 90 38 e2 31 c0 0f 94 c0 0f b6 c0 c3 55 89 
 <1>Unable to handle kernel paging requestint3virtu at virts b6968
es<4>s b6968034
 printing eip:
c011961d
*pde = 00000000
SMP 
CPU:    4
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: f0194000   edx: 00000080
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: f0195f4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f0194000 task=f019e040)
Stack: c0331ee8 00000010 c037f088 00000004 f0195f78 c01140ef f0194000 c0106dd0 
       00128868 00000000 f0195f80 00044000 c01096b6 f0194000 ee52a0c0 f0194000 
       c0106dd0 00128868 00044000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 int3: 0000 [#16]
SMP 
CPU:    7
EIP:    0060:[<c0330002>]    Not tainted VLI
EFLAGS: 00000202
EIP is at 0xc0330002
eax: c011feca   ebx: 00000001   ecx: f018c000   edx: 000000e0
esi: c0331ee8   edi: 0000000a   ebp: 00000046   esp: f018df4c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f018c000 task=f0192cc0)
Stack: c0331ee8 0000001c c037f088 00000007 f018df78 c01140ef f018c000 c0106dd0 
       00128868 00000000 f018df80 00042000 c01096b6 f018c000 ed4f0cc0 f018c000 
       c0106dd0 00128868 00042000 00000000 0000007b c02e007b ffffffef c0106dfc 
Call Trace:
 [<c01140ef>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0106dd0>] default_idle+0x0/0x34
 [<c01096b6>] apic_timer_interrupt+0x1a/0x20
 [<c0106dd0>] default_idle+0x0/0x34
 [<c0106dfc>] default_idle+0x2c/0x34
 [<c0106e83>] cpu_idle+0x37/0x48
 [<c034089a>] start_secondary+0x6e/0x70
 [<c011cf10>] printk+0x16c/0x184
 [<c033db43>] print_cpu_info+0xa3/0xbc
 [<c0340ac3>] do_boot_cpu+0x14f/0x1b0

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 97 10 c0 00 00 33 c0 00 00 00 00 58 cc <11> c0 7b 00 00 00 e8 00 33 c0 00 00 00 00 80 63 11 c0 68 80 33 
 




