Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030556AbWJ3SLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbWJ3SLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWJ3SLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:11:52 -0500
Received: from rtr.ca ([64.26.128.89]:64527 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030330AbWJ3SLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:11:51 -0500
Message-ID: <45464064.2090108@rtr.ca>
Date: Mon, 30 Oct 2006 13:11:48 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca>
In-Reply-To: <45463C5B.7070900@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jens Axboe wrote:
..
>> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
>> index 4bae64e..da9bddf 100644
>> --- a/block/cfq-iosched.c
>> +++ b/block/cfq-iosched.c
..

It's still there.  I also see it with the SLES10 kernel 2.6.16.21-0.8.


[ INFO: inconsistent lock state ]
2.6.19-rc3-git7-ml #3
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
startproc/4046 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&q->__queue_lock){-+..}, at: [<c0219091>] cfq_set_request+0x351/0x3b0
{in-softirq-W} state was registered at:
  [<c01376b1>] mark_lock+0x81/0x5f0
  [<c0138a90>] __lock_acquire+0x660/0xc10
  [<c013939d>] lock_acquire+0x5d/0x80
  [<c0361c59>] _spin_lock+0x29/0x40
  [<c029fa24>] scsi_device_unbusy+0x64/0x90
  [<c029a5bc>] scsi_finish_command+0x1c/0xa0
  [<c02115c2>] blk_done_softirq+0x62/0x70
  [<c0122a27>] __do_softirq+0x87/0x100
  [<c0122af5>] do_softirq+0x55/0x60
  [<c0122f3c>] ksoftirqd+0x7c/0xd0
  [<c0130f76>] kthread+0xf6/0x100
  [<c0103c6f>] kernel_thread_helper+0x7/0x18
  [<ffffffff>] 0xffffffff
irq event stamp: 3331
hardirqs last  enabled at (3331): [<c016326d>] kmem_cache_alloc+0x6d/0xa0
hardirqs last disabled at (3330): [<c016321f>] kmem_cache_alloc+0x1f/0xa0
softirqs last  enabled at (3012): [<c0122af5>] do_softirq+0x55/0x60
softirqs last disabled at (2971): [<c0122af5>] do_softirq+0x55/0x60

other info that might help us debug this:
no locks held by startproc/4046.

stack backtrace:
 [<c0104042>] dump_trace+0x192/0x1c0
 [<c0104088>] show_trace_log_lvl+0x18/0x30
 [<c010483f>] show_trace+0xf/0x20
 [<c01049a5>] dump_stack+0x15/0x20
 [<c0137291>] print_usage_bug+0x251/0x270
 [<c0137ae7>] mark_lock+0x4b7/0x5f0
 [<c0138aae>] __lock_acquire+0x67e/0xc10
 [<c013939d>] lock_acquire+0x5d/0x80
 [<c0361c59>] _spin_lock+0x29/0x40
 [<c0219091>] cfq_set_request+0x351/0x3b0
 [<c020c7fc>] elv_set_request+0x1c/0x40
 [<c020fcff>] get_request+0x23f/0x270
 [<c0210537>] get_request_wait+0x27/0x120
 [<c02107ca>] __make_request+0x5a/0x350
 [<c020f40f>] generic_make_request+0x16f/0x220
 [<c02117e4>] submit_bio+0x64/0x110
 [<c018e969>] mpage_bio_submit+0x19/0x20
 [<c018fe85>] mpage_readpages+0x105/0x140
 [<c014d67f>] __do_page_cache_readahead+0x17f/0x260
 [<c014d7d2>] blockable_page_cache_readahead+0x72/0xd0
 [<c014da25>] page_cache_readahead+0x135/0x1e0
 [<c01474ce>] do_generic_mapping_read+0x55e/0x5a0
 [<c01496b1>] generic_file_aio_read+0x101/0x270
 [<c01669b5>] do_sync_read+0xd5/0x120
 [<c01672d1>] vfs_read+0xa1/0x160
 [<c0167851>] sys_read+0x41/0x70
 [<c0102f71>] sysenter_past_esp+0x56/0x8d
 [<b7efd410>] 0xb7efd410
 =======================
