Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbTIPITW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 04:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbTIPITW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 04:19:22 -0400
Received: from smtp2.libero.it ([193.70.192.52]:15050 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S261208AbTIPITT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 04:19:19 -0400
Date: Tue, 16 Sep 2003 10:19:17 +0200
From: Ludovico Gardenghi <dunadan@libero.it>
To: linux-kernel@vger.kernel.org
Subject: Badness in as_completed_request in 2.6.0-test5-bk3
Message-ID: <20030916081917.GA2960@ripieno.somiere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm very sorry if this message appears 2 or 3 times, but I sent it once
with a @despammed.com address; their DNS appears to be down in this
period so vger.kernel.org didn't accept my mail.]

Hello.

I've read about this error and that it should have been patched in
2.6.0-test5-bk3.

I tried it because I got a lot of them with 2.6.0-test5 while removing
lots of files (i.e. while starting sn at boot time), but I got the same error
messages with 2.6.0-test5-bk3; moreover, i had also some "attempt to
access beyond end of device" errors while trying to read a file from the
same partition. Here are the messages:

Badness in as_completed_request at drivers/block/as-iosched.c:906
Call Trace:
 [as_completed_request+413/416] as_completed_request+0x19d/0x1a0
 [elv_completed_request+31/48] elv_completed_request+0x1f/0x30
 [__blk_put_request+60/192] __blk_put_request+0x3c/0xc0
 [end_that_request_last+82/160] end_that_request_last+0x52/0xa0
 [ide_end_request+219/336] ide_end_request+0xdb/0x150
 [ide_dmaq_complete+85/208] ide_dmaq_complete+0x55/0xd0
 [ide_dmaq_intr+59/144] ide_dmaq_intr+0x3b/0x90
 [ide_intr+234/400] ide_intr+0xea/0x190
 [ide_dmaq_intr+0/144] ide_dmaq_intr+0x0/0x90
 [handle_IRQ_event+58/112] handle_IRQ_event+0x3a/0x70
 [do_IRQ+145/304] do_IRQ+0x91/0x130
 [rest_init+0/96] _stext+0x0/0x60
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [rest_init+0/96] _stext+0x0/0x60
 [default_idle+35/48] default_idle+0x23/0x30
 [cpu_idle+44/64] cpu_idle+0x2c/0x40
 [start_kernel+337/352] start_kernel+0x151/0x160
 [unknown_bootoption+0/256] unknown_bootoption+0x0/0x100

Badness in as_completed_request at drivers/block/as-iosched.c:906
Call Trace:
 [as_completed_request+413/416] as_completed_request+0x19d/0x1a0
 [elv_completed_request+31/48] elv_completed_request+0x1f/0x30
 [__blk_put_request+60/192] __blk_put_request+0x3c/0xc0
 [end_that_request_last+82/160] end_that_request_last+0x52/0xa0
 [ide_end_request+219/336] ide_end_request+0xdb/0x150
 [ide_dmaq_complete+85/208] ide_dmaq_complete+0x55/0xd0
 [ide_dmaq_intr+59/144] ide_dmaq_intr+0x3b/0x90
 [ide_intr+234/400] ide_intr+0xea/0x190
 [ide_dmaq_intr+0/144] ide_dmaq_intr+0x0/0x90
 [handle_IRQ_event+58/112] handle_IRQ_event+0x3a/0x70
 [do_IRQ+145/304] do_IRQ+0x91/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [journal_add_journal_head+228/256] journal_add_journal_head+0xe4/0x100
 [journal_get_undo_access+21/320] journal_get_undo_access+0x15/0x140
 [ext3_free_blocks+432/1264] ext3_free_blocks+0x1b0/0x4f0
 [ext3_free_data+152/336] ext3_free_data+0x98/0x150
 [ext3_truncate+1444/1536] ext3_truncate+0x5a4/0x600
 [ext3_mark_iloc_dirty+40/64] ext3_mark_iloc_dirty+0x28/0x40
 [journal_start+169/208] journal_start+0xa9/0xd0
 [__ext3_journal_stop+36/80] __ext3_journal_stop+0x24/0x50
 [start_transaction+35/96] start_transaction+0x23/0x60
 [ext3_delete_inode+198/272] ext3_delete_inode+0xc6/0x110
 [ext3_put_inode+19/48] ext3_put_inode+0x13/0x30
 [ext3_delete_inode+0/272] ext3_delete_inode+0x0/0x110
 [generic_delete_inode+106/272] generic_delete_inode+0x6a/0x110
 [ext3_put_inode+19/48] ext3_put_inode+0x13/0x30
 [iput+98/128] iput+0x62/0x80
 [sys_unlink+272/320] sys_unlink+0x110/0x140
 [syscall_call+7/11] syscall_call+0x7/0xb


And:

attempt to access beyond end of device
hda7: rw=0, want=3699666016, limit=9992367
attempt to access beyond end of device
hda7: rw=0, want=1817182208, limit=9992367
attempt to access beyond end of device
hda7: rw=0, want=4294958280, limit=9992367
attempt to access beyond end of device
hda7: rw=0, want=1487072352, limit=9992367
attempt to access beyond end of device
hda7: rw=0, want=1242071648, limit=9992367
attempt to access beyond end of device
hda7: rw=0, want=4294960784, limit=9992367
attempt to access beyond end of device
hda7: rw=0, want=3706055712, limit=9992367
[...]

My mainboard has a VIA controller (Asus A7V8X) and the hard disk is a IBM
180GXP with Tagged Command Queueing enabled and a default queue length
of 8. I haven't tried disabling TCQ, but it seemed to work up to
2.6.0-test4 (although with 2.6.0-test4 I experienced some data
"swapping" between files while accessing lots of them concurrently).

Ludovico
-- 
<dunadan@libero.it>              garden (irc.freenode.net) ICQ: 64483080
GPG ID: 07F89BB8              Jabber: garden@jabber.students.cs.unibo.it
-- This is signature nr. 1226
