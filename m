Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTIIGMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 02:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263956AbTIIGM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 02:12:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:55193 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263963AbTIIGLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 02:11:48 -0400
Date: Mon, 8 Sep 2003 23:12:14 -0700
From: Dave Olien <dmo@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Badness in as_completed_request warning
Message-ID: <20030909061214.GA15840@osdl.org>
References: <20030908164802.GA13441@osdl.org> <3F5D4BC9.6020708@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <3F5D4BC9.6020708@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2003 at 01:40:57PM +1000, Nick Piggin wrote:
> Hi Dave,
> Can you try 2.6.0-test5 with the following patch please. Thanks
> 

I applied this patch, and gave it a shot.  It seems to have made things
worse.  Instead of the warnings occurring only at the end of the mkfs
runs, they now occur pretty much constantly, and it finally ends
with an Bug_On.  Attached is the console output.  There are 20 
occurrances of Badness in as-iosched.c line 1020.  There is one
occurrance of Badness in as-iosched.c line 1025.  The Bug_On() is in
as-iosched.c line 1243.

Console output is attached.

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=typescript

Linux version 2.6.0-test5-NP (dmo@cl045) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP Tue Sep 9 02:52:46 PDT 2003
[root@cl045 root]# Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1025
Call Trace:
 [<c021b52c>] as_remove_dispatched_request+0x6c/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1020
Call Trace:
 [<c021b582>] as_remove_dispatched_request+0xc2/0x100
 [<c02139a9>] elv_remove_request+0x29/0x40
 [<c022ca2a>] DAC960_ProcessRequest+0x16a/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

------------[ cut here ]------------
kernel BUG at drivers/block/as-iosched.c:1243!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<c021ba76>]    Not tainted
EFLAGS: 00010046
EIP is at as_dispatch_request+0x236/0x2f0
eax: 00000000   ebx: dfd3cbc0   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000001   ebp: 00000000   esp: d9559a38
ds: 007b   es: 007b   ss: 0068
Process mkfs.ext2 (pid: 1273, threadinfo=d9558000 task=dd5cece0)
Stack: dfd3cbc0 d47b9c60 dff98000 dfd06f80 c0228423 dfd3cbc0 00000000 c1731a00 
       d9559af8 c021bb68 dfd3cbc0 00000039 c1731a00 c0213886 c1731a00 c1770890 
       dff98000 00000039 dff98000 c022c8f8 c1731a00 d46c55d8 c1770920 0021bb68 
Call Trace:
 [<c0228423>] DAC960_LP_QueueCommand+0x43/0xb0
 [<c021bb68>] as_next_request+0x38/0x50
 [<c0213886>] elv_next_request+0x16/0x110
 [<c022c8f8>] DAC960_ProcessRequest+0x38/0x190
 [<c022cb2b>] DAC960_RequestFunction+0x2b/0x40
 [<c02152ff>] generic_unplug_device+0x6f/0x80
 [<c0215bac>] get_request_wait+0x7c/0x100
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0213ad1>] elv_may_queue+0x21/0x30
 [<c0120690>] autoremove_wake_function+0x0/0x50
 [<c0216315>] __make_request+0xd5/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013f1a2>] mempool_free+0x42/0x80
 [<c028fc1a>] ip_rcv+0x39a/0x520
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c010d3d9>] handle_IRQ_event+0x49/0x80
 [<c01f1265>] tty_write+0x1a5/0x2c0
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c015fec0>] block_llseek+0x0/0x100
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Code: 0f 0b db 04 c9 be 30 c0 eb c7 8b 43 48 e9 61 ff ff ff 0f 0b 


--2oS5YaxWCcQjTEyO--
