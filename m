Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbTIDRQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbTIDRQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:16:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:2738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265256AbTIDRPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:15:49 -0400
Date: Thu, 4 Sep 2003 10:16:26 -0700
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: disk I/O hang in 2.6.0-test4-mm5
Message-ID: <20030904171626.GA26054@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing a mkfs.ext2 that never completes under 2.6.0-test4-mm5.
I ran 4 mkfs.ext2's concurrntly, each on a seperate partition on the
same disk.  Three of the completed.  Here's the sysrq stack trace from
the one that didn't.

This doesn't occur on mm4.

mkfs.ext2     D 00000000 16474  16431                     (NOTLB)
f19cbef0 00000086 f6200ce0 00000000 00000003 c0127852 00000000 c3671bc0
       c3671bc0 0000000d f19cbf28 f19cbefc c011fa08 c184ab20 c360d09c c014007c
       c184ab20 00000000 f7a8a040 c0120d70 f19cbf34 f19cbf34 f7a8a040 ffffffff
Call Trace:
 [<c0127852>] tasklet_action+0x72/0xd0
 [<c011fa08>] io_schedule+0x28/0x40
 [<c014007c>] wait_on_page_bit_wq+0xcc/0x100
 [<c0120d70>] autoremove_wake_function+0x0/0x50
 [<c0120d70>] autoremove_wake_function+0x0/0x50
 [<c013fda3>] filemap_fdatawait+0x1e3/0x240
 [<c0162819>] sync_blockdev+0x39/0x50
 [<c0162b52>] sys_fsync+0xc2/0x100
 [<c03106ea>] sysenter_past_esp+0x43/0x65


This is on a system with a DAC960 driver.  But we've seen it here
on a system with scsi disk as well.  



