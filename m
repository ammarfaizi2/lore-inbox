Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTE2PoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTE2PoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:44:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:45478 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262331AbTE2PoN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:44:13 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: andrew <akpm@digeo.com>
Subject: 2.5.70-mm1 panic with as-scheduler ?
Date: Thu, 29 May 2003 08:46:52 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, nsharoff@us.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305290846.52019.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here is the BUG() we got on 2.5.70-mm1.
Is this a known problem with AS ?

Thanks,
Badari


kernel BUG at drivers/block/as-iosched.c:363!
invalid operand: 0000 [#1]
CPU:    5
EIP:    0060:[<c02b4810>]    Not tainted VLI
EFLAGS: 00010046
EIP is at as_find_arq_hash+0xb0/0xc0
eax: eb950a40   ebx: eb950a40   ecx: eb950a40   edx: eb950a20
esi: 00000000   edi: ce633de8   ebp: f7b5a6d8   esp: eb569cec
ds: 007b   es: 007b   ss: 0068
Process ftest03 (pid: 29908, threadinfo=eb568000 task=f78006d0)
Stack: 0026ae00 00000000 00000000 00000000 0026ae08 00000000 c02b5bf1 f7b5dda0
       0026ae00 00000000 00000001 00000001 f7b5dda0 00000000 f7b5a800 00000008
       00000000 c02ac769 f7b5a800 eb569d64 d1b309a0 c02af330 f7b5a800 eb569d64
Call Trace:
 [<c02b5bf1>] as_merge+0xf1/0x1d0
 [<c02ac769>] elv_merge+0x29/0x30
 [<c02af330>] __make_request+0x2c0/0x4e0
 [<c02af717>] generic_make_request+0x1c7/0x290
 [<c0159ff0>] submit_bh+0x90/0x1e0
 [<c02af834>] submit_bio+0x54/0xa0
 [<c01584e0>] __block_write_full_page+0x250/0x460
 [<c0159eb8>] block_write_full_page+0xd8/0xe0
 [<c0191df0>] ext3_get_block+0x0/0xb0
 [<c0192a46>] ext3_writepage+0x166/0x280
 [<c0191df0>] ext3_get_block+0x0/0xb0
 [<c01928c0>] bget_one+0x0/0x10
 [<c01788b8>] mpage_writepages+0x238/0x305
 [<c0176b76>] __mark_inode_dirty+0xf6/0x100
 [<c01928e0>] ext3_writepage+0x0/0x280
 [<c0194840>] ext3_setattr+0xf0/0x1a0
 [<c013a88c>] generic_file_writev+0x5c/0x80
 [<c0155656>] do_readv_writev+0x1c6/0x2d0
 [<c013d5c6>] do_writepages+0x36/0x40
 [<c0137be8>] __filemap_fdatawrite+0xd8/0xe0
 [<c0137c07>] filemap_fdatawrite+0x17/0x20
 [<c0156ad3>] sys_fsync+0xb3/0x110
 [<c010943f>] syscall_call+0x7/0xb
 
Code: 1c 3b 70 3c 75 cf 8b 47 14 31 d2 8b 4c 24 04 03 47 0c 8b 34 24 13 57 10 
31
f0 31 d1 89 fa 09 c1 75 c9 eb cf 8d b4 26 00 00 00 00 <0f> 0b 6b 01 cb 4c 44 
c0 eb 95 8d b6 00 00 00 00 8b 54 24 08 31
