Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbTIOLPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 07:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTIOLPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 07:15:42 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:9348 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S261173AbTIOLPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 07:15:38 -0400
Date: Mon, 15 Sep 2003 13:15:33 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Oleg Drokin <green@namesys.com>
Cc: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 snapshot 20030905 [OOPS]
In-Reply-To: <20030826102233.GA14647@namesys.com>
Message-ID: <Pine.LNX.4.51.0309151249310.1934@dns.toxicfilms.tv>
References: <20030826102233.GA14647@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I compiled the kernel (2.6.0-test5) without key_large support
I attached a disk /dev/hda (I'm booting off /dev/hdb)

# mkfs.reiser4 /dev/hda1
Went ok

# mount -t reiser4 /dev/hda1 /1
And here's the output. It seems unsupported keys cause null pointer
dereference.

reiser4[mount(1504)]: get_ready_format40 (fs/reiser4/plugin/disk_format/disk_format40.c:229)[nikita-3228]:
WARNING: Key format mismatch. Only small keys are supported.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01d859e
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01d859e>]    Tainted: P
EFLAGS: 00010246
EIP is at unhash_unformatted_node_nolock+0x1d/0x6e
eax: 00000000   ebx: c262f800   ecx: c1060018   edx: 00000000
esi: c2684000   edi: 00000000   ebp: c1060018   esp: c2685c34
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 1504, threadinfo=c2684000 task=c5f36710)
Stack: c2684000 c2684000 c01d860d c262f800 c262f800 c01f8345 c262f800 c262f800
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
 [<c01d860d>] unhash_unformatted_jnode+0x1e/0x3e
 [<c01f8345>] reiser4_invalidatepage+0xe0/0x165
 [<c013c7c3>] do_invalidatepage+0x27/0x2b
 [<c013c894>] truncate_complete_page+0xcd/0xd2
 [<c013ca80>] truncate_inode_pages+0xcd/0x306
 [<c0168bf4>] wake_up_inode+0xf/0x26
 [<c016eca3>] write_inode_now+0x6a/0xa4
 [<c0168753>] generic_forget_inode+0x12e/0x141
 [<c01687e1>] iput+0x62/0x7c
 [<c01eef6c>] done_formatted_fake+0x3b/0x5b
 [<c01f6840>] reiser4_fill_super+0x343/0x606
 [<c0156154>] get_sb_bdev+0x127/0x159
 [<c016a11b>] alloc_vfsmnt+0x87/0xb6
 [<c01f6cf7>] reiser4_get_sb+0x2f/0x33
 [<c01f64fd>] reiser4_fill_super+0x0/0x606
 [<c0156386>] do_kern_mount+0x5f/0xd1
 [<c016b386>] do_add_mount+0x95/0x176
 [<c016b6b4>] do_mount+0x155/0x1a1
 [<c016b55b>] copy_mount_options+0xf4/0xf8
 [<c016baaa>] sys_mount+0xd7/0x135
 [<c0109089>] sysenter_past_esp+0x52/0x71

