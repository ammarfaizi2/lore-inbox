Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262641AbTCIV7D>; Sun, 9 Mar 2003 16:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262642AbTCIV7D>; Sun, 9 Mar 2003 16:59:03 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:37730
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262641AbTCIV7C>; Sun, 9 Mar 2003 16:59:02 -0500
Date: Sun, 9 Mar 2003 17:07:16 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops in ext3 error handling -> journal_abort
Message-ID: <Pine.LNX.4.50.0303091704330.1464-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to get this when mounting a corrupt volume, it looks like my 
journal got zapped. Andrew would a couple extra checks for 
EXT3_SB(sb)->s_journal be ok during fill_super?

kernel is 2.5.64

EXT3-fs error (device loop(7,0)): ext3_check_descriptors: Block bitmap for 
group 32 not in group (block 0)!
Unable to handle kernel NULL pointer dereference at virtual address 000000b4
 printing eip:
c01a9cae
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c01a9cae>]    Tainted: PF 
EFLAGS: 00010246
EIP is at journal_abort+0x1e/0x50
eax: c0454df9   ebx: 000000b4   ecx: 000000b4   edx: 00000077
esi: 00000000   edi: 00000020   ebp: cfd29dec   esp: cfd29de4
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 1417, threadinfo=cfd28000 task=cdcc4cc0)
Stack: c9988400 cf955c00 cfd29e04 c019f3e9 00000000 fffffffb cf955c00 00040001 
       cfd29e30 c019f439 cf955c00 c04655a0 cf955d38 c045ea3b c05c5d20 c05c5d20 
       c0465d40 cfd29e44 c172a704 cfd29e64 c01a049a cf955c00 c045ea3b c0465d40 
Call Trace:
 [<c019f3e9>] ext3_handle_error+0x79/0x90
 [<c019f439>] ext3_error+0x39/0x40
 [<c01a049a>] ext3_check_descriptors+0xba/0xd0
 [<c01a0d21>] ext3_fill_super+0x581/0x9d0
 [<c01628f3>] get_sb_bdev+0x103/0x150
 [<c01a1d1d>] ext3_get_sb+0x1d/0x30
 [<c01a07a0>] ext3_fill_super+0x0/0x9d0
 [<c0162ad0>] do_kern_mount+0x40/0xc0
 [<c017a9e7>] do_add_mount+0x57/0x160
 [<c017acf0>] do_mount+0x140/0x1b0
 [<c017b173>] sys_mount+0xb3/0x100
 [<c0109a17>] syscall_call+0x7/0xb

Code: f0 ff 8e b4 00 00 00 0f 88 ea 0a 00 00 8b 4d 0c 51 56 e8 7b 

