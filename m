Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTIVTAC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263278AbTIVTAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:00:01 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:949 "EHLO
	thumper2.emsphone.com") by vger.kernel.org with ESMTP
	id S263267AbTIVS6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:58:37 -0400
Date: Mon, 22 Sep 2003 13:58:32 -0500
From: Andrew Ryan <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at drivers/scsi/scsi_lib.c:544
Message-ID: <20030922185832.GA10652@thumper2.emsphone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hit this bug when trying to mount a md multipath device.  mdadm creates it
fine, but when I go to mount the device it oops.

Kernel : 2.6.0-test5

ksymoops 2.4.4 on i686 2.6.0-test5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test5/ (default)
     -m /boot/System.map-2.6.0-test5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Sep 22 11:06:23 linuxha1 kernel: kernel BUG at drivers/scsi/scsi_lib.c:544!
Sep 22 11:06:23 linuxha1 kernel: invalid operand: 0000 [#1]
Sep 22 11:06:23 linuxha1 kernel: CPU:    1
Sep 22 11:06:23 linuxha1 kernel: EIP:    0060:[<c0232115>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 22 11:06:23 linuxha1 kernel: EFLAGS: 00010046
Sep 22 11:06:23 linuxha1 kernel: eax: 00000000   ebx: f6cab1b0   ecx: c2707c00   edx: f6d08d20
Sep 22 11:06:23 linuxha1 kernel: esi: 00000020   edi: f6d08d20   ebp: f6cab1b0   esp: f6aa1d2c
Sep 22 11:06:23 linuxha1 kernel: ds: 007b   es: 007b   ss: 0068
Sep 22 11:06:23 linuxha1 kernel: Stack: 00000020 f6cab1b0 00000020 f6d08d20 f6cab1b0 c02326fb f6d08d20 00000020 
Sep 22 11:06:23 linuxha1 kernel:        f6d08d20 00000020 c2707c00 c023289d f6d08d20 f6cab1b0 f6e75e00 f6aa1dac 
Sep 22 11:06:23 linuxha1 kernel:        f69e7124 c01f1cf4 f6e75e00 f6cab1b0 f6e75e00 f6e75f50 c01f34d5 f6e75e00 
Sep 22 11:06:23 linuxha1 kernel:  [<c02326fb>] scsi_init_io+0x5b/0x110
Sep 22 11:06:23 linuxha1 kernel:  [<c023289d>] scsi_prep_fn+0xed/0x150
Sep 22 11:06:23 linuxha1 kernel:  [<c01f1cf4>] elv_next_request+0x14/0xe0
Sep 22 11:06:23 linuxha1 kernel:  [<c01f34d5>] generic_unplug_device+0x45/0x70
Sep 22 11:06:23 linuxha1 kernel:  [<c01380bf>] do_page_cache_readahead+0x14f/0x170
Sep 22 11:06:23 linuxha1 kernel:  [<c01f3615>] blk_run_queues+0x75/0xa0
Sep 22 11:06:23 linuxha1 kernel:  [<c01512c5>] block_sync_page+0x5/0x10
Sep 22 11:06:23 linuxha1 kernel:  [<c01326bf>] __lock_page+0xaf/0xe0
Sep 22 11:06:23 linuxha1 kernel:  [<c0118dc0>] autoremove_wake_function+0x0/0x40
Sep 22 11:06:23 linuxha1 kernel:  [<c01381b5>] page_cache_readahead+0xd5/0x150
Sep 22 11:06:23 linuxha1 kernel:  [<c0118dc0>] autoremove_wake_function+0x0/0x40
Sep 22 11:06:23 linuxha1 kernel:  [<c0132baf>] do_generic_mapping_read+0x1cf/0x3a0
Sep 22 11:06:23 linuxha1 kernel:  [<c0132d80>] file_read_actor+0x0/0xd0
Sep 22 11:06:23 linuxha1 kernel:  [<c0133045>] __generic_file_aio_read+0x1f5/0x220
Sep 22 11:06:23 linuxha1 kernel:  [<c0132d80>] file_read_actor+0x0/0xd0
Sep 22 11:06:23 linuxha1 kernel:  [<c0133138>] generic_file_read+0x78/0xa0
Sep 22 11:06:23 linuxha1 kernel:  [<c0154092>] do_open+0xf2/0x3a0
Sep 22 11:06:23 linuxha1 kernel:  [<c0153bcb>] bdget+0xfb/0x110
Sep 22 11:06:23 linuxha1 kernel:  [<c01543e6>] blkdev_open+0x26/0x60
Sep 22 11:06:23 linuxha1 kernel:  [<c014bf2b>] dentry_open+0xeb/0x1c0
Sep 22 11:06:23 linuxha1 kernel:  [<c014ca7a>] vfs_read+0xaa/0xe0
Sep 22 11:06:23 linuxha1 kernel:  [<c0153830>] block_llseek+0x0/0xe0
Sep 22 11:06:23 linuxha1 kernel:  [<c014c8f5>] sys_llseek+0xb5/0xe0
Sep 22 11:06:23 linuxha1 kernel:  [<c014cc6f>] sys_read+0x2f/0x50
Sep 22 11:06:23 linuxha1 kernel:  [<c0108ff3>] syscall_call+0x7/0xb
Sep 22 11:06:23 linuxha1 kernel: Code: 0f 0b 20 02 05 64 2d c0 0f b7 82 9e 00 00 00 83 f8 20 7f 1d 

>>EIP; c0232115 <scsi_alloc_sgtable+15/f0>   <=====
Code;  c0232115 <scsi_alloc_sgtable+15/f0>
00000000 <_EIP>:
Code;  c0232115 <scsi_alloc_sgtable+15/f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0232117 <scsi_alloc_sgtable+17/f0>
   2:   20 02                     and    %al,(%edx)
Code;  c0232119 <scsi_alloc_sgtable+19/f0>
   4:   05 64 2d c0 0f            add    $0xfc02d64,%eax
Code;  c023211e <scsi_alloc_sgtable+1e/f0>
   9:   b7 82                     mov    $0x82,%bh
Code;  c0232120 <scsi_alloc_sgtable+20/f0>
   b:   9e                        sahf   
Code;  c0232121 <scsi_alloc_sgtable+21/f0>
   c:   00 00                     add    %al,(%eax)
Code;  c0232123 <scsi_alloc_sgtable+23/f0>
   e:   00 83 f8 20 7f 1d         add    %al,0x1d7f20f8(%ebx)


1 warning and 1 error issued.  Results may not be reliable.

Andy
