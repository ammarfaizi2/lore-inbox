Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbTIMRE2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTIMRE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:04:28 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:54449 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S261443AbTIMRE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:04:26 -0400
Subject: Re: Oops when finishing raidreconf on 2.6.0-test5
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1063472663.29049.6.camel@clubneon.clubneon.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 13 Sep 2003 13:04:23 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19yDow-0004F6-D6*hejstOYKpd.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, it took some time, but here is what I've tested, all on
2.6.0-test5 now:

First, by mistake, raidreconf on a started array, gets all the way
through, but when it discovers at the end that md0 already has disks, it
exits gracefully, no oops.

Second, raidreconf still triggers the oops in -test5 when expanding a 4
disk RAID5 to 5 disks.

Third, mkraid completes without any trouble when building a new 4 disk
array.

Last, even in a kernel built without preempt support (I don't know why I
thought that was the problem initially, I must have misread something),
raidreconf still oops the machine when attempting to write the new
superblocks.

The here is some of the the output from the oops, copied by hand, as it
hangs the machine solid, and I don't have anything else to capture it
with:

EIP is at blk_read_rq_sectors+0x50/0xd0

Process md0_raid5

Stack trace:

__end_that_request_first+0x127/0x230
scsi_end_request+0x3f/0xf0
scsi_io_completion+0x1bb/0x470
sym_xpt_done+0x3b/0x50
sd_rw_intr+0x5a/0x1d0
scsi_finish_command+0x76/0xc0
run_timer_softirq+0x10a/0x1b0
scsi_softirq+0x99/0xa0
do_IRQ+0xfe/0x130
common_interupt+0x18/0x20
xor_p5_mmx_5+0x6b/0x180
xor_block+0x5b/0xc0
compute_parity+0x15d/0x340
default_wake_function+0x0/0x30
handle_stripe+0x95f/0xcc0
__wake_up_common+0x31/0x60
raid5d+07d/0x140
default_wake_function+0x0/0x30
md_thread+0x0/0x190
kernel_thread_helper+0x5/0x10


If you need anything else, I can reproduce this at will.  It just takes
about 30 minutes to reconf to 5 9GB drives.

-- 
Chris

