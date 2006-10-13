Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWJMOkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWJMOkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWJMOkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:40:32 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:47368 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1750936AbWJMOkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:40:31 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc1 (+ide-cd patches) regression: unable to rip cd
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk>
	<1160648885.5897.6.camel@Homer.simpson.net>
	<1160662435.6177.3.camel@Homer.simpson.net>
	<20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk>
	<87odshr289.fsf@sycorax.lbl.gov> <20061012152356.GE6515@kernel.dk>
	<87slhtfrlr.fsf@sycorax.lbl.gov> <20061012165110.GJ6515@kernel.dk>
Date: Fri, 13 Oct 2006 07:40:12 -0700
In-Reply-To: <20061012165110.GJ6515@kernel.dk> (message from Jens Axboe on
	Thu, 12 Oct 2006 18:51:11 +0200)
Message-ID: <87vemoi8j7.fsf_-_@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> writes:

> On Thu, Oct 12 2006, Alex Romosan wrote:
>>
>> please ignore my previous message, i am an idiot. if i actually put a
>> dvd in the drive then this patch works as expected. sorry for the
>> noise.
>
> Good, thanks for the update :-)

looks like the dvd problem was fixed but this morning i got the same
message:

  kernel: hdc: write_intr: wrong transfer direction!

trying to rip a cd with grip (cdparanoia). the process is stuck, i
can't kill it, and it's not making any more progress (but it still has
the smiling face so it probably thinks everything's fine). sysrq-t
shows this:


kernel: grip          D 00000007     0 17133   3835               16719 (NOTLB)
kernel:        d9677bac 00200082 d0ad2a70 00000007 d0ad2a70 23f93e80 000031a2 00000000 
kernel:        d0ad2b7c 00000000 d9677c44 540ae480 00000000 da8d7740 d9677c44 dfe9679c 
kernel:        d9677bc8 d9677bd0 c02f06ac 00000001 d0ad2a70 c011486c d9677c48 d9677c48 
kernel: Call Trace:
kernel:  [<c02f06ac>] wait_for_completion+0x85/0xd5
kernel:  [<c011486c>] default_wake_function+0x0/0xc
kernel:  [<c01b619d>] blk_execute_rq+0x78/0x8b
kernel:  [<c01b59cf>] blk_end_sync_rq+0x0/0x23
kernel:  [<c01b4c97>] blk_rq_bio_prep+0x28/0x7c
kernel:  [<c01b8eb2>] sg_io+0x253/0x34e
kernel:  [<c01b93ec>] scsi_cmd_ioctl+0x1ab/0x357
kernel:  [<c01256a9>] __rcu_process_callbacks+0xf4/0x178
kernel:  [<c011baf5>] tasklet_action+0x37/0x5c
kernel:  [<c011ba67>] __do_softirq+0x59/0x85
kernel:  [<c0118a2f>] profile_tick+0x3d/0x4e
kernel:  [<c0258582>] cdrom_ioctl+0x22/0xb30
kernel:  [<c0156228>] send_sigio+0x13b/0x146
kernel:  [<c025301c>] idecd_ioctl+0x12d/0x142
kernel:  [<c011ee00>] do_timer+0x679/0x6ff
kernel:  [<c01b7a87>] blkdev_driver_ioctl+0x4b/0x5b
kernel:  [<c01b80d8>] blkdev_ioctl+0x641/0x691
kernel:  [<c0217a93>] add_timer_randomness+0x106/0x120
kernel:  [<c025d3c0>] input_event+0x33/0x40e
kernel:  [<c025d77a>] input_event+0x3ed/0x40e
kernel:  [<c0137adf>] get_page_from_freelist+0x72/0x2f7
kernel:  [<c0137c33>] get_page_from_freelist+0x1c6/0x2f7
kernel:  [<c0137f1a>] __alloc_pages+0x4e/0x267
kernel:  [<c013a250>] lru_cache_add_active+0x47/0x5d
kernel:  [<c013e5d1>] __handle_mm_fault+0x458/0x7e4
kernel:  [<c016b3e6>] block_ioctl+0x10/0x13
kernel:  [<c016b3d6>] block_ioctl+0x0/0x13
kernel:  [<c0156b08>] do_ioctl+0x1c/0x5d
kernel:  [<c0156d90>] vfs_ioctl+0x247/0x25a
kernel:  [<c0156dcf>] sys_ioctl+0x2c/0x45
kernel:  [<c0102cbf>] syscall_call+0x7/0xb
kernel:  [<c02f007b>] __sched_text_start+0x123/0x560

let me know if i can help debug this.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
