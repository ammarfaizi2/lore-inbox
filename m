Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUI0IB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUI0IB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 04:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUI0IB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 04:01:26 -0400
Received: from port-222-152-48-85.fastadsl.net.nz ([222.152.48.85]:3968 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S266223AbUI0IBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 04:01:24 -0400
Message-Id: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Mon, 27 Sep 2004 20:01:28 +1200
To: linux-kernel@vger.kernel.org
From: Reuben Farrelly <reuben-lkml@reub.net>
Subject: Stack traces in 2.6.9-rc2-mm4
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since upgrading from -mm3 to -mm4, I'm now getting messages like this 
logged every second or so:

Sep 27 18:28:06 tornado kernel: using smp_processor_id() in preemptible 
code: swapper/1
Sep 27 18:28:06 tornado kernel:  [<c0104dce>] dump_stack+0x17/0x19
Sep 27 18:28:06 tornado kernel:  [<c0117fc6>] smp_processor_id+0x80/0x86
Sep 27 18:28:06 tornado kernel:  [<c0282bf3>] make_request+0x174/0x2e7
Sep 27 18:28:06 tornado kernel:  [<c02073dd>] generic_make_request+0xda/0x190
Sep 27 18:28:06 tornado kernel:  [<c02074ee>] submit_bio+0x5b/0xf5
Sep 27 18:28:06 tornado kernel:  [<c015673b>] submit_bh+0xd2/0x11b
Sep 27 18:28:06 tornado kernel:  [<c0156807>] ll_rw_block+0x83/0x85
Sep 27 18:28:06 tornado kernel:  [<c019e4f8>] search_by_key+0xeb/0x1158
Sep 27 18:28:06 tornado kernel:  [<c018c546>] 
reiserfs_read_locked_inode+0x5f/0xfe
Sep 27 18:28:06 tornado kernel:  [<c018c685>] reiserfs_iget+0x79/0x82
Sep 27 18:28:06 tornado kernel:  [<c0187bc4>] reiserfs_lookup+0xf6/0x147
Sep 27 18:28:06 tornado kernel:  [<c015e72c>] real_lookup+0xbe/0xe2
Sep 27 18:28:06 tornado kernel:  [<c015e94c>] do_lookup+0x6a/0x75
Sep 27 18:28:06 tornado kernel:  [<c015eae0>] link_path_walk+0x189/0xd3a
Sep 27 18:28:06 tornado kernel:  [<c015f92d>] path_lookup+0x97/0x157
Sep 27 18:28:06 tornado kernel:  [<c0160029>] open_namei+0x87/0x60a
Sep 27 18:28:06 tornado kernel:  [<c01519b9>] filp_open+0x29/0x48
Sep 27 18:28:06 tornado kernel:  [<c0151dca>] sys_open+0x31/0x61
Sep 27 18:28:06 tornado kernel:  [<c010053b>] init+0xd3/0x185
Sep 27 18:28:06 tornado kernel:  [<c01022e9>] kernel_thread_helper+0x5/0xb

The traces all look very similar, viz
Sep 27 18:28:10 tornado kernel: using smp_processor_id() in preemptible 
code: initlog/1449
Sep 27 18:28:10 tornado kernel: using smp_processor_id() in preemptible 
code: pdflush/45
Sep 27 18:28:19 tornado kernel: using smp_processor_id() in preemptible 
code: spamd/2146

Is there a fix to shut this all up or a suggested patch to revert?

Box is a P4 Intel 2.8Ghz single processor, SMP/HT with PREEMPT on..

Thanks,
Reuben

