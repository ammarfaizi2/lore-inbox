Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUGTLoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUGTLoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 07:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUGTLoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 07:44:24 -0400
Received: from email.archlab.tuwien.ac.at ([128.131.118.17]:8930 "EHLO
	email.archlab.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S265799AbUGTLoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 07:44:18 -0400
Date: Tue, 20 Jul 2004 13:44:18 +0200
To: linux-kernel@vger.kernel.org
Subject: 4K stack kernel get Oops in Filesystem stress test
Message-ID: <20040720114418.GH21918@email.archlab.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I use vanila kernel 2.6.7 and 2.6.8-rc1 with 4K stack enabled,
but if I execute the filesystem stress test from ltp.sf.net (linux test
project) the machine always crash immediately. Or it will crash also after few
hours if I do kernel compile test repeatedly. But if I use 8K stack,
my server survive this filesystem stress test.
Also my notebook get oops if I used 4k stack in kernel , but it crashed 
after few minutes running the filesystem stress test (not immediately).
My configuration is
compaq proliant ML530/G2 , 2 processor intel 2.4Ghz, 1GB ram ,
LVM1 volume with XFS filesystem.
and here is the Oops message:

Unable to handle kernel paging request at virtual address 770000d5
 printing eip:
c01153ef
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: eepro100
CPU:    10
EIP:    0060:[<c01153ef>]    Not tainted
EFLAGS: 00010893   (2.6.7) 
EIP is at do_page_fault+0x51/0x583
eax: cafc4000   ebx: cafda000   ecx: 0000007b   edx: 7700006d
esi: 00000000   edi: c011539e   ebp: cafc40f0   esp: cafc4048
ds: 007b   es: 007b   ss: 0068
Process  (pid: -1072123377, threadinfo=cafc3000 task=dd8b4000)
Stack: 65ff0066 6c69616d 6669672e 2e780500 00666967 770000d5 7700006d 672e6f01 
       00006669 00030001 2e746573 00666967 78656eff 69672e74 78040066 6669672e 
       7270fc00 672e7665 04006669 69672e78 69fe0066 672e746e 03006669 69672e78 
Call Trace:
 [<c0106d63>] show_stack+0x80/0x96
 [<c0106efa>] show_registers+0x15f/0x1ae
 [<c0107087>] die+0xa5/0x11e
 [<c011558f>] do_page_fault+0x1f1/0x583
 [<c0106a05>] error_code+0x2d/0x38
 [<c0106a05>] error_code+0x2d/0x38
 ... Another hundreds of error_code+0x2d/0x38
 [<c0106a05>] error_code+0x2d/0x38
 [<c01068e8>] common_interrupt+0x18/0x20
 [<c031d52b>] dm_request+0x28/0xcd
 [<c02ada03>] generic_make_request+0x151/0x1cf
 [<c02adaef>] submit_bio+0x6e/0x11a
 [<c02632ee>] _pagebuf_ioapply+0x1c3/0x2c2
 [<c0263468>] pagebuf_iorequest+0x7b/0x147
 [<c0262fb2>] pagebuf_iostart+0x72/0xa0
 [<c02626d2>] pagebuf_get+0x174/0x1d6
 [<c025448b>] xfs_trans_read_buf+0x17f/0x38b
 [<c021d0a3>] xfs_btree_read_bufs+0x71/0x87
 [<c02029e7>] xfs_alloc_lookup+0x109/0x3ea
 [<c01ff43c>] xfs_alloc_ag_vextent_size+0x74/0x4d7
 [<c01fe5b5>] xfs_alloc_ag_vextent+0x102/0x128
 [<c0200eb3>] xfs_alloc_vextent+0x3d8/0x4cc
 [<c0210311>] xfs_bmap_alloc+0x816/0x1746
 [<c021445c>] xfs_bmapi+0x500/0x1457
 [<c0240e20>] xfs_iomap_write_allocate+0x299/0x4d9
 [<c023fe46>] xfs_iomap+0x37d/0x4a7
 [<c0260102>] xfs_map_blocks+0x6f/0x14a
 [<c0261132>] xfs_page_state_convert+0x42b/0x542
 [<c026184e>] linvfs_writepage+0x63/0xec
 [<c017bd4d>] mpage_writepages+0x1a0/0x30b
 [<c013e55d>] do_writepages+0x3e/0x44
 [<c0138663>] __filemap_fdatawrite+0x7a/0x7c
 [<c013869b>] filemap_flush+0x19/0x1d
 [<c024000c>] xfs_flush_space+0x9c/0xc2
 [<c0240a03>] xfs_iomap_write_delay+0x573/0x6f7
 [<c023fd92>] xfs_iomap+0x2c9/0x4a7
 [<c02612d8>] linvfs_get_block_core+0x8f/0x28e
 [<c026151c>] linvfs_get_block+0x45/0x49
 [<c015b8e6>] __block_prepare_write+0x1d3/0x3bb
 [<c015c2fa>] block_prepare_write+0x32/0x42
 [<c013a97e>] generic_file_aio_write_nolock+0x3d2/0xc11
 [<c0268454>] xfs_write+0x243/0x7bf
 [<c026450e>] linvfs_writev+0xdb/0x15d
 [<c0158637>] do_readv_writev+0x1f0/0x23a
 [<c015872e>] vfs_writev+0x52/0x5b
 [<c01587d3>] sys_writev+0x3f/0x5d
 [<c0105f7b>] syscall_call+0x7/0xb
 =======================
 [<c0106d63>] show_stack+0x80/0x96
 [<c0106efa>] show_registers+0x15f/0x1ae
 [<c0107087>] die+0xa5/0x11e
 [<c011558f>] do_page_fault+0x1f1/0x583
 [<c0106a05>] error_code+0x2d/0x38
 [<c0106a05>] error_code+0x2d/0x38
 ... Another hundreds of error_code+0x2d/0x38
 [<c0106a05>] error_code+0x2d/0x38
 [<c01068e8>] common_interrupt+0x18/0x20
 [<c0106a05>] erro_code+0x2d/0x38
 [<c0106a05>] erro_code+0x2d/0x38
 [<c0106a05>] erro_code+0x2d/0x38
 [<c031d52b>] dm_request+0x28/0xcd
 [<c02ada03>] generic_make_request+0x151/0x1cf
 [<c02adaef>] submit_bio+0x6e/0x11a
 [<c02632ee>] _pagebuf_ioapply+0x1c3/0x2c2
 [<c0263468>] pagebuf_iorequest+0x7b/0x147
 [<c0262fb2>] pagebuf_iostart+0x72/0xa0
 [<c02626d2>] pagebuf_get+0x174/0x1d6
 [<c025448b>] xfs_trans_read_buf+0x17f/0x38b
 [<c021d0a3>] xfs_btree_read_bufs+0x71/0x87
 [<c02029e7>] xfs_alloc_lookup+0x109/0x3ea
 [<c01ff43c>] xfs_alloc_ag_vextent_size+0x74/0x4d7
 [<c01fe5b5>] xfs_alloc_ag_vextent+0x102/0x128
 [<c0200eb3>] xfs_alloc_vextent+0x3d8/0x4cc
 [<c0210311>] xfs_bmap_alloc+0x816/0x1746
 [<c021445c>] xfs_bmapi+0x500/0x1457
 [<c0240e20>] xfs_iomap_write_allocate+0x299/0x4d9
 [<c023fe46>] xfs_iomap+0x37d/0x4a7
 [<c0260102>] xfs_map_blocks+0x6f/0x14a
 [<c0261132>] xfs_page_state_convert+0x42b/0x542
 [<c026184e>] linvfs_writepage+0x63/0xec
 [<c017bd4d>] mpage_writepages+0x1a0/0x30b
 [<c013e55d>] do_writepages+0x3e/0x44
 [<c0138663>] __filemap_fdatawrite+0x7a/0x7c
 [<c013869b>] filemap_flush+0x19/0x1d
 [<c024000c>] xfs_flush_space+0x9c/0xc2
 [<c0240a03>] xfs_iomap_write_delay+0x573/0x6f7
 [<c023fd92>] xfs_iomap+0x2c9/0x4a7
 [<c02612d8>] linvfs_get_block_core+0x8f/0x28e
 [<c026151c>] linvfs_get_block+0x45/0x49
 [<c015b8e6>] __block_prepare_write+0x1d3/0x3bb
 [<c015c2fa>] block_prepare_write+0x32/0x42
 [<c013a97e>] generic_file_aio_write_nolock+0x3d2/0xc11
 [<c0268454>] xfs_write+0x243/0x7bf
 [<c026450e>] linvfs_writev+0xdb/0x15d
 [<c0158637>] do_readv_writev+0x1f0/0x23a
 [<c015872e>] vfs_writev+0x52/0x5b
 [<c01587d3>] sys_writev+0x3f/0x5d
 [<c0105f7b>] syscall_call+0x7/0xb
Unable to handle kernel paging request at virtual address 66690030
 printing eip:
c0106ca0
*pde = 00000000

Thanks,
Cahya.



