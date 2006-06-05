Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750811AbWFEQqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWFEQqK (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWFEQqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:46:09 -0400
Received: from dvhart.com ([64.146.134.43]:53909 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750842AbWFEQqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:46:08 -0400
Message-ID: <44845FCE.2070106@mbligh.org>
Date: Mon, 05 Jun 2006 09:46:06 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: panic on 2.6.17-rc5-mm1, -mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: unable to handle kernel NULL pointer dereference at virtual address 
000004c4
  printing eip:
c012b6b4
*pde = 14f90001
*pte = 00000000
Oops: 0000 [#1]
SMP
last sysfs file: /class/vc/vcs1/dev
CPU:    1
EIP:    0060:[<c012b6b4>]    Not tainted VLI
EFLAGS: 00010046   (2.6.17-rc5-mm2-autokern1 #1)
EIP is at check_deadlock+0x26/0xe0
eax: 00000000   ebx: 00000001   ecx: d5ffb3a4   edx: 00000001
esi: 00000000   edi: d3b32f14   ebp: 00000000   esp: d2f07ef0
ds: 007b   es: 007b   ss: 0068
Process mkdir09 (pid: 18867, threadinfo=d2f07000 task=d6833550)
Stack: 00000000 d5cb7aa0 d3608e28 d3b32f14 c012b733 d3608e28 d2f07000 
d2f07f28
        d6833550 c012b8da fffffff0 d3608e28 00000246 c02d5136 d2f07f28 
d2f07f28
        11111111 11111111 d2f07f28 d6848000 ffffff9c ffffff9c fffffff0 
d2f07f5c
Call Trace:
  <c012b733> check_deadlock+0xa5/0xe0  <c012b8da> 
debug_mutex_add_waiter+0x46/0x55
  <c02d5136> __mutex_lock_slowpath+0x9e/0x1c0  <c016062b> do_rmdir+0x64/0xb6
  <c0160494> sys_mkdir+0xf/0x13  <c02d626f> syscall_call+0x7/0xb
  <c02d007b> unix_stream_connect+0x1db/0x38e
Code: 5b 5e 5f 5d c3 55 83 3d 8c 21 34 c0 00 57 89 c7 56 53 89 d3 0f 84 
c4 00 00 00 8b 48 10 31 c0 85 c9 0f 84 b9 00 00 00 8b 31 31 ed <8b> 86 
c4 04 00 00 85 c0 74 03 8b 68 0c b8 00 f0 ff ff 21 e0 39
EIP: [<c012b6b4>] check_deadlock+0x26/0xe0 SS:ESP 0068:d2f07ef0
  <3>BUG: soft lockup detected on CPU#17!
  <c0130af9> softlockup_tick+0x9a/0xa8  <c01203f2> 
update_process_times+0x39/0x5c
  <c010a059> do_flush_tlb_all+0x0/0x5a  <c010b74f> 
smp_apic_timer_interrupt+0x54/0x5a
  <c01029f3> apic_timer_interrupt+0x1f/0x24  <c010a059> 
do_flush_tlb_all+0x0/0x5a
  <c010a1ad> smp_call_function+0xbf/0xee  <c010a059> 
do_flush_tlb_all+0x0/0x5a
  <c010a059> do_flush_tlb_all+0x0/0x5a  <c011c8e0> on_each_cpu+0x10/0x1f
  <c010a0c6> flush_tlb_all+0x13/0x15  <c013d719> kmap_high+0x51/0x1aa
  <c013567c> mempool_alloc_pages+0x10/0x11  <c0135536> 
mempool_alloc+0x1e/0xbd
  <c01572e2> bio_alloc_bioset+0xad/0x10a  <c013dbb4> 
__blk_queue_bounce+0xe6/0x210
  <c01b3f78> __make_request+0x54/0x345  <c01b4405> 
generic_make_request+0x13b/0x16b
  <c0135536> mempool_alloc+0x1e/0xbd  <c01b44d1> submit_bio+0x9c/0xa4
  <c01572e2> bio_alloc_bioset+0xad/0x10a  <c0156d9f> submit_bh+0xcb/0xe5
  <c0155838> __block_write_full_page+0x1c8/0x2ae  <c0189bad> 
ext3_get_block+0x0/0xb0
  <c0156c56> block_write_full_page+0xc7/0xd0  <c0189bad> 
ext3_get_block+0x0/0xb0
  <c018a4cd> ext3_ordered_writepage+0xce/0x13a  <c018a3df> bget_one+0x0/0x7
  <c0170f76> mpage_writepages+0x19d/0x30b  <c018a3ff> 
ext3_ordered_writepage+0x0/0x13a
  <c0137fea> do_writepages+0x2d/0x34  <c01324b3> 
__filemap_fdatawrite_range+0x7a/0x82
  <c0154c9d> __set_page_dirty_buffers+0x98/0xa2  <c0144ac1> 
msync_page_range+0xd6/0x110
  <c01324cd> filemap_fdatawrite+0x12/0x16  <c01546d3> do_fsync+0x40/0x8b
  <c0144d0c> sys_msync+0x1dc/0x251  <c02d626f> syscall_call+0x7/0xb
BUG: soft lockup detected on CPU#0!
  <c0130af9> softlockup_tick+0x9a/0xa8  <c01203f2> 
update_process_times+0x39/0x5c
  <c010b74f> smp_apic_timer_interrupt+0x54/0x5a  <c01029f3> 
apic_timer_interrupt+0x1f/0x24
  <c013007b> pm_sysrq_init+0xc/0x15  <c02d5ffa> _spin_lock+0x7/0xf
  <c013d6ea> kmap_high+0x22/0x1aa  <c014a465> 
alloc_page_interleave+0x34/0x64
  <c013567c> mempool_alloc_pages+0x10/0x11  <c0135536> 
mempool_alloc+0x1e/0xbd
  <c01572e2> bio_alloc_bioset+0xad/0x10a  <c013dbb4> 
__blk_queue_bounce+0xe6/0x210
  <c01b3f78> __make_request+0x54/0x345  <c01b4405> 
generic_make_request+0x13b/0x16b
  <c0135536> mempool_alloc+0x1e/0xbd  <c012889e> wake_bit_function+0x0/0x3c
  <c01b44d1> submit_bio+0x9c/0xa4  <c01572e2> bio_alloc_bioset+0xad/0x10a
  <c0156d9f> submit_bh+0xcb/0xe5  <c0156e36> ll_rw_block+0x7d/0x91
  <c0198273> journal_commit_transaction+0x3da/0xd97  <c02d459a> 
schedule+0x556/0x61b
  <c011f5c3> lock_timer_base+0x15/0x2f  <c011f75f> 
try_to_del_timer_sync+0x42/0x48
  <c019a6d4> kjournald+0x9b/0x1e2  <c0128871> 
autoremove_wake_function+0x0/0x2d
  <c0128871> autoremove_wake_function+0x0/0x2d  <c019a639> 
kjournald+0x0/0x1e2
  <c01284e5> kthread+0x73/0x9b  <c0128472> kthread+0x0/0x9b
  <c01009d5> kernel_thread_helper+0x5/0xb
