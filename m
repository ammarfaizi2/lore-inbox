Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTJVMcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 08:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTJVMcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 08:32:41 -0400
Received: from linuxhacker.ru ([217.76.32.60]:33725 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263527AbTJVMch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 08:32:37 -0400
Date: Wed, 22 Oct 2003 15:32:09 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Badness in as_completed_request at drivers/block/as-iosched.c:919
Message-ID: <20031022123209.GA2652@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   2.6.0-test8 (current bk), greeted me with "Badness in as_completed_request"
   message on boot at smartd startup:
Oct 22 15:19:21 dol-guldur smartd[1225]: Device: /dev/sdb, is SMART capable. Adding to "monitor" list. 
Oct 22 15:19:21 dol-guldur kernel: Badness in as_completed_request at drivers/block/as-iosched.c:919
Oct 22 15:19:21 dol-guldur kernel: Call Trace:
Oct 22 15:19:21 dol-guldur kernel:  [<c01f7660>] as_completed_request+0x1d0/0x210
Oct 22 15:19:21 dol-guldur kernel:  [<c01efe30>] elv_completed_request+0x20/0x30
Oct 22 15:19:21 dol-guldur kernel:  [<c01f2246>] __blk_put_request+0x36/0xb0
Oct 22 15:19:21 dol-guldur smartd[1225]: Started monitoring 1 ATA and 2 SCSI devices 
Oct 22 15:19:22 dol-guldur kernel:  [<c01f3186>] end_that_request_last+0x56/0xe0
Oct 22 15:19:22 dol-guldur kernel:  [<c0215a74>] scsi_end_request+0xb4/0xe0
Oct 22 15:19:22 dol-guldur kernel:  [<c0215e28>] scsi_io_completion+0x1c8/0x4f0
Oct 22 15:19:22 dol-guldur kernel:  [<c0236149>] sd_rw_intr+0x89/0x270
Oct 22 15:19:22 dol-guldur kernel:  [<c0211024>] scsi_finish_command+0x84/0xf0
Oct 22 15:19:22 dol-guldur kernel:  [<c0210e0f>] scsi_softirq+0xdf/0x230
Oct 22 15:19:22 dol-guldur kernel:  [<c0124feb>] do_softirq+0xcb/0xd0
Oct 22 15:19:22 dol-guldur kernel:  [<c010bc05>] do_IRQ+0x105/0x130
Oct 22 15:19:22 dol-guldur kernel:  [<c0105000>] rest_init+0x0/0x60
Oct 22 15:19:22 dol-guldur kernel:  [<c0109f20>] common_interrupt+0x18/0x20
Oct 22 15:19:22 dol-guldur kernel:  [<c0107210>] default_idle+0x0/0x40
Oct 22 15:19:22 dol-guldur kernel:  [<c0105000>] rest_init+0x0/0x60
Oct 22 15:19:22 dol-guldur kernel:  [<c010723f>] default_idle+0x2f/0x40
Oct 22 15:19:22 dol-guldur kernel:  [<c01072cb>] cpu_idle+0x3b/0x50
Oct 22 15:19:22 dol-guldur kernel:  [<c0330947>] start_kernel+0x167/0x180
Oct 22 15:19:22 dol-guldur kernel:  [<c0330510>] unknown_bootoption+0x0/0x110
Oct 22 15:19:22 dol-guldur kernel: 
Oct 22 15:19:22 dol-guldur kernel: Badness in as_completed_request at drivers/block/as-iosched.c:919
Oct 22 15:19:22 dol-guldur kernel: Call Trace:
Oct 22 15:19:22 dol-guldur kernel:  [<c01f7660>] as_completed_request+0x1d0/0x210
Oct 22 15:19:22 dol-guldur kernel:  [<c01efe30>] elv_completed_request+0x20/0x30
Oct 22 15:19:22 dol-guldur kernel:  [<c01f2246>] __blk_put_request+0x36/0xb0
Oct 22 15:19:22 dol-guldur smartd[1225]: Device: /dev/sdb, SMART Failure: DATA CHANNEL IMPENDING FAILURE DATA ERROR RATE TOO HIGH 
Oct 22 15:19:22 dol-guldur kernel:  [<c01f3186>] end_that_request_last+0x56/0xe0
Oct 22 15:19:22 dol-guldur kernel:  [<c0215a74>] scsi_end_request+0xb4/0xe0
Oct 22 15:19:22 dol-guldur kernel:  [<c0215e28>] scsi_io_completion+0x1c8/0x4f0
Oct 22 15:19:22 dol-guldur kernel:  [<c0236149>] sd_rw_intr+0x89/0x270
Oct 22 15:19:22 dol-guldur kernel:  [<c0211024>] scsi_finish_command+0x84/0xf0
Oct 22 15:19:22 dol-guldur kernel:  [<c0210e0f>] scsi_softirq+0xdf/0x230
Oct 22 15:19:22 dol-guldur kernel:  [<c0124feb>] do_softirq+0xcb/0xd0
Oct 22 15:19:22 dol-guldur kernel:  [<c010bc05>] do_IRQ+0x105/0x130
Oct 22 15:19:22 dol-guldur kernel:  [<c0105000>] rest_init+0x0/0x60
Oct 22 15:19:22 dol-guldur kernel:  [<c0109f20>] common_interrupt+0x18/0x20
Oct 22 15:19:22 dol-guldur kernel:  [<c0107210>] default_idle+0x0/0x40
Oct 22 15:19:22 dol-guldur kernel:  [<c0105000>] rest_init+0x0/0x60
Oct 22 15:19:22 dol-guldur kernel:  [<c010723f>] default_idle+0x2f/0x40
Oct 22 15:19:22 dol-guldur kernel:  [<c01072cb>] cpu_idle+0x3b/0x50
Oct 22 15:19:22 dol-guldur kernel:  [<c0330947>] start_kernel+0x167/0x180
Oct 22 15:19:22 dol-guldur kernel:  [<c0330510>] unknown_bootoption+0x0/0x110
Oct 22 15:19:22 dol-guldur kernel: 
Oct 22 15:19:23 dol-guldur smartd: smartd startup succeeded

/dev/sdb is on aic7xxx-compatible scsi controller.

2.6.0-test7 have not shown anything like this.
Hope that helps

Bye,
    Oleg
