Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTJ3GvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 01:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTJ3GvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 01:51:12 -0500
Received: from www13.mailshell.com ([209.157.66.247]:7901 "HELO mailshell.com")
	by vger.kernel.org with SMTP id S262202AbTJ3GvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 01:51:09 -0500
Message-ID: <20031030065107.7086.qmail@mailshell.com>
Date: Thu, 30 Oct 2003 08:51:04 +0200
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
References: <20031028154920.1905.qmail@mailshell.com>	<20031028141329.13443875.akpm@osdl.org>	<20031029174419.5776.qmail@mailshell.com>	<20031029123107.338796a4.akpm@osdl.org>	<200310292149.h9TLnsNq024151@car.linuxhacker.ru> <20031029141931.6c4ebdb5.akpm@osdl.org>
In-Reply-To: <20031029141931.6c4ebdb5.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
From: lkml-031028@amos.mailshell.com
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Amos, could you add this as well?

Here are the results from a kernel compiled with all your patches (3
so far).

The WARN_ON stuff doesn't seem to emit anything (looked for "Badness").

set_blocksize: size=1024
set_blocksize: 1024 OK
set_blocksize: size=1024
set_blocksize: 1024 OK
set_blocksize: size=1024
set_blocksize: 1024 OK
set_blocksize: size=1024
set_blocksize: 1024 OK
set_blocksize: size=4096
buffer layer error at fs/buffer.c:431
Call Trace:
  [<c014ff44>] __find_get_block_slow+0x94/0x150
  [<c0150f43>] __find_get_block+0x83/0xe0
  [<c0150fcb>] __getblk+0x2b/0x60
  [<c015107f>] __bread+0x1f/0x40
  [<c01a3532>] read_super_block+0x82/0x210
  [<c01a4195>] reiserfs_fill_super+0x555/0x5a0
  [<c01d7eb7>] snprintf+0x27/0x30
  [<c0155880>] set_blocksize+0xd0/0x110
  [<c01558e5>] sb_set_blocksize+0x25/0x60
  [<c0155254>] get_sb_bdev+0x124/0x160
  [<c01a424f>] get_super_block+0x2f/0x60
  [<c01a3c40>] reiserfs_fill_super+0x0/0x5a0
  [<c01554bf>] do_kern_mount+0x5f/0xe0
  [<c016a7c8>] do_add_mount+0x78/0x150
  [<c016aab4>] do_mount+0x124/0x170
  [<c016a920>] copy_mount_options+0x80/0xf0
  [<c016ae6f>] sys_mount+0xbf/0x140
  [<c047cb9f>] do_mount_root+0x2f/0xa0
  [<c047cc64>] mount_block_root+0x54/0x120
  [<c047cd8e>] mount_root+0x5e/0x70
  [<c047cdbd>] prepare_namespace+0x1d/0xe0
  [<c01050d2>] init+0x32/0x160
  [<c01050a0>] init+0x0/0x160
  [<c01070c9>] kernel_thread_helper+0x5/0xc

block=16, b_blocknr=64
b_state=0x00000019, b_size=1024
device blocksize: 4096
buffer layer error at fs/buffer.c:431
Call Trace:
  [<c014ff44>] __find_get_block_slow+0x94/0x150
  [<c01070c9>] kernel_thread_helper+0x5/0xc
  [<c010970c>] dump_stack+0x1c/0x20
  [<c0150f43>] __find_get_block+0x83/0xe0
  [<c0150b73>] __getblk_slow+0x23/0xf0
  [<c0150fef>] __getblk+0x4f/0x60
  [<c015107f>] __bread+0x1f/0x40
  [<c01a3532>] read_super_block+0x82/0x210
  [<c01a4195>] reiserfs_fill_super+0x555/0x5a0
  [<c01d7eb7>] snprintf+0x27/0x30
  [<c0155880>] set_blocksize+0xd0/0x110
  [<c01558e5>] sb_set_blocksize+0x25/0x60
  [<c0155254>] get_sb_bdev+0x124/0x160
  [<c01a424f>] get_super_block+0x2f/0x60
  [<c01a3c40>] reiserfs_fill_super+0x0/0x5a0
  [<c01554bf>] do_kern_mount+0x5f/0xe0
  [<c016a7c8>] do_add_mount+0x78/0x150
  [<c016aab4>] do_mount+0x124/0x170
  [<c016a920>] copy_mount_options+0x80/0xf0
  [<c016ae6f>] sys_mount+0xbf/0x140
  [<c047cb9f>] do_mount_root+0x2f/0xa0
  [<c047cc64>] mount_block_root+0x54/0x120
  [<c047cd8e>] mount_root+0x5e/0x70
  [<c047cdbd>] prepare_namespace+0x1d/0xe0
  [<c01050d2>] init+0x32/0x160
  [<c01050a0>] init+0x0/0x160
  [<c01070c9>] kernel_thread_helper+0x5/0xc

block=16, b_blocknr=64
b_state=0x00000019, b_size=1024
device blocksize: 4096
found reiserfs format "3.6" with standard journal
hub 1-0:1.0: debounce: port 3: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:02.2: port 3 full speed --> companion
ehci_hcd 0000:00:02.2: GetStatus port 3 status 003001 POWER OWNER 
sig=se0  CONNECT
Reiserfs journal params: device hda2, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda2) for (hda2)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 404k freed
set_blocksize: size=4096

Thanks,

--Amos