Code: 8b 02 85 c0 74 1c 0f b6 0d 01 06 43 c0 80 f9 02 74 04 0f 18
 <6>note: mount[1504] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c0118d8b>] schedule+0x3ed/0x3f2
 [<c013fc5b>] unmap_page_range+0x49/0x87
 [<c013fe5c>] unmap_vmas+0x1c3/0x231
 [<c0143fa0>] exit_mmap+0x7c/0x191
 [<c011a64d>] mmput+0x67/0xb6
 [<c011e366>] do_exit+0x12e/0x3d4
 [<c010a121>] do_divide_error+0x0/0xfb
 [<c0116b62>] do_page_fault+0x14a/0x44b
 [<c013ac01>] cache_alloc_refill+0xd0/0x209
 [<c01e46fd>] atom_init+0xc9/0xd7
 [<c01e4a05>] atom_begin_andlock+0xd7/0x15e
 [<c01e5aee>] try_capture_block+0x147/0x18f
 [<c0116a18>] do_page_fault+0x0/0x44b
 [<c0109ae5>] error_code+0x2d/0x38
 [<c01d859e>] unhash_unformatted_node_nolock+0x1d/0x6e
 [<c01d860d>] unhash_unformatted_jnode+0x1e/0x3e
 [<c01f8345>] reiser4_invalidatepage+0xe0/0x165
 [<c013c7c3>] do_invalidatepage+0x27/0x2b
 [<c013c894>] truncate_complete_page+0xcd/0xd2
 [<c013ca80>] truncate_inode_pages+0xcd/0x306
 [<c0168bf4>] wake_up_inode+0xf/0x26
 [<c016eca3>] write_inode_now+0x6a/0xa4
 [<c0168753>] generic_forget_inode+0x12e/0x141
 [<c01687e1>] iput+0x62/0x7c
 [<c01eef6c>] done_formatted_fake+0x3b/0x5b
 [<c01f6840>] reiser4_fill_super+0x343/0x606
 [<c0156154>] get_sb_bdev+0x127/0x159
 [<c016a11b>] alloc_vfsmnt+0x87/0xb6
 [<c01f6cf7>] reiser4_get_sb+0x2f/0x33
 [<c01f64fd>] reiser4_fill_super+0x0/0x606
 [<c0156386>] do_kern_mount+0x5f/0xd1
 [<c016b386>] do_add_mount+0x95/0x176
 [<c016b6b4>] do_mount+0x155/0x1a1
 [<c016b55b>] copy_mount_options+0xf4/0xf8
 [<c016baaa>] sys_mount+0xd7/0x135
 [<c0109089>] sysenter_past_esp+0x52/0x71

bad: scheduling while atomic!
Call Trace:
 [<c0118d8b>] schedule+0x3ed/0x3f2
 [<c013fc5b>] unmap_page_range+0x49/0x87
 [<c013fe5c>] unmap_vmas+0x1c3/0x231
 [<c0143fa0>] exit_mmap+0x7c/0x191
 [<c011a64d>] mmput+0x67/0xb6
 [<c011e366>] do_exit+0x12e/0x3d4
 [<c010a121>] do_divide_error+0x0/0xfb
 [<c0116b62>] do_page_fault+0x14a/0x44b
 [<c013ac01>] cache_alloc_refill+0xd0/0x209
 [<c01e46fd>] atom_init+0xc9/0xd7
 [<c01e4a05>] atom_begin_andlock+0xd7/0x15e
 [<c01e5aee>] try_capture_block+0x147/0x18f
 [<c0116a18>] do_page_fault+0x0/0x44b
 [<c0109ae5>] error_code+0x2d/0x38
 [<c01d859e>] unhash_unformatted_node_nolock+0x1d/0x6e
 [<c01d860d>] unhash_unformatted_jnode+0x1e/0x3e
 [<c01f8345>] reiser4_invalidatepage+0xe0/0x165
 [<c013c7c3>] do_invalidatepage+0x27/0x2b
 [<c013c894>] truncate_complete_page+0xcd/0xd2
 [<c013ca80>] truncate_inode_pages+0xcd/0x306
 [<c0168bf4>] wake_up_inode+0xf/0x26
 [<c016eca3>] write_inode_now+0x6a/0xa4
 [<c0168753>] generic_forget_inode+0x12e/0x141
 [<c01687e1>] iput+0x62/0x7c
 [<c01eef6c>] done_formatted_fake+0x3b/0x5b
 [<c01f6840>] reiser4_fill_super+0x343/0x606
 [<c0156154>] get_sb_bdev+0x127/0x159
 [<c016a11b>] alloc_vfsmnt+0x87/0xb6
 [<c01f6cf7>] reiser4_get_sb+0x2f/0x33
 [<c01f64fd>] reiser4_fill_super+0x0/0x606
 [<c0156386>] do_kern_mount+0x5f/0xd1
 [<c016b386>] do_add_mount+0x95/0x176
 [<c016b6b4>] do_mount+0x155/0x1a1
 [<c016b55b>] copy_mount_options+0xf4/0xf8
 [<c016baaa>] sys_mount+0xd7/0x135
 [<c0109089>] sysenter_past_esp+0x52/0x71

