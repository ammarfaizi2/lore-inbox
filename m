Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbTEVTHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTEVTHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:07:39 -0400
Received: from franka.aracnet.com ([216.99.193.44]:24483 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263132AbTEVTHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:07:36 -0400
Date: Thu, 22 May 2003 12:20:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 738] New: kernel BUG at fs/jbd/transaction.c:2023!
Message-ID: <6780000.1053631230@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: kernel BUG at fs/jbd/transaction.c:2023!
    Kernel Version: 2.5.69-mm8
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: plars@austin.ibm.com


Distribution: RH 7.3

Hardware Environment: 8-way PIII-700, 16 GB ram

Software Environment:
anticipatory scheduler, ext3, preempt enabled

Problem Description:
Here's the first BUG output, the full log is attached in case you care about the
stream of sleeping function called from illegal context errors that followed.
Assertion failure in __journal_refile_buffer() at fs/jbd/transaction.c:2023:
"(get_current()->lock_depth >= 0)"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:2023!
invalid operand: 0000 [#1]
CPU:    2
EIP:    0060:[<c01a9e09>]    Not tainted VLI
EFLAGS: 00010202
EIP is at __journal_refile_buffer+0x69/0x100
eax: 00000073   ebx: eb787e08   ecx: c05345a0   edx: 00000001
esi: ffffffff   edi: f7c2b6e8   ebp: f565e8c8   esp: eaf7da20
ds: 007b   es: 007b   ss: 0068
Process ftest07 (pid: 18246, threadinfo=eaf7c000 task=f5e1e040)
Stack: c0415ca0 c040f7d3 c040f51a 000007e7 c0418440 f7c2b79c eb787e08 f7c2b6e8
       c01a8c60 eb787e08 00008000 ffffffff 00000000 f49b519c c0198202 f013c1cc
       f49b519c 00000001 c0160744 f7c5d6dc 00188003 00001000 00000030 00000031
Call Trace:
 [<c01a8c60>] journal_release_buffer+0x90/0x100
 [<c0198202>] ext3_try_to_allocate+0x172/0x190
 [<c0160744>] __bread+0x14/0x30
 [<c019848d>] ext3_new_block+0x26d/0x610
 [<c019d5e7>] ext3_do_update_inode+0x2e7/0x370
 [<c019a9cd>] ext3_alloc_block+0x1d/0x30
 [<c019ad45>] ext3_alloc_branch+0x45/0x280
 [<c01605fa>] bh_lru_install+0xca/0xf0
 [<c019b31f>] ext3_get_block_handle+0x20f/0x2f0
 [<c0162b43>] alloc_buffer_head+0x13/0x60
 [<c015ff87>] create_buffers+0x57/0xb0
 [<c019b460>] ext3_get_block+0x60/0x70
 [<c0161070>] __block_prepare_write+0x140/0x3e0
 [<c010829c>] __up_wakeup+0x8/0xc
 [<c0161bf0>] block_prepare_write+0x20/0x40
 [<c019b400>] ext3_get_block+0x0/0x70
 [<c019b882>] ext3_prepare_write+0x42/0xe0
 [<c019b400>] ext3_get_block+0x0/0x70
 [<c013e12e>] generic_file_aio_write_nolock+0x66e/0xac0
 [<c013bb9a>] unlock_page+0xa/0x50
 [<c013c994>] file_read_actor+0x64/0xd0
 [<c013c9a1>] file_read_actor+0x71/0xd0
 [<c013c535>] do_generic_mapping_read+0xf5/0x4f0
 [<c0179a2d>] update_atime+0x6d/0xc0
 [<c013cbb5>] __generic_file_aio_read+0x1b5/0x1e0
 [<c013e619>] generic_file_write_nolock+0x99/0xc0
 [<c011f7c0>] autoremove_wake_function+0x0/0x40
 [<c011f7c0>] autoremove_wake_function+0x0/0x40
 [<c02fa058>] scsi_init_io+0xa8/0x110
 [<c011f7c0>] autoremove_wake_function+0x0/0x40
 [<c02c6b98>] as_next_request+0x18/0x30
 [<c0142b89>] check_poison_obj+0x39/0x190
 [<c0144a5a>] kmalloc+0xfa/0x1c0
 [<c013e850>] generic_file_writev+0x40/0x60
 [<c015dc30>] do_readv_writev+0x1c0/0x270
 [<c015d6d0>] do_sync_write+0x0/0xe0
 [<c015d07d>] generic_file_llseek+0x2d/0xd0
 [<c015d050>] generic_file_llseek+0x0/0xd0
 [<c015dd77>] vfs_writev+0x47/0x50
 [<c015ddff>] sys_writev+0x2f/0x50
 [<c01094df>] syscall_call+0x7/0xb

Code: ff ff 21 e0 8b 00 8b 70 14 85 f6 79 29 68 40 84 41 c0 68 e7 07 00 00 68 1a
f5 40 c0 68 d3 f7 40 c0 68 a0 5c 41 c0 e8 27 85 f7 ff <0f> 0b e7 07 1a f5 40 c0
83 c4 14 8b 4b 18 85 c9 75 15 53 e8 2f

Steps to reproduce:
I was actually trying to reproduce an error I caught the tail end of earlier
when I was trying to compile LTP.  This doesn't look like the same error, and I
couldn't get a kernel compile or an LTP compile to cause an error for me again.

What I was doing when I got this error was running ltp (current cvs copy),
runalltests -q |tee /tmp/ltp.out
### ftest07 was the test currently running when it crashed

At the same time, I was also running variations on the aio01 test in ltp (not
currently part of runalltests)
aio01 -n100000
aio01 -c10 -n10000
### at this point nothing came back, so I'm uncertain as to whether it hung
before this test or hung as I executed it.

I went back and tried running all of these tests alone and had no failure. So it
could be somewhat random.  I have not tested 2.5.69-mm7 or vanilla 2.5.69 in
this fashion but my regular runs of 2.5.69 vanilla did not expose this.  If
there isn't enough to go on here though, let me know and I'll be happy to try it
on mm7 or 2.5.69, or do patch bisection if I can get a reliable way to recreate
the problem.


