Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTB0UYu>; Thu, 27 Feb 2003 15:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbTB0UYu>; Thu, 27 Feb 2003 15:24:50 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:5770 "EHLO
	dyn9-47-17-83.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id <S266965AbTB0UYq>; Thu, 27 Feb 2003 15:24:46 -0500
Message-ID: <3E5E70E0.36937042@us.ibm.com>
Date: Thu, 27 Feb 2003 12:11:12 -0800
From: Janet Morgan <janetmor@us.ibm.com>
Reply-To: janetmor@us.ibm.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.63 BUG in deadline-iosched.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this on 2.5.63 while running the "find" command:

kernel BUG at drivers/block/deadline-iosched.c:145!
invalid operand: 0000
CPU:    3
EIP:    0060:[<c026f8a1>]    Not tainted
EFLAGS: 00010046
EIP is at deadline_find_drq_hash+0x41/0xb0
eax: f76fe060   ebx: f76fe058   ecx: f76fe060   edx: 00000000
esi: f76fe060   edi: f76fe044   ebp: f76fe050   esp: f7e27c88
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 16, threadinfo=f7e26000 task=c3b39300)
Stack: 010d7ce6 00000000 f7fd2ae0 f7fd2ae0 f7fd2ae0 f7747f80 c026fbc9
f7747f80
       010d7ce6 00000000 f7747f80 00000000 f7759000 f7759000 00000008
c026a438
       f7759000 f7e27cf8 f7fd2ae0 c026cc58 f7759000 f7e27cf8 f7fd2ae0
010d7ce6
Call Trace:
 [<c026fbc9>] deadline_merge+0x49/0x120
 [<c026a438>] elv_merge+0x18/0x30
 [<c026cc58>] __make_request+0xb8/0x440
 [<c014dd96>] bio_alloc+0x126/0x1b0
 [<c026d1ad>] generic_make_request+0x1cd/0x1e0
 [<c026d239>] submit_bio+0x79/0x90
 [<c014bd34>] __block_write_full_page+0x284/0x400
 [<c014d342>] block_write_full_page+0x32/0xc0
 [<c014f990>] blkdev_get_block+0x0/0x60
 [<c017d55c>] ext3_writepage+0x25c/0x300
 [<c014fae4>] blkdev_writepage+0x14/0x20
 [<c014f990>] blkdev_get_block+0x0/0x60
 [<c0166dd0>] mpage_writepages+0x1c0/0x2ab
 [<c014fad0>] blkdev_writepage+0x0/0x20
 [<c011ec8b>] do_softirq+0x5b/0xc0
 [<c0150c11>] generic_writepages+0x11/0x15
 [<c0134e46>] do_writepages+0x16/0x30
 [<c0165548>] __sync_single_inode+0xc8/0x210
 [<c01658aa>] sync_sb_inodes+0x16a/0x210
 [<c01659a4>] writeback_inodes+0x54/0x90
 [<c0134d05>] wb_kupdate+0xa5/0x100
 [<c013537f>] __pdflush+0xff/0x1a0
 [<c0135420>] pdflush+0x0/0x10
 [<c013542b>] pdflush+0xb/0x10
 [<c0134c60>] wb_kupdate+0x0/0x100
 [<c0106fe0>] kernel_thread_helper+0x0/0x10
 [<c0106fe5>] kernel_thread_helper+0x5/0x10

Code: 0f 0b 91 00 a0 f8 3c c0 8b 43 08 83 e0 7c 83 f8 10 75 09 8b

