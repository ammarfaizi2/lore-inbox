Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTFKCC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263964AbTFKCC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:02:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14806 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263953AbTFKCCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:02:24 -0400
Message-ID: <3EE690AC.70500@us.ibm.com>
Date: Tue, 10 Jun 2003 19:15:08 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, pbadari@us.ibm.com
Subject: Re: 2.5.70-mm6
References: <20030607151440.6982d8c6.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm6/
> 

I run 50 fsx tests on ext3 filesystem on 2.5.70-mm6 kernel. Serveral fsx 
tests hang with the status D, after the tests run for a while.  No oops, 
no error messages.  I found same problem on mm5, but 2.5.70 is fine.

Here is the stack info:

fsx           D C3496298   932      1           933   852 (NOTLB)
Call Trace:
  [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
  [<c011c546>] io_schedule+0x26/0x30
  [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
  [<c014712b>] vmtruncate+0x6b/0x100
  [<c0171e94>] inode_setattr+0x134/0x150
  [<c0195aca>] ext3_setattr+0x7a/0x1a0
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c0172080>] notify_change+0x160/0x19d
  [<c0153f3a>] do_truncate+0x6a/0x90
  [<c0161037>] sys_fstat64+0x37/0x40
  [<c0154228>] sys_ftruncate+0x118/0x1b0
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0155c29>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb

fsx           D C0109E2E   933      1           934   932 (NOTLB)
Call Trace:
  [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
  [<c02b04f3>] generic_unplug_device+0x23/0x70
  [<c011c546>] io_schedule+0x26/0x30
  [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
  [<c014712b>] vmtruncate+0x6b/0x100
  [<c0171e94>] inode_setattr+0x134/0x150
  [<c0195aca>] ext3_setattr+0x7a/0x1a0
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c0172080>] notify_change+0x160/0x19d
  [<c0153f3a>] do_truncate+0x6a/0x90
  [<c0161037>] sys_fstat64+0x37/0x40
  [<c0154228>] sys_ftruncate+0x118/0x1b0
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0155c29>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb

fsx           D F6A43DA8   934      1           935   933 (NOTLB)
Call Trace:
  [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
  [<c011c546>] io_schedule+0x26/0x30
  [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
  [<c014712b>] vmtruncate+0x6b/0x100
  [<c0171e94>] inode_setattr+0x134/0x150
  [<c0195aca>] ext3_setattr+0x7a/0x1a0
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c0172080>] notify_change+0x160/0x19d
  [<c0153f3a>] do_truncate+0x6a/0x90
  [<c0161037>] sys_fstat64+0x37/0x40
  [<c0154228>] sys_ftruncate+0x118/0x1b0
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0155c29>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb

fsx           D F7B55A00   935      1           936   934 (NOTLB)
Call Trace:
  [<c02aea96>] elv_next_request+0x16/0x100
  [<c02b052a>] generic_unplug_device+0x5a/0x70
  [<c011c546>] io_schedule+0x26/0x30
  [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
  [<c014712b>] vmtruncate+0x6b/0x100
  [<c0171e94>] inode_setattr+0x134/0x150
  [<c0195aca>] ext3_setattr+0x7a/0x1a0
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c0172080>] notify_change+0x160/0x19d
  [<c0153f3a>] do_truncate+0x6a/0x90
  [<c0161037>] sys_fstat64+0x37/0x40
  [<c0154228>] sys_ftruncate+0x118/0x1b0
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0155c29>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb

fsx           D F6A1E000   936      1           937   935 (NOTLB)
Call Trace:
  [<c011bcc0>] schedule+0x280/0x4f0
  [<c011c546>] io_schedule+0x26/0x30
  [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
  [<c014712b>] vmtruncate+0x6b/0x100
  [<c0171e94>] inode_setattr+0x134/0x150
  [<c0195aca>] ext3_setattr+0x7a/0x1a0
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c0172080>] notify_change+0x160/0x19d
  [<c0153f3a>] do_truncate+0x6a/0x90
  [<c0161037>] sys_fstat64+0x37/0x40
  [<c0154228>] sys_ftruncate+0x118/0x1b0
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0155c29>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb

fsx           D F6A1DDA8   937      1           938   936 (NOTLB)
Call Trace:
  [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
  [<c011c546>] io_schedule+0x26/0x30
  [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
  [<c014712b>] vmtruncate+0x6b/0x100
  [<c0171e94>] inode_setattr+0x134/0x150
  [<c0195aca>] ext3_setattr+0x7a/0x1a0
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c0172080>] notify_change+0x160/0x19d
  [<c0153f3a>] do_truncate+0x6a/0x90
  [<c0161037>] sys_fstat64+0x37/0x40
  [<c0154228>] sys_ftruncate+0x118/0x1b0
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0155c29>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   938      1           939   937 (NOTLB)
Call Trace:
  [<c011c546>] io_schedule+0x26/0x30
  [<c0157565>] __wait_on_buffer_wq+0xf5/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0157587>] __wait_on_buffer+0x17/0x20
  [<c01a3018>] journal_invalidatepage+0x88/0x130
  [<c0193e93>] ext3_invalidatepage+0x43/0x50
  [<c01423e7>] do_invalidatepage+0x27/0x30
  [<c014247e>] truncate_complete_page+0x8e/0x90
  [<c0142604>] truncate_inode_pages+0xd4/0x2f0
  [<c014712b>] vmtruncate+0x6b/0x100
  [<c0171e94>] inode_setattr+0x134/0x150
  [<c0195aca>] ext3_setattr+0x7a/0x1a0
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c0172080>] notify_change+0x160/0x19d
  [<c0153f3a>] do_truncate+0x6a/0x90
  [<c0161037>] sys_fstat64+0x37/0x40
  [<c0154228>] sys_ftruncate+0x118/0x1b0
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0155c29>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb

fsx           D C0109E2E   939      1           940   938 (NOTLB)
Call Trace:
  [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
  [<c011c546>] io_schedule+0x26/0x30
  [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
  [<c014712b>] vmtruncate+0x6b/0x100
  [<c0171e94>] inode_setattr+0x134/0x150
  [<c0195aca>] ext3_setattr+0x7a/0x1a0
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c0172080>] notify_change+0x160/0x19d
  [<c0153f3a>] do_truncate+0x6a/0x90
  [<c0161037>] sys_fstat64+0x37/0x40
  [<c0154228>] sys_ftruncate+0x118/0x1b0
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0155c29>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   940      1           941   939 (NOTLB)
Call Trace:
  [<c011c546>] io_schedule+0x26/0x30
  [<c0157565>] __wait_on_buffer_wq+0xf5/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0157587>] __wait_on_buffer+0x17/0x20
  [<c01a3018>] journal_invalidatepage+0x88/0x130
  [<c0193e93>] ext3_invalidatepage+0x43/0x50
  [<c01423e7>] do_invalidatepage+0x27/0x30
  [<c014247e>] truncate_complete_page+0x8e/0x90
  [<c0142604>] truncate_inode_pages+0xd4/0x2f0
  [<c014712b>] vmtruncate+0x6b/0x100
  [<c0171e94>] inode_setattr+0x134/0x150
  [<c0195aca>] ext3_setattr+0x7a/0x1a0
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c0172080>] notify_change+0x160/0x19d
  [<c0153f3a>] do_truncate+0x6a/0x90
  [<c0161037>] sys_fstat64+0x37/0x40
  [<c0154228>] sys_ftruncate+0x118/0x1b0
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0155c29>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   941      1                 940 (NOTLB)
Call Trace:
  [<c011c546>] io_schedule+0x26/0x30
  [<c0157565>] __wait_on_buffer_wq+0xf5/0x100
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c015af00>] submit_bh+0x90/0x1e0
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c02b1cc4>] submit_bio+0x54/0xa0
  [<c0158acd>] __bread_slow_wq+0xad/0xf0
  [<c0158db6>] __bread+0x46/0x50
  [<c018eb98>] read_block_bitmap+0x58/0xa0
  [<c018f902>] ext3_new_block+0x1a2/0x590
  [<c0158c73>] __find_get_block+0x73/0x100
  [<c01922f7>] ext3_alloc_block+0x37/0x40
  [<c01926ba>] ext3_alloc_branch+0x4a/0x2c0
  [<c01924c2>] ext3_get_branch+0x72/0x100
  [<c0192cbc>] ext3_get_block_handle+0x18c/0x360
  [<c015b501>] alloc_buffer_head+0x41/0x50
  [<c0192ef4>] ext3_get_block+0x64/0xb0
  [<c0159827>] __block_prepare_write+0x227/0x4b0
  [<c015a364>] block_prepare_write+0x34/0x50
  [<c0192e90>] ext3_get_block+0x0/0xb0
  [<c01934d1>] ext3_prepare_write+0x71/0x130
  [<c0192e90>] ext3_get_block+0x0/0xb0
  [<c013a5cd>] generic_file_aio_write_nolock+0x38d/0xa50
  [<c0195808>] ext3_do_update_inode+0x1c8/0x3d0
  [<c0158d97>] __bread+0x27/0x50
  [<c01951f3>] ext3_get_inode_loc+0x103/0x1a0
  [<c013adee>] generic_file_aio_write+0x9e/0x120
  [<c0190bf4>] ext3_file_write+0x44/0xe0
  [<c0156046>] do_sync_write+0xb6/0xf0
  [<c0177a56>] __mark_inode_dirty+0xf6/0x100
  [<c0160f6e>] cp_new_stat64+0xfe/0x110
  [<c011ddf0>] autoremove_wake_function+0x0/0x50
  [<c0127cb6>] update_wall_time+0x16/0x40
  [<c01280f0>] do_timer+0xc0/0xd0
  [<c015613e>] vfs_write+0xbe/0x130
  [<c01558f0>] generic_file_llseek+0x0/0xf0
  [<c0156262>] sys_write+0x42/0x70
  [<c010943f>] syscall_call+0x7/0xb


