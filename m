Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSKJSIx>; Sun, 10 Nov 2002 13:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264985AbSKJSIw>; Sun, 10 Nov 2002 13:08:52 -0500
Received: from services.cam.org ([198.73.180.252]:23028 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S264984AbSKJSIu>;
	Sun, 10 Nov 2002 13:08:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.46-mm2 - oops
Date: Sun, 10 Nov 2002 13:14:58 -0500
User-Agent: KMail/1.4.3
References: <3DCDD9AC.C3FB30D9@digeo.com>
In-Reply-To: <3DCDD9AC.C3FB30D9@digeo.com>
Cc: Chris Mason <mason@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211101309.21447.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 9, 2002 10:59 pm, Andrew Morton wrote:

> Of note in -mm2 is a patch from Chris Mason which teaches reiserfs to
> use the mpage code for reads - it should show a nice reduction in CPU
> load under reiserfs reads.

Booting into mm2 I get:


VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 96k freed
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c015f967
*pde = 00000000
Oops: 0000

CPU:    0
EIP:    0060:[<c015f967>]    Not tainted
EFLAGS: 00010203
EIP is at mpage_readpages+0x47/0x140
eax: df8db954   ebx: 00000000   ecx: dff89c30   edx: dff89c30
esi: 00000007   edi: 00000000   ebp: dff89c30   esp: dff89b1c
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=dff88000 task=c151e040)
Stack: 00000000 00000000 00000000 00000000 00000000 c0325760 dfb62cd4 c0145054
       c0325740 c0145078 df90e6bc df90e6bc dfb62cd4 df90e654 df9577f4 df90e6f0
       df90e688 dfb18620 c172f654 dfa33348 dfb62cd4 00002e7c 00000000 00000007
Call Trace:
 [<c0145054>] bh_lru_install+0x94/0x100
 [<c0145078>] bh_lru_install+0xb8/0x100
 [<c0187716>] reiserfs_readpages+0x16/0x20
 [<c01847e0>] reiserfs_get_block+0x0/0x1000
 [<c013b9ac>] read_pages+0xec/0x100
 [<c0135d2c>] buffered_rmqueue+0xcc/0x180
 [<c01360a1>] __alloc_pages+0x81/0x220
 [<c013ba91>] do_page_cache_readahead+0xd1/0x160
 [<c013bb78>] page_cache_readahead+0x58/0x160
 [<c012dc4d>] do_generic_mapping_read+0x8d/0x3c0
 [<c012dfc0>] file_read_actor+0x0/0xe0
 [<c012e23f>] __generic_file_aio_read+0x19f/0x1e0
 [<c012dfc0>] file_read_actor+0x0/0xe0
 [<c012e358>] generic_file_read+0x78/0xa0
 [<c011609e>] mm_init+0xbe/0x100
 [<c0142546>] vfs_read+0xa6/0x100
 [<c014bbf8>] kernel_read+0x38/0x60
 [<c014bfed>] prepare_binprm+0xad/0xc0
 [<c014c570>] do_execve+0x1b0/0x260
 [<c0107833>] sys_execve+0x33/0x60
 [<c0109057>] syscall_call+0x7/0xb
 [<c010511f>] init+0xdf/0x160
 [<c0105040>] init+0x0/0x160
 [<c01070a1>] kernel_thread_helper+0x5/0x24

Code: 8b 43 04 8d 73 f8 8b 13 89 42 04 89 10 ff 76 14 ff 74 24 74
 <0>Kernel panic: Attempted to kill init!

or trying a second time:

found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,3), size 8192, journal first block 18, max trans len 1024, max batch 900, max
 commit age 30, max trans age 30
reiserfs: checking transaction log (ide2(33,3)) for (ide2(33,3))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 96k freed
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c015f967
*pde = 00000000
Oops: 0000

CPU:    0
EIP:    0060:[<c015f967>]    Not tainted
EFLAGS: 00010203
EIP is at mpage_readpages+0x47/0x140
eax: c17d5954   ebx: 00000000   ecx: dff89c30   edx: dff89c30
esi: 00000007   edi: 00000000   ebp: dff89c30   esp: dff89b1c
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=dff88000 task=c151e040)
Stack: 00000000 00000000 00000000 00000000 00000000 c151e040 c0320400 00000000
       c01145a6 dff89b60 00000000 c151e040 00000004 00000004 dffe8b34 dffe8b34
       dff89b88 c03a5b20 c0143d6d 00000000 c151e040 c0115ec0 dff89b94 00000007
Call Trace:
 [<c01145a6>] do_schedule+0x186/0x300
 [<c0143d6d>] __wait_on_buffer+0xad/0xc0
 [<c0115ec0>] autoremove_wake_function+0x0/0x40
 [<c0187716>] reiserfs_readpages+0x16/0x20
 [<c01847e0>] reiserfs_get_block+0x0/0x1000
 [<c013b9ac>] read_pages+0xec/0x100
 [<c0135d2c>] buffered_rmqueue+0xcc/0x180
 [<c01360a1>] __alloc_pages+0x81/0x220
 [<c013ba91>] do_page_cache_readahead+0xd1/0x160
 [<c013bb78>] page_cache_readahead+0x58/0x160
 [<c012dc4d>] do_generic_mapping_read+0x8d/0x3c0
 [<c012dfc0>] file_read_actor+0x0/0xe0
 [<c012e23f>] __generic_file_aio_read+0x19f/0x1e0
 [<c012dfc0>] file_read_actor+0x0/0xe0
 [<c012e358>] generic_file_read+0x78/0xa0
 [<c011609e>] mm_init+0xbe/0x100
 [<c0142546>] vfs_read+0xa6/0x100
 [<c014bbf8>] kernel_read+0x38/0x60
 [<c014bfed>] prepare_binprm+0xad/0xc0
 [<c014c570>] do_execve+0x1b0/0x260
 [<c0107833>] sys_execve+0x33/0x60
 [<c0109057>] syscall_call+0x7/0xb
 [<c010511f>] init+0xdf/0x160
 [<c0105040>] init+0x0/0x160
 [<c01070a1>] kernel_thread_helper+0x5/0x24

Code: 8b 43 04 8d 73 f8 8b 13 89 42 04 89 10 ff 76 14 ff 74 24 74
 <0>Kernel panic: Attempted to kill init!

Hope this helps
Ed Tomlinson

