Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422948AbWAMUr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422948AbWAMUr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWAMUr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:47:56 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:52176 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1422944AbWAMUr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:47:56 -0500
Date: Fri, 13 Jan 2006 21:47:54 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: reiserfs crashes on write errors
Message-ID: <Pine.LNX.4.62.0601132145480.13312@artax.karlin.mff.cuni.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

after having multiple write errors on disk (scsi array died), kernel hit 
these BUG messages. Kernel is 2.6.14-gentoo-r5 #1 SMP PREEMPT

Mikulas

sd 0:0:11:0: SCSI error: return code = 0xd0000
end_request: I/O error, dev sda, sector 343639
scsi0 (11:0): rejecting I/O to offline device
scsi0 (11:0): rejecting I/O to offline device
scsi0 (11:0): rejecting I/O to offline device
REISERFS: abort (device sda1): Journal write error in flush_commit_list
REISERFS: Aborting journal for filesystem on sda1
------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:666!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c01c2dad>]    Not tainted VLI
EFLAGS: 00010246   (2.6.14-gentoo-r5)
EIP is at submit_ordered_buffer+0x1d/0x40
eax: 0000002c   ebx: 00000001   ecx: ce9ea260   edx: cff36414
esi: dfd87dec   edi: dfd87de4   ebp: fffffffb   esp: dfd87db8
ds: 007b   es: 007b   ss: 0068
Process reiserfs/0 (pid: 907, threadinfo=dfd86000 task=dfcd7530)
Stack: cb122990 dfd87de4 c01c2f0c cff36414 cb122990 e0d8e0ec c01c3328 
dfd87dec
        cff36414 e0d8e0ec c01c2ec0 d11248e8 d11248e8 cff36414 c7cff030 
c1406564
        000017f7 c05c35c0 00000000 c7cff030 00000082 c011716a c7cff030 
c1406520
Call Trace:
  [<c01c2f0c>] write_ordered_chunk+0x4c/0x60
  [<c01c3328>] write_ordered_buffers+0x148/0x200
  [<c01c2ec0>] write_ordered_chunk+0x0/0x60
  [<c011716a>] try_to_wake_up+0x2da/0x340
  [<c0470887>] .text.lock.kernel_lock+0xb/0x37
  [<c046e980>] schedule+0x6b0/0xd50
  [<c0118ca1>] __wake_up_common+0x41/0x70
  [<c01c39ac>] flush_commit_list+0x46c/0x4e0
  [<c0470080>] __down+0xd0/0xe0
  [<c01c3472>] flush_older_commits+0x92/0xd0
  [<c01c39d2>] flush_commit_list+0x492/0x4e0
  [<c01c75d0>] flush_async_commits+0x90/0xa0
  [<c012e4d9>] worker_thread+0x1b9/0x260
  [<c01c7540>] flush_async_commits+0x0/0xa0
  [<c0118c40>] default_wake_function+0x0/0x20
  [<c0118c40>] default_wake_function+0x0/0x20
  [<c046f06a>] preempt_schedule+0x4a/0x70
  [<c012e320>] worker_thread+0x0/0x260
  [<c01329ba>] kthread+0xba/0xc0
  [<c0132900>] kthread+0x0/0xc0
  [<c0101275>] kernel_thread_helper+0x5/0x10
Code: 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 83 ec 08 8b 54 24 0c f0 ff 
42 0c c7 42 24 00 2d 1c c0 f0 0f ba 32 01 8b 02 a8 01 75 08 <0f> 0b 9a 02 
8c 2f 49 c0 89 54 24 04 c7 04 24 01 00 00 00 e8 2b
  Badness in do_exit at kernel/exit.c:799
  [<c0120364>] do_exit+0x364/0x370
  [<c01043b8>] die+0x188/0x190
  [<c0104670>] do_invalid_op+0x0/0xd0
  [<c0104722>] do_invalid_op+0xb2/0xd0
  [<c01c2dad>] submit_ordered_buffer+0x1d/0x40
  [<c0148c9f>] kmem_freepages+0x8f/0xb0
  [<c0148d78>] slab_destroy+0x68/0xb0
  [<c027c9e0>] memmove+0x50/0x54
  [<c0103c5b>] error_code+0x4f/0x54
  [<c01c2dad>] submit_ordered_buffer+0x1d/0x40
  [<c01c2f0c>] write_ordered_chunk+0x4c/0x60
  [<c01c3328>] write_ordered_buffers+0x148/0x200
  [<c01c2ec0>] write_ordered_chunk+0x0/0x60
  [<c011716a>] try_to_wake_up+0x2da/0x340
  [<c0470887>] .text.lock.kernel_lock+0xb/0x37
  [<c046e980>] schedule+0x6b0/0xd50
  [<c0118ca1>] __wake_up_common+0x41/0x70
  [<c01c39ac>] flush_commit_list+0x46c/0x4e0
  [<c0470080>] __down+0xd0/0xe0
  [<c01c3472>] flush_older_commits+0x92/0xd0
  [<c01c39d2>] flush_commit_list+0x492/0x4e0
  [<c01c75d0>] flush_async_commits+0x90/0xa0
  [<c012e4d9>] worker_thread+0x1b9/0x260
  [<c01c7540>] flush_async_commits+0x0/0xa0
  [<c0118c40>] default_wake_function+0x0/0x20
  [<c0118c40>] default_wake_function+0x0/0x20
  [<c046f06a>] preempt_schedule+0x4a/0x70
  [<c012e320>] worker_thread+0x0/0x260
  [<c01329ba>] kthread+0xba/0xc0
  [<c0132900>] kthread+0x0/0xc0
  [<c0101275>] kernel_thread_helper+0x5/0x10
scsi0 (11:0): rejecting I/O to offline device
scsi0 (11:0): rejecting I/O to offline device

