Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267249AbUHIVjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267249AbUHIVjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUHIVig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:38:36 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:41961 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267249AbUHIVfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:35:20 -0400
Message-ID: <41177F20.5070308@us.ibm.com>
Date: Mon, 09 Aug 2004 06:41:52 -0700
From: Janet Morgan <janetmor@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.8-rc3-mm2:  Debug: sleeping function called from invalid context
 at mm/mempool.c:197
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the msg below while running on 2.6.8-rc3-mm2, but not on the plain 
rc3 tree;
ditto for rc1-mm1 vs rc1, which is as far back as I've gone so far.

I'm using QLogic QLA2200 adapters and both ext2/ext3 filesystems.  
The problem is very recreatable for me -- I pretty much just open a 
large file on one
of the qlogic-attached devices.

I tried backing out bk-scsi.patch for the heck of it, but I still see 
the problem.

Aug  9 10:33:43 elm3b81 kernel: Debug: sleeping function called from 
invalid context at mm/mempool.c:197
Aug  9 10:33:43 elm3b81 kernel: in_atomic():1, irqs_disabled():0
Aug  9 10:33:43 elm3b81 kernel:  [<c0105f4e>] dump_stack+0x1e/0x30
Aug  9 10:33:43 elm3b81 kernel:  [<c011d2a9>] __might_sleep+0x99/0xb0
Aug  9 10:33:43 elm3b81 kernel:  [<c013dadb>] mempool_alloc+0x14b/0x150
Aug  9 10:33:43 elm3b81 kernel:  [<f8a6cb8c>] 
qla2x00_get_new_sp+0x1c/0x30 [qla2xxx]
Aug  9 10:33:43 elm3b81 kernel:  [<f8a6868a>] 
qla2x00_queuecommand+0x3a/0x6a0 [qla2xxx]
Aug  9 10:33:43 elm3b81 kernel:  [<c036f941>] scsi_dispatch_cmd+0x141/0x1e0
Aug  9 10:33:43 elm3b81 kernel:  [<c0374c9f>] scsi_request_fn+0x1ef/0x3d0
Aug  9 10:33:43 elm3b81 kernel:  [<c0333b82>] blk_run_queue+0x32/0x50
Aug  9 10:33:43 elm3b81 kernel:  [<c03740f0>] scsi_end_request+0xd0/0xf0
Aug  9 10:33:43 elm3b81 kernel:  [<c0374404>] scsi_io_completion+0x134/0x440
Aug  9 10:33:43 elm3b81 kernel:  [<c0398d9f>] sd_rw_intr+0x5f/0x280
Aug  9 10:33:43 elm3b81 kernel:  [<c036fd63>] scsi_finish_command+0x73/0xb0
Aug  9 10:33:43 elm3b81 kernel:  [<c036fc8b>] scsi_softirq+0xab/0xd0
Aug  9 10:33:43 elm3b81 kernel:  [<c012427c>] __do_softirq+0xbc/0xd0
Aug  9 10:33:43 elm3b81 kernel:  [<c01242c5>] do_softirq+0x35/0x40
Aug  9 10:33:43 elm3b81 kernel:  [<c0107b47>] do_IRQ+0x107/0x130
Aug  9 10:33:43 elm3b81 kernel:  [<c0105a90>] common_interrupt+0x18/0x20

Thanks,
-Janet


