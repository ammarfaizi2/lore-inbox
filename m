Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVKMS6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVKMS6d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 13:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVKMS6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 13:58:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32395 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbVKMS6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 13:58:32 -0500
Date: Sun, 13 Nov 2005 10:58:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [partial patch] 2.6.14-mm2 bugs and fixes
Message-Id: <20051113105814.3d332bd5.akpm@osdl.org>
In-Reply-To: <200511131441.18443.bero@arklinux.org>
References: <200511131441.18443.bero@arklinux.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> Some problems with 2.6.14-mm2, and fixes for some:
> 
> ...
> There's another problem for which I haven't found a fix yet:
> With 2.6.14-mm1 and 2.6.14-mm2 [on an x86 box], I'm getting a number of bad page errors (system seems to work fine nevertheless):
> Bad page state at prep_new_page (in process 'tar', page c10000a0)
> flags:0x00000400 mapping:00000000 mapcount:0 count:0
> Backtrace:
> [<c013f85b>] bad_page+0x7b/0xc0
> [<c01400a5>] buffered_rmqueue+0x115/0x2c0
> [<c01ae3fc>] journal_stop+0x11c/0x1e0
> [<c0140349>] __alloc_pages+0xf9/0x470
> [<c013b0d0>] find_lock_page+0x30/0x90
> [<c013b9f8>] generic_file_buffered_write+0x178/0x6b0
> [<c01a0ca9>] add_dirent_to_buf+0x159/0x380
> [<c011ec5e>] current_fs_time+0x4e/0x60
> [<c0175aeb>] file_update_time+0x4b/0xc0
> [<c013c219>] __generic_file_aio_write_nolock+0x2e9/0x520
> [<c019c012>] ext3_mark_iloc_dirty+0x1b2/0x3e0
> [<c013d878>] generic_file_aio_write+0x78/0xf0
> [<c019a864>] ext3_file_write+0x44/0xd0
> [<c015a610>] do_sync_write+0xd0/0x110
> [<c012d480>] autoremove_wake_function+0x0/0x60
> [<c0167ca7>] pipe_read+0x37/0x40
> [<c015b175>] vfs_write+0xd5/0x1b0
> [<c015b86b>] sys_write+0x4b/0x80
> [<c0102f0f>] sysenter_past_esp+0x54/0x75
> Trying to fix it up, but a reboot is needed
> Bad page state at prep_new_page (in process 'bzip2', page c10000c0)
> flags:0x00000400 mapping:00000000 mapcount:0 count:0
> Backtrace:
> [<c013f85b>] bad_page+0x7b/0xc0
> [<c01400a5>] buffered_rmqueue+0x115/0x2c0
> [<c0140349>] __alloc_pages+0xf9/0x470
> [<c0175aeb>] file_update_time+0x4b/0xc0
> [<c0167661>] pipe_writev+0x331/0x590
> [<c015b305>] vfs_read+0xb5/0x1b0
> [<c01678f7>] pipe_write+0x37/0x40
> [<c015b175>] vfs_write+0xd5/0x1b0
> [<c015b86b>] sys_write+0x4b/0x80
> [<c0102f0f>] sysenter_past_esp+0x54/0x75
> Trying to fix it up, but a reboot is needed
> 
> So far I've seen those only while unpacking large tar.bz2 files (such as linux-2.6.14.tar.bz2).

That's PG_reserved.  I assume someone is freeing up pages which have
PG_reserved set.  Do you get any traces on the __free_pages_ok() path so we
can see where they're coming from?


