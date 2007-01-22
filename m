Return-Path: <linux-kernel-owner+w=401wt.eu-S1751856AbXAVBPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbXAVBPg (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 20:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbXAVBPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 20:15:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:44555 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbXAVBPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 20:15:34 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=sM4znVeeiCa53saOZ0CE47T3EDGoj1q7H1G5p9pTYtIqrNT/VmgWFFuP9nU7oAgsN1B35gWdUTi0RSvzZatGu/l6SNIonhn7Bj0yY1tUOdtE9qoLv+itgMQ5YqNYUdRUEYNh2wRSqmo0RX+UPZMV2Tsz2JqOufNbroH1hGu3YKI=
Message-ID: <45B41028.2040203@googlemail.com>
Date: Mon, 22 Jan 2007 02:15:20 +0100
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.20-rc4-mm1 aio bug
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this while running aiostress.

Jan 22 01:50:05 black-mamba kernel: =======================================================
Jan 22 01:50:05 black-mamba kernel: [ INFO: possible circular locking dependency detected ]
Jan 22 01:50:05 black-mamba kernel: 2.6.20-rc4-mm1 #1
Jan 22 01:50:05 black-mamba kernel: -------------------------------------------------------
Jan 22 01:50:05 black-mamba kernel: aio/1/206 is trying to acquire lock:
Jan 22 01:50:05 black-mamba kernel:  (&q->lock){++..}, at: [<c011b509>] __wake_up+0x15/0x42
Jan 22 01:50:05 black-mamba kernel:
Jan 22 01:50:05 black-mamba kernel: but task is already holding lock:
Jan 22 01:50:05 black-mamba kernel:  (&ctx->ctx_lock){.+..}, at: [<c018fe21>] aio_complete+0x66/0x17d
Jan 22 01:50:05 black-mamba kernel:
Jan 22 01:50:05 black-mamba kernel: which lock already depends on the new lock.
Jan 22 01:50:05 black-mamba kernel:
Jan 22 01:50:06 black-mamba kernel:
Jan 22 01:50:06 black-mamba kernel: the existing dependency chain (in reverse order) is:
Jan 22 01:50:06 black-mamba kernel:
Jan 22 01:50:06 black-mamba kernel: -> #1 (&ctx->ctx_lock){.+..}:
Jan 22 01:50:06 black-mamba kernel:        [<c013f9a5>] __lock_acquire+0xb07/0xccd
Jan 22 01:50:06 black-mamba kernel:        [<c013fbe4>] lock_acquire+0x79/0x93
Jan 22 01:50:06 black-mamba kernel:        [<c032ac1b>] _spin_lock_irqsave+0x3e/0x4e
Jan 22 01:50:06 black-mamba kernel:        [<c0190166>] kick_iocb+0x4f/0xb4
Jan 22 01:50:06 black-mamba kernel:        [<c019020f>] aio_wake_function+0x44/0x49
Jan 22 01:50:06 black-mamba kernel:        [<c011a70c>] __wake_up_common+0x32/0x55
Jan 22 01:50:06 black-mamba kernel:        [<c011b525>] __wake_up+0x31/0x42
Jan 22 01:50:06 black-mamba kernel:        [<c01365c2>] __wake_up_bit+0x2e/0x34
Jan 22 01:50:06 black-mamba kernel:        [<c01588ae>] unlock_page+0x25/0x28
Jan 22 01:50:06 black-mamba kernel:        [<c019f250>] mpage_end_io_read+0x55/0x6a
Jan 22 01:50:06 black-mamba kernel:        [<c019afcd>] bio_endio+0x6c/0x74
Jan 22 01:50:06 black-mamba kernel:        [<c01f05be>] __end_that_request_first+0x212/0x498
Jan 22 01:50:06 black-mamba kernel:        [<c01f084c>] end_that_request_chunk+0x8/0xa
Jan 22 01:50:06 black-mamba kernel:        [<c02842f1>] scsi_end_request+0x20/0xb1
Jan 22 01:50:06 black-mamba kernel:        [<c02844e8>] scsi_io_completion+0xff/0x2d6
Jan 22 01:50:06 black-mamba kernel:        [<c028d95c>] sd_rw_intr+0x17b/0x1a7
Jan 22 01:50:06 black-mamba kernel:        [<c02809de>] scsi_finish_command+0x45/0x4a
Jan 22 01:50:06 black-mamba kernel:        [<c0284d9a>] scsi_softirq_done+0xb1/0xb9
Jan 22 01:50:06 black-mamba kernel:        [<c01f2af7>] blk_done_softirq+0x59/0x68
Jan 22 01:50:06 black-mamba kernel:        [<c0127bfd>] __do_softirq+0x6d/0xea
Jan 22 01:50:06 black-mamba kernel:        [<c0127cb3>] do_softirq+0x39/0x55
Jan 22 01:50:06 black-mamba kernel:        [<c0127f24>] irq_exit+0x46/0x53
Jan 22 01:50:06 black-mamba kernel:        [<c0106c74>] do_IRQ+0xad/0xc1
Jan 22 01:50:06 black-mamba kernel:        [<c0104d02>] common_interrupt+0x2e/0x34
Jan 22 01:50:06 black-mamba kernel:        [<c0173d8a>] cache_alloc_debugcheck_after+0x33/0x15c
Jan 22 01:50:06 black-mamba kernel:        [<c017531e>] kmem_cache_alloc+0xb3/0xbf
Jan 22 01:50:06 black-mamba kernel:        [<c015b49d>] mempool_alloc_slab+0xe/0x10
Jan 22 01:50:06 black-mamba kernel:        [<c015b563>] mempool_alloc+0x35/0xf2
Jan 22 01:50:06 black-mamba kernel:        [<c01f15fb>] get_request+0x13b/0x2ee
Jan 22 01:50:06 black-mamba kernel:        [<c01f17d4>] get_request_wait+0x26/0x17e
Jan 22 01:50:06 black-mamba kernel:        [<c01f3561>] __make_request+0x17f/0x2a7
Jan 22 01:50:06 black-mamba kernel:        [<c01f0bcb>] generic_make_request+0x2e1/0x30f
Jan 22 01:50:06 black-mamba kernel:        [<c01f3063>] submit_bio+0x132/0x13a
Jan 22 01:50:06 black-mamba kernel:        [<c019e7d1>] mpage_bio_submit+0x1c/0x21
Jan 22 01:50:06 black-mamba kernel:        [<c019f736>] mpage_readpages+0x122/0x130
Jan 22 01:50:06 black-mamba kernel:        [<c01b792b>] ext3_readpages+0x19/0x1b
Jan 22 01:50:06 black-mamba kernel:        [<c015f2ae>] __do_page_cache_readahead+0x13a/0x1ec
Jan 22 01:50:06 black-mamba kernel:        [<c015fd88>] page_cache_readahead_adaptive+0x468/0x4de
Jan 22 01:50:06 black-mamba kernel:        [<c015902f>] do_generic_mapping_read+0x1e5/0x568
Jan 22 01:50:06 black-mamba kernel:        [<c015b32e>] generic_file_aio_read+0x19a/0x1c8
Jan 22 01:50:06 black-mamba kernel:        [<c018f765>] aio_rw_vect_retry+0x6a/0x129
Jan 22 01:50:06 black-mamba kernel:        [<c018fff7>] aio_run_iocb+0xbf/0x164
Jan 22 01:50:06 black-mamba kernel:        [<c0190d7d>] io_submit_one+0x3f1/0x43c
Jan 22 01:50:06 black-mamba kernel:        [<c0191659>] sys_io_submit+0xe3/0x16e
Jan 22 01:50:06 black-mamba kernel:        [<c0104318>] syscall_call+0x7/0xb
Jan 22 01:50:06 black-mamba kernel:        [<ffffffff>] 0xffffffff
Jan 22 01:50:06 black-mamba kernel:
Jan 22 01:50:06 black-mamba kernel: -> #0 (&q->lock){++..}:
Jan 22 01:50:06 black-mamba kernel:        [<c013f889>] __lock_acquire+0x9eb/0xccd
Jan 22 01:50:06 black-mamba kernel:        [<c013fbe4>] lock_acquire+0x79/0x93
Jan 22 01:50:07 black-mamba kernel:        [<c032ac1b>] _spin_lock_irqsave+0x3e/0x4e
Jan 22 01:50:07 black-mamba kernel:        [<c011b509>] __wake_up+0x15/0x42
Jan 22 01:50:07 black-mamba kernel:        [<c018ff23>] aio_complete+0x168/0x17d
Jan 22 01:50:07 black-mamba kernel:        [<c019003b>] aio_run_iocb+0x103/0x164
Jan 22 01:50:07 black-mamba kernel:        [<c01900f2>] __aio_run_iocbs+0x56/0x7b
Jan 22 01:50:07 black-mamba kernel:        [<c01913ef>] aio_kick_handler+0x203/0x284
Jan 22 01:50:07 black-mamba kernel:        [<c0132c5c>] run_workqueue+0x9b/0x162
Jan 22 01:50:07 black-mamba kernel:        [<c01339ce>] worker_thread+0xf9/0x125
Jan 22 01:50:07 black-mamba kernel:        [<c013651f>] kthread+0xb5/0xde
Jan 22 01:50:07 black-mamba kernel:        [<c0104f87>] kernel_thread_helper+0x7/0x10
Jan 22 01:50:07 black-mamba kernel:        [<ffffffff>] 0xffffffff
Jan 22 01:50:07 black-mamba kernel:
Jan 22 01:50:07 black-mamba kernel: other info that might help us debug this:
Jan 22 01:50:07 black-mamba kernel:
Jan 22 01:50:07 black-mamba kernel: 1 lock held by aio/1/206:
Jan 22 01:50:07 black-mamba kernel:  #0:  (&ctx->ctx_lock){.+..}, at: [<c018fe21>] aio_complete+0x66/0x17d
Jan 22 01:50:07 black-mamba kernel:
Jan 22 01:50:07 black-mamba kernel: stack backtrace:
Jan 22 01:50:07 black-mamba kernel:  [<c0105306>] show_trace_log_lvl+0x1a/0x2f
Jan 22 01:50:07 black-mamba kernel:  [<c0105a16>] show_trace+0x12/0x14
Jan 22 01:50:07 black-mamba kernel:  [<c0105ad8>] dump_stack+0x16/0x18
Jan 22 01:50:07 black-mamba kernel:  [<c013ddac>] print_circular_bug_tail+0x5f/0x68
Jan 22 01:50:07 black-mamba kernel:  [<c013f889>] __lock_acquire+0x9eb/0xccd
Jan 22 01:50:07 black-mamba kernel:  [<c013fbe4>] lock_acquire+0x79/0x93
Jan 22 01:50:07 black-mamba kernel:  [<c032ac1b>] _spin_lock_irqsave+0x3e/0x4e
Jan 22 01:50:07 black-mamba kernel:  [<c011b509>] __wake_up+0x15/0x42
Jan 22 01:50:07 black-mamba kernel:  [<c018ff23>] aio_complete+0x168/0x17d
Jan 22 01:50:07 black-mamba kernel:  [<c019003b>] aio_run_iocb+0x103/0x164
Jan 22 01:50:07 black-mamba kernel:  [<c01900f2>] __aio_run_iocbs+0x56/0x7b
Jan 22 01:50:07 black-mamba kernel:  [<c01913ef>] aio_kick_handler+0x203/0x284
Jan 22 01:50:07 black-mamba kernel:  [<c0132c5c>] run_workqueue+0x9b/0x162
Jan 22 01:50:07 black-mamba kernel:  [<c01339ce>] worker_thread+0xf9/0x125
Jan 22 01:50:07 black-mamba kernel:  [<c013651f>] kthread+0xb5/0xde
Jan 22 01:50:07 black-mamba kernel:  [<c0104f87>] kernel_thread_helper+0x7/0x10
Jan 22 01:50:07 black-mamba kernel:  =======================
Jan 22 01:50:07 black-mamba kernel: BUG: workqueue leaked lock or atomic: aio/1/0x00000000/206
Jan 22 01:50:07 black-mamba kernel:     last function: aio_kick_handler+0x0/0x284
Jan 22 01:50:07 black-mamba kernel: 1 lock held by aio/1/206:
Jan 22 01:50:07 black-mamba kernel:  #0:  (&ctx->ctx_lock){.+..}, at: [<c018fe21>] aio_complete+0x66/0x17d
Jan 22 01:50:07 black-mamba kernel:  [<c0105306>] show_trace_log_lvl+0x1a/0x2f
Jan 22 01:50:07 black-mamba kernel:  [<c0105a16>] show_trace+0x12/0x14
Jan 22 01:50:07 black-mamba kernel:  [<c0105ad8>] dump_stack+0x16/0x18
Jan 22 01:50:07 black-mamba kernel:  [<c0132cef>] run_workqueue+0x12e/0x162
Jan 22 01:50:07 black-mamba kernel:  [<c01339ce>] worker_thread+0xf9/0x125
Jan 22 01:50:07 black-mamba kernel:  [<c013651f>] kthread+0xb5/0xde
Jan 22 01:50:07 black-mamba kernel:  [<c0104f87>] kernel_thread_helper+0x7/0x10
Jan 22 01:50:07 black-mamba kernel:  =======================
Jan 22 01:50:07 black-mamba kernel: BUG: workqueue leaked lock or atomic: aio/1/0x00000000/206
Jan 22 01:50:07 black-mamba kernel:     last function: aio_kick_handler+0x0/0x284
Jan 22 01:50:07 black-mamba kernel: 1 lock held by aio/1/206:
Jan 22 01:50:07 black-mamba kernel:  #0:  (&ctx->ctx_lock){.+..}, at: [<c018fe21>] aio_complete+0x66/0x17d
Jan 22 01:50:07 black-mamba kernel:  [<c0105306>] show_trace_log_lvl+0x1a/0x2f
Jan 22 01:50:07 black-mamba kernel:  [<c0105a16>] show_trace+0x12/0x14
Jan 22 01:50:07 black-mamba kernel:  [<c0105ad8>] dump_stack+0x16/0x18
Jan 22 01:50:07 black-mamba kernel:  [<c0132cef>] run_workqueue+0x12e/0x162
Jan 22 01:50:07 black-mamba kernel:  [<c01339ce>] worker_thread+0xf9/0x125
Jan 22 01:50:07 black-mamba kernel:  [<c013651f>] kthread+0xb5/0xde
Jan 22 01:50:07 black-mamba kernel:  [<c0104f87>] kernel_thread_helper+0x7/0x10

2.6.20-rc4-mm1 + hot fixes

http://www.stardust.webpages.pl/files/tbf/black-mamba/2.6.20-rc4-mm1/mm-config
http://www.stardust.webpages.pl/files/tbf/black-mamba/2.6.20-rc4-mm1/mm-dmesg

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
