Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTIHQrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTIHQrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:47:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:32960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262830AbTIHQrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:47:24 -0400
Date: Mon, 8 Sep 2003 09:48:02 -0700
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au, axboe@suse.de
Subject: Badness in as_completed_request warning
Message-ID: <20030908164802.GA13441@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm getting a "badness" warning from as_iosched.c, line 917.
This is on 2.6.0-test4-mm6, running on a 2 cpu x86.

The warning occurs when I run three or more instances of mkfs.ext2, where
each mkfs is running on its own disk.  If I run four or more mkfs's
on paritions all on the same disk I don't get this warning.
The more instances of mkfs I run (each on separate disks), the
more instances of this warning I receive.

The mkfs's all progress at the same rate. The warnings
occur as all mkfs's are "writing superblocks and filesystem
accounting information", near the end of the mkfs.

# Badness in as_completed_request at drivers/block/as-iosched.c:917

Call Trace:
 [<c0220d0d>] as_completed_request+0x1ad/0x1b0
 [<c021946f>] elv_completed_request+0x1f/0x30
 [<c021b87c>] __blk_put_request+0x3c/0xc0
 [<c021c83f>] end_that_request_last+0x5f/0xf0
 [<c0234d02>] DAC960_V2_ProcessCompletedCommand+0x172/0xf50
 [<c029712a>] ip_rcv+0x39a/0x520
 [<c011ebf4>] recalc_task_prio+0xb4/0x1f0
 [<c011f64b>] load_balance+0x1bb/0x430
 [<c0235bfd>] DAC960_LP_InterruptHandler+0x6d/0xb0
 [<c010e789>] handle_IRQ_event+0x49/0x80
 [<c010eb00>] do_IRQ+0xa0/0x150
 [<c010abd0>] default_idle+0x0/0x40
 [<c02f2f8c>] common_interrupt+0x18/0x20
 [<c010abd0>] default_idle+0x0/0x40
 [<c010abfd>] default_idle+0x2d/0x40
 [<c010ac96>] cpu_idle+0x46/0x50
 [<c0107000>] rest_init+0x0/0x60
 [<c039092d>] start_kernel+0x18d/0x1c0
 [<c03904a0>] unknown_bootoption+0x0/0x120

