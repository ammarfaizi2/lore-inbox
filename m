Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbUCSAWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbUCRXyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:54:31 -0500
Received: from [62.81.186.18] ([62.81.186.18]:62343 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S263297AbUCRXUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:20:10 -0500
Date: Fri, 19 Mar 2004 00:19:57 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Jens Axboe <axboe@suse.de>
Cc: Eric Valette <eric.valette@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2 : Badness in elv_requeue_request at drivers/block/elevator.c:157
Message-ID: <20040318231957.GA3867@werewolf.able.es>
References: <40596FC5.3080703@free.fr> <20040318100222.GE22234@suse.de> <20040318100606.GG22234@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040318100606.GG22234@suse.de> (from axboe@suse.de on Thu, Mar 18, 2004 at 11:06:06 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.18, Jens Axboe wrote:
> On Thu, Mar 18 2004, Jens Axboe wrote:
> > On Thu, Mar 18 2004, Eric Valette wrote:
> > > I have this message two times as I have two adaptec controllers...
> > > 

I have a similar but different place oops. My box was dog slow with -mm2,
and syslog was flooded with:

Mar 18 20:00:00 werewolf kernel: Badness in elv_remove_request at drivers/block/elevator.c:249
Mar 18 20:00:00 werewolf kernel: Call Trace:
Mar 18 20:00:00 werewolf kernel:  [elv_remove_request+156/160] elv_remove_request+0x9c/0xa0
Mar 18 20:00:00 werewolf kernel:  [<c020001c>] elv_remove_request+0x9c/0xa0
Mar 18 20:00:00 werewolf kernel:  [scsi_request_fn+826/1088] scsi_request_fn+0x33a/0x440
Mar 18 20:00:00 werewolf kernel:  [<c022af8a>] scsi_request_fn+0x33a/0x440
Mar 18 20:00:00 werewolf kernel:  [generic_unplug_device+94/112] generic_unplug_device+0x5e/0x70
Mar 18 20:00:00 werewolf kernel:  [<c0201a2e>] generic_unplug_device+0x5e/0x70
Mar 18 20:00:00 werewolf kernel:  [blk_backing_dev_unplug+18/32] blk_backing_dev_unplug+0x12/0x20
Mar 18 20:00:00 werewolf kernel:  [<c0201a62>] blk_backing_dev_unplug+0x12/0x20
Mar 18 20:00:00 werewolf kernel:  [block_sync_page+34/48] block_sync_page+0x22/0x30
Mar 18 20:00:00 werewolf kernel:  [<c015fe22>] block_sync_page+0x22/0x30
Mar 18 20:00:00 werewolf kernel:  [wait_on_page_bit+195/208] wait_on_page_bit+0xc3/0xd0
Mar 18 20:00:00 werewolf kernel:  [<c013be13>] wait_on_page_bit+0xc3/0xd0
Mar 18 20:00:00 werewolf kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Mar 18 20:00:00 werewolf kernel:  [<c011ede0>] autoremove_wake_function+0x0/0x40
Mar 18 20:00:00 werewolf kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Mar 18 20:00:00 werewolf kernel:  [<c011ede0>] autoremove_wake_function+0x0/0x40
Mar 18 20:00:00 werewolf kernel:  [mpage_bio_submit+25/32] mpage_bio_submit+0x19/0x20
Mar 18 20:00:00 werewolf kernel:  [<c017da69>] mpage_bio_submit+0x19/0x20
Mar 18 20:00:00 werewolf kernel:  [do_generic_mapping_read+840/976] do_generic_mapping_read+0x348/0x3d0
Mar 18 20:00:00 werewolf kernel:  [<c013c7a8>] do_generic_mapping_read+0x348/0x3d0
Mar 18 20:00:00 werewolf kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Mar 18 20:00:00 werewolf kernel:  [<c013c830>] file_read_actor+0x0/0xf0
Mar 18 20:00:00 werewolf kernel:  [__generic_file_aio_read+450/560] __generic_file_aio_read+0x1c2/0x230
Mar 18 20:00:00 werewolf kernel:  [<c013cae2>] __generic_file_aio_read+0x1c2/0x230
Mar 18 20:00:00 werewolf kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Mar 18 20:00:00 werewolf kernel:  [<c013c830>] file_read_actor+0x0/0xf0
Mar 18 20:00:00 werewolf kernel:  [recalc_task_prio+219/464] recalc_task_prio+0xdb/0x1d0
Mar 18 20:00:00 werewolf kernel:  [<c0119a4b>] recalc_task_prio+0xdb/0x1d0
Mar 18 20:00:00 werewolf kernel:  [generic_file_aio_read+71/112] generic_file_aio_read+0x47/0x70
Mar 18 20:00:00 werewolf kernel:  [<c013cb97>] generic_file_aio_read+0x47/0x70
Mar 18 20:00:00 werewolf kernel:  [do_sync_read+133/224] do_sync_read+0x85/0xe0
Mar 18 20:00:00 werewolf kernel:  [<c015ac65>] do_sync_read+0x85/0xe0
Mar 18 20:00:00 werewolf kernel:  [schedule+535/1984] schedule+0x217/0x7c0
Mar 18 20:00:00 werewolf kernel:  [<c011c2c7>] schedule+0x217/0x7c0
Mar 18 20:00:00 werewolf kernel:  [inode_update_time+179/192] inode_update_time+0xb3/0xc0
Mar 18 20:00:00 werewolf kernel:  [<c0176893>] inode_update_time+0xb3/0xc0
Mar 18 20:00:00 werewolf kernel:  [pipe_writev+603/864] pipe_writev+0x25b/0x360
Mar 18 20:00:00 werewolf kernel:  [<c016803b>] pipe_writev+0x25b/0x360
Mar 18 20:00:00 werewolf kernel:  [vfs_read+254/304] vfs_read+0xfe/0x130
Mar 18 20:00:00 werewolf kernel:  [<c015adbe>] vfs_read+0xfe/0x130
Mar 18 20:00:00 werewolf kernel:  [vfs_write+165/304] vfs_write+0xa5/0x130
Mar 18 20:00:00 werewolf kernel:  [<c015af75>] vfs_write+0xa5/0x130
Mar 18 20:00:00 werewolf kernel:  [sys_pread64+76/112] sys_pread64+0x4c/0x70
Mar 18 20:00:00 werewolf kernel:  [<c015b10c>] sys_pread64+0x4c/0x70
Mar 18 20:00:00 werewolf kernel:  [sysenter_past_esp+67/101] sysenter_past_esp+0x43/0x65
Mar 18 20:00:00 werewolf kernel:  [<c02ba022>] sysenter_past_esp+0x43/0x65

Just to check it is caused by the same bug or to give some other clue...

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Community) for i586
Linux 2.6.5-rc1-jam1 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.4mdk))
