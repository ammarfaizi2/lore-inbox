Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbTDIBse (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTDIBse (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:48:34 -0400
Received: from miranda.zianet.com ([216.234.192.169]:18955 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S261945AbTDIBsc (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 21:48:32 -0400
Subject: Re: 2.5.67 - reiserfs go boom.
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030409011802.GD25834@suse.de>
References: <20030409011802.GD25834@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1049853413.31551.27.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 08 Apr 2003 19:56:53 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-08 at 19:18, Dave Jones wrote:
> Whilst running fsx.. (Though fsx didn't trigger any error,
> and is still running)..
> 
> 		Dave
> 
> buffer layer error at fs/buffer.c:127
> Call Trace:
>  [<c016d260>] __wait_on_buffer+0xd0/0xe0
>  [<c0121760>] autoremove_wake_function+0x0/0x50
>  [<c0121760>] autoremove_wake_function+0x0/0x50
>  [<c02886c8>] reiserfs_unmap_buffer+0x68/0xa0
>  [<c0288768>] unmap_buffers+0x68/0x70
>  [<c0288948>] indirect2direct+0x1d8/0x2b0
>  [<c0286584>] reiserfs_cut_from_item+0x3d4/0x4e0
>  [<c0286955>] reiserfs_do_truncate+0x265/0x520
>  [<c0170e12>] block_prepare_write+0x32/0x50
>  [<c027446a>] reiserfs_truncate_file+0x15a/0x3b0
>  [<c028cfc7>] journal_end+0x27/0x30
>  [<c0275f2c>] reiserfs_file_release+0x39c/0x600
>  [<c014c9bb>] check_poison_obj+0x3b/0x1b0
>  [<c014e934>] kmem_cache_alloc+0x124/0x170
>  [<c016c711>] get_empty_filp+0x51/0x100
>  [<c016c9a1>] __fput+0xf1/0x100
>  [<c016ab3a>] filp_close+0x15a/0x230
>  [<c01833a3>] do_fcntl+0xe3/0x1c0
>  [<c0182ebc>] sys_dup2+0xec/0x130
>  [<c010a457>] syscall_call+0x7/0xb
> 

Gee, that looks remarkably similar to what I was getting
with ext3.  This happened on every boot with 2.5.67 with
the base distro being Mandrake 9.1.  Then, I replaced LM 9.1
with Redhat 9 and I never saw this again with 2.5.67.


buffer layer error at fs/buffer.c:127
Call Trace:
 [<c0148170>] __wait_on_buffer+0xe0/0xf0
 [<c0117010>] autoremove_wake_function+0x0/0x50
 [<c0117010>] autoremove_wake_function+0x0/0x50
 [<c014a0dd>] __block_prepare_write+0x13d/0x490
 [<c01821b0>] ext3_mark_inode_dirty+0x50/0x60
 [<c018d1ba>] start_this_handle+0x9a/0x1c0
 [<c014acc4>] block_prepare_write+0x34/0x50
 [<c017f2b0>] ext3_get_block+0x0/0xb0
 [<c017f962>] ext3_prepare_write+0x92/0x1b0
 [<c017f2b0>] ext3_get_block+0x0/0xb0
 [<c012e4d9>] generic_file_aio_write_nolock+0x359/0xa10
 [<c01496bc>] __find_get_block+0x7c/0x120
 [<c01815f3>] ext3_get_inode_loc+0xf3/0x1a0
 [<c0181908>] ext3_read_inode+0x1f8/0x360
 [<c012eca1>] generic_file_aio_write+0x71/0x90
 [<c017cf14>] ext3_file_write+0x44/0xe0
 [<c0146deb>] do_sync_write+0x8b/0xc0
 [<c0154108>] link_path_walk+0x608/0x900
 [<c018c85f>] ext3_permission+0x1f/0x30
 [<c015359a>] permission+0x3a/0x40
 [<c0147b15>] get_empty_filp+0x75/0xf0
 [<c0154d1d>] open_namei+0x9d/0x420
 [<c01460de>] dentry_open+0x16e/0x180
 [<c0145f68>] filp_open+0x68/0x70
 [<c0146ede>] vfs_write+0xbe/0x130
 [<c0146720>] generic_file_llseek+0x0/0xd0
 [<c0146fee>] sys_write+0x3e/0x60
 [<c01092bb>] syscall_call+0x7/0xb

Steven

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



