Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbUJZSA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbUJZSA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUJZR7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:59:31 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:31875 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261369AbUJZR6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:58:21 -0400
Subject: Re: 2.6.9-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
References: <20041022032039.730eb226.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1098813484.10011.226.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 26 Oct 2004 19:58:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 12:20, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
> 
> - Lots of new patches.

Two different boxes, hits when running the ltp tests'./runltp -x 4'. El
problemo is that it doesn't happen when running it as a normal user.
Both are with ltp-full-20041007, how well is this trusted?

Even worse, when I throw in CONFIG_SLAB_DEBUG & CONFIG_DEBUG_PAGEALLOC
the errors seem to go away, bleh, why do I always end up with these
weird errors.

Anything I can do to provide more info? I'm clueless on fs-debugging.


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c016d77c
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c016d77c>]    Not tainted VLI
EFLAGS: 00010203   (2.6.9-mm1)
EIP is at dio_cleanup+0x1c/0x60
eax: 00000000   ebx: cf12f200   ecx: 00000000   edx: 00000000
esi: cf12f200   edi: 00000000   ebp: 00000000   esp: c8fcfcd0
ds: 007b   es: 007b   ss: 0068
Process diotest4 (pid: 13094, threadinfo=c8fcf000 task=c583b020)
Stack: 00000000 c016e59f c0196c49 c0b7d95c 00000000 00000000 00c4f000 00000000
       cbad54fc c8fcfef0 00000001 cf12f200 00000000 08051000 0000000c c016ea7c
       c8fcfeb0 00c4f000 00000000 00000001 0000000c c01832d0 00000000 cf12f200
Call Trace:
 [<c016e59f>] direct_io_worker+0x2cf/0x5c0
 [<c0196c49>] journal_put_journal_head+0x39/0xb0
 [<c016ea7c>] __blockdev_direct_IO+0x1ec/0x2d6
 [<c01832d0>] ext3_direct_io_get_blocks+0x0/0xe0
 [<c01841f9>] ext3_direct_IO+0xc9/0x230
 [<c01832d0>] ext3_direct_io_get_blocks+0x0/0xe0
 [<c0132604>] generic_file_direct_IO+0x74/0x90
 [<c01316f6>] generic_file_direct_write+0x76/0x180
 [<c0131ff8>] generic_file_aio_write_nolock+0x298/0x480
 [<c01060d8>] do_IRQ+0x58/0x80
 [<c0132310>] generic_file_aio_write+0x70/0xe0
 [<c0181440>] ext3_file_write+0x30/0xb0
 [<c014c941>] do_sync_write+0xa1/0xe0
 [<c011240a>] do_page_fault+0x19a/0x5aa
 [<c0113951>] finish_task_switch+0x31/0x90
 [<c0129d80>] autoremove_wake_function+0x0/0x50
 [<c0104708>] common_interrupt+0x18/0x20
 [<c0113951>] finish_task_switch+0x31/0x90
 [<c014ca30>] vfs_write+0xb0/0x100
 [<c014d7e3>] fget_light+0x3/0xa0
 [<c014cb47>] sys_write+0x47/0x80
 [<c0103d9b>] syscall_call+0x7/0xb
Code: fe ff 8b 46 08 eb d1 e8 e3 5c 10 00 eb b9 90 53 89 c3 8b 80 9c 01 00 00 3b 83 98 01 00 00 75 02 5b c3 89 d8 e8 56 fc ff ff 89 c2 <8b> 00 f6 c4 08 75 11 8b 42 04 40 74 24 83 42 04 ff 0f 98 c0 84


Unable to handle kernel paging request at virtual address 47ce20ac
 printing eip:
c016d3e1
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c016d3e1>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-mm1)
EIP is at dio_get_page+0x11/0x50
eax: 61048c05   ebx: c3bbf000   ecx: 00000000   edx: 00000001
esi: c3bbf000   edi: 00000000   ebp: 00000000   esp: c61e6cc8
ds: 007b   es: 007b   ss: 0068
Process diotest1 (pid: 4564, threadinfo=c61e6000 task=c5897020)
Stack: c3bbf000 c016d77a 00000000 c016e59f c0196c49 d7cfa44c 00000000 00000000
       00000000 00000000 def1f84c c61e6ef0 00000001 c3bbf000 00000000 08050000
       0000000c c016ea7c c61e6eb0 00000000 00000000 00000001 0000000c c01832d0
Call Trace:
 [<c016d77a>] dio_cleanup+0x1a/0x60
 [<c016e59f>] direct_io_worker+0x2cf/0x5c0
 [<c0196c49>] journal_put_journal_head+0x39/0xb0
 [<c016ea7c>] __blockdev_direct_IO+0x1ec/0x2d6
 [<c01832d0>] ext3_direct_io_get_blocks+0x0/0xe0
 [<c01841f9>] ext3_direct_IO+0xc9/0x230
 [<c01832d0>] ext3_direct_io_get_blocks+0x0/0xe0
 [<c0132604>] generic_file_direct_IO+0x74/0x90
 [<c01316f6>] generic_file_direct_write+0x76/0x180
 [<c0131ff8>] generic_file_aio_write_nolock+0x298/0x480
 [<c0132310>] generic_file_aio_write+0x70/0xe0
 [<c0181440>] ext3_file_write+0x30/0xb0
 [<c014c941>] do_sync_write+0xa1/0xe0
 [<c011240a>] do_page_fault+0x19a/0x5aa
 [<c0140481>] vma_merge+0x121/0x190
 [<c0129d80>] autoremove_wake_function+0x0/0x50
 [<c0141885>] do_brk+0x175/0x230
 [<c0113951>] finish_task_switch+0x31/0x90
 [<c014ca30>] vfs_write+0xb0/0x100
 [<c014cb47>] sys_write+0x47/0x80
 [<c0103d9b>] syscall_call+0x7/0xb
Code: 9c 01 00 00 01 00 00 00 c7 85 98 01 00 00 00 00 00 00 89 85 98 00 00 00 eb 9f 53 89 c3 8b 80 98 01 00 00 39 83 9c 01 00 00 74 12 <8b> 94 83 98 00 00 00 40 89 83 98 01 00 00 89 d0 5b c3 89 d8 e8


