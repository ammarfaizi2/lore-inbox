Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271405AbTGXJAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 05:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271408AbTGXJAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 05:00:20 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:21768 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S271405AbTGXJAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 05:00:13 -0400
Subject: 2.6.0-test1-mm2 ext3-related OOPS while running tar
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.com, kernel@kolivas.org
Content-Type: multipart/mixed; boundary="=-F3oWIxhzwTN4vnkFd8of"
Message-Id: <1059038117.577.23.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 24 Jul 2003 11:15:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F3oWIxhzwTN4vnkFd8of
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

I've got the attached oops on 2.6.0-test1-mm2 + o8int.patch when
untarring the kernel sources for 2.6.0-test1 on an ext3 filesystem
using:

tar jxvf /path/to/linux-2.6.0-test1.tar.bz2

I've CCed Con Kolivas and Andrew Morton as I've seen a do_divide_error
which could be related with scheduler improvements.

--=-F3oWIxhzwTN4vnkFd8of
Content-Disposition: attachment; filename=oops
Content-Type: text/plain; name=oops; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Unable to handle kernel NULL pointer deference at virtual address 00000014
 printing eip:
c018e1b7
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c018e1b7>]    Not tainted VLI
EFLAGS: 00010202
EIP is at journal_dirty_metadata+0x49/0x243
eax: d75e6000   ebx: 00000000   ecx: 00000000   edx: d79ca480
esi: d724eb00   edi: d671c424   ebp: d79ca480   esp: d75e7e74
ds: 007b   es: 007b   ss: 0068
Process tar (pid: 2583, threadinfo=d75e6000 task=d6c39940)
Stack: 000d3f82 dfde6880 d6655a10 c014bda6 c014a6b5 dfdb5980 d79ca480 d67fc424
       00000001 d6655a10 c017f045 d67fc424 d79ca480 00001000 d75e7ebc 00000001
       00000001 00000000 00000030 00000001 00000001 00000cdd 000d3f82 dfde4420
Call Trace:
 [<c014bda6>] __getblk+0x2b/0x51
 [<c014a6b5>] wake_up_buffer+0xf/0x26
 [<c017f045>] ext3_getblk+0xdb/0x284
 [<c017f221>] ext3_bread+0x33/0xb6
 [<c0184cc4>] ext3_mkdir+0xd1/0x2c6
 [<c0184bf3>] ext3_mkdir+0x0/0x2c6
 [<c0158350>] vfs_mkdir+0x6a/0xbc
 [<c0158459>] sys_mkdir+0xb7/0xf6
 [<c0108f11>] sysenter_past_esp+0x52/0x71

Code: 8b 5d 24 0f 8f e3 01 00 00 f6 47 18 04 0f 85 e0 00 00 00 8b 07 8b 00 f6 00
 02 0f 85 d3 00 00 00 b8 00 e0 ff ff 21 e0 83 40 14 01 <8b> 43 14 3b 07 0f 84 66
 00 00 00 b8 00 e0 ff ff 21 e0 83 40 14
 <6>note: tar[2583] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011583f>] schedule+0x3f7/0x3fc
 [<c013aeb8>] unmag_page_range+0x43/x069
 [<c013b08f>] unmap_vmas+0x1b1/0x209
 [<c013eba0>] exit_mmap+0x7c/0x190
 [<c01171ec>] mmput+0x7b/0xe4
 [<c011acdb>] do_exit+0x11d/0x3f2
 [<c0113dec>] do_page_fault+0x0/0x456
 [<c010977f>] do_divide_error+0x0/0xfa
 [<c0113f18>] do_page_fault+0x12c/0x456
 [<c0181dc3>] ext3_mark_inode_dirty+0x4f/0x51
 [<c017e99b>] ext3_splice_branch+0x161/0x29c
 [<c017dcda>] ext3_get_block_handle+0x2f4/0x355
 [<c0113dec>] do_page_fault+0x0/0x456
 [<c010910d>] journal_dirty_metadata+0x49/0x243
 [<c014bda6>] __getblk+0x2b/0x51
 [<c014bda6>] __getblk+0x2b/0x51
 [<c014a6b5>] wake_up_buffer+0xf/0x26
 [<c017f045>] ext3_getblk+0xdb/0x284
 [<c017f221>] ext3_bread+0x33/0xb6
 [<c0184cc4>] ext3_mkdir+0xd1/0x2c6
 [<c0184bf3>] ext3_mkdir+0x0/0x2c6
 [<c0158350>] vfs_mkdir+0x6a/0xbc
 [<c0158459>] sys_mkdir+0xb7/0xf6
 [<c0108f11>] sysenter_past_esp+0x52/0x71

--=-F3oWIxhzwTN4vnkFd8of--

