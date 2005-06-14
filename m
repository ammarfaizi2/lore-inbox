Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVFNOEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVFNOEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVFNOEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:04:45 -0400
Received: from [38.119.156.194] ([38.119.156.194]:8576 "EHLO
	smtp.spineless.org") by vger.kernel.org with ESMTP id S261214AbVFNOEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:04:36 -0400
Message-ID: <42AEE3DA.8060201@spineless.org>
Date: Tue, 14 Jun 2005 10:04:10 -0400
From: John Baboval <baboval@spineless.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11: kernel BUG at fs/jbd/checkpoint.c:247! - Also on 2.6.12-rc5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2005 16:33:56 -0700 Andrew Morton <akpm@osdl.org> wrote:
> Please test
> 
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.12-rc5.tar.bz2
> plus
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-rc5-git8.bz2


I've just reproduced this on 2.6.12-rc5.

It was hapening every 4 hours or so with 2.6.11.9. 2.6.12-rc5 ran for a week... The system is being used as a fairly high traffic NFS server.

If you need more information from my system, please CC my address with responses as I'm not subscribed to the list.

-John

kernel BUG at fs/jbd/checkpoint.c:247!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[__flush_buffer+269/384]    Not tainted VLI
EFLAGS: 00010286   (2.6.12-rc5) 
EIP is at __flush_buffer+0x10d/0x180
eax: 0000005d   ebx: d72c3418   ecx: c044e8f4   edx: 00000001
esi: e8fc7ce4   edi: 00000000   ebp: e8fc7cb0   esp: e8fc7c90
ds: 007b   es: 007b   ss: 0068
Process find (pid: 6826, threadinfo=e8fc6000 task=f7f23a60)
Stack: c03f8e80 c03e0fc7 c03f4bc8 000000f7 c03f4bdc ec6791d8 d72c3418 f4cafb98 
       e8fc7df4 c01af8cd f7014544 ec6791d8 e8fc7ce8 e8fc7ce0 e8fc7ce4 e8fc6000 
       001651f8 cbd1bcd8 f72a0ce8 f7014628 00000012 00000042 d72c3418 ea265c58 
Call Trace:
 [show_stack+127/160] show_stack+0x7f/0xa0
 [show_registers+355/464] show_registers+0x163/0x1d0
 [die+257/400] die+0x101/0x190
 [do_invalid_op+188/208] do_invalid_op+0xbc/0xd0
 [error_code+79/84] error_code+0x4f/0x54
 [log_do_checkpoint+221/560] log_do_checkpoint+0xdd/0x230
 [__log_wait_for_space+178/208] __log_wait_for_space+0xb2/0xd0
 [start_this_handle+255/864] start_this_handle+0xff/0x360
 [journal_start+168/208] journal_start+0xa8/0xd0
 [ext3_dirty_inode+56/144] ext3_dirty_inode+0x38/0x90
 [__mark_inode_dirty+465/480] __mark_inode_dirty+0x1d1/0x1e0
 [update_atime+146/192] update_atime+0x92/0xc0
 [vfs_readdir+166/176] vfs_readdir+0xa6/0xb0
 [sys_getdents64+117/199] sys_getdents64+0x75/0xc7
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 3f c0 b8 dc 4b 3f c0 89 44 24 10 b8 f7 00 00 00 89 44 24 0c b8 c8 4b 3f c0 89 44 24 08 b8 c7 0f 3e c0 89 44 24 04 e8 43 b2 f6 ff <0f> 0b f7 00 c8 4b 3f c0 e9 38 ff ff ff c7 04 24 80 8e 3f c0 b9 
 <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [dump_stack+30/48] dump_stack+0x1e/0x30
 [__might_sleep+167/176] __might_sleep+0xa7/0xb0
 [profile_task_exit+35/96] profile_task_exit+0x23/0x60
 [do_exit+29/944] do_exit+0x1d/0x3b0
 [die+392/400] die+0x188/0x190
 [do_invalid_op+188/208] do_invalid_op+0xbc/0xd0
 [error_code+79/84] error_code+0x4f/0x54
 [log_do_checkpoint+221/560] log_do_checkpoint+0xdd/0x230
 [__log_wait_for_space+178/208] __log_wait_for_space+0xb2/0xd0
 [start_this_handle+255/864] start_this_handle+0xff/0x360
 [journal_start+168/208] journal_start+0xa8/0xd0
 [ext3_dirty_inode+56/144] ext3_dirty_inode+0x38/0x90
 [__mark_inode_dirty+465/480] __mark_inode_dirty+0x1d1/0x1e0
 [update_atime+146/192] update_atime+0x92/0xc0
 [vfs_readdir+166/176] vfs_readdir+0xa6/0xb0
 [sys_getdents64+117/199] sys_getdents64+0x75/0xc7
 [syscall_call+7/11] syscall_call+0x7/0xb


