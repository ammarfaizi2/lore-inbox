Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWHCOit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWHCOit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWHCOit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:38:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:57403 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932380AbWHCOis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:38:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MwgGaEdqeqwzEve4lq4in6mXpDbEgQ3b+tS5UhNPUM7mVvYzaSx0sBfpG3rBZCDWne1wdLLnVY2o+usetPvNn1A4FsShstCE7nQpfLIAf/BUIy1p3hCYOYNNWM0rwf6h58JzyNPQma9YRVEjJrUA3me+0UkuQ+/Q7G8HFdWBaHE=
Message-ID: <e6babb600608030738o7e2793dcx1e118e7617297401@mail.gmail.com>
Date: Thu, 3 Aug 2006 07:38:47 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: nobody cared for tg3 w/ 2.6.17-rt8
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-rt8

irq 106: nobody cared (try booting with the "irqpoll" option)

Call Trace:
       <ffffffff8029d0f5>{__report_bad_irq+48}
       <ffffffff8029d307>{note_interrupt+453}
       <ffffffff8028ff68>{keventd_create_kthread+0}
       <ffffffff8029c7b2>{thread_simple_irq+126}
       <ffffffff8028ff68>{keventd_create_kthread+0}
       <ffffffff8029cc57>{do_irqd+206}
       <ffffffff8028ff68>{keventd_create_kthread+0}
       <ffffffff8029cb89>{do_irqd+0}
       <ffffffff80231c11>{kthread+212}
       <ffffffff8025df7a>{child_rip+8}
       <ffffffff8028ff68>{keventd_create_kthread+0}
       <ffffffff80231b3d>{kthread+0}
       <ffffffff8025df72>{child_rip+0}
handlers:
[<ffffffff880036f0>] (tg3_interrupt_tagged+0x0/0x91 [tg3])

but as noted in the boot message, irqpoll isn't support for -rt.  I
haven't seen this problem when running vanilla 2.6.17.  Just after
that:

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at kernel/rtmutex.c:639
invalid opcode: 0000 [1] PREEMPT SMP
CPU 0
Modules linked in: nfsd exportfs lockd sunrpc ohci1394 ieee1394 nvidia tg3
Pid: 1120, comm: kjournald Tainted: P      2.6.17-rt7_local_00 #12
RIP: 0010:[<ffffffff80261778>] <ffffffff80261778>{rt_lock_slowlock+96}
RSP: 0000:ffff8105f241bac8  EFLAGS: 00010246
RAX: ffff8103f3d72820 RBX: 0000000000000000 RCX: ffff810001097748
RDX: ffff8103f3d72820 RSI: ffff8103f3d72820 RDI: ffff8105f241bb34
RBP: ffff810001097720 R08: 0000000000000001 R09: ffff8101defd50c0
R10: 0000000000000001 R11: ffff8100010967e0 R12: 0000000000011200
R13: ffff8101f3c449c0 R14: 0000000000000010 R15: 0000000000000000
FS:  00002aae0c14d1e0(0000) GS:ffffffff80640180(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000bb8078 CR3: 00000001e030b000 CR4: 00000000000006e0
Process kjournald (pid: 1120, threadinfo ffff8105f241a000, task
ffff8103f3d72820)
Stack: 0000000000000000 ffff8107f3cebf00 ffff8105f241bb34 ffffffff802af637
       0001120000000580 0000000000000003 ffff8101f3ebd080 0000000000011200
       ffff8101f3c449c0 0000000000000010
Call Trace:
       <ffffffff802af637>{__cache_alloc_node+232}
       <ffffffff802af703>{alternate_node_alloc+150}
       <ffffffff8020a01b>{kmem_cache_alloc+52}
       <ffffffff802222df>{mempool_alloc+36}
       <ffffffff8022d048>{blk_recount_segments+126}
       <ffffffff8021a0d2>{bio_alloc_bioset+137}
       <ffffffff802b4369>{bio_clone+26}
       <ffffffff803e303b>{make_request+1274}
       <ffffffff8020a096>{kmem_cache_alloc+175}
       <ffffffff8021b626>{generic_make_request+348}
       <ffffffff8023259f>{submit_bio+186}
       <ffffffff80219fbf>{submit_bh+247}
       <ffffffff80216c54>{ll_rw_block+132}
       <ffffffff802e95e9>{journal_commit_transaction+1008}
       <ffffffff8023cc19>{lock_timer_base+27}
       <ffffffff802ed728>{kjournald+194}
       <ffffffff80290174>{autoremove_wake_function+0}
       <ffffffff802ed666>{kjournald+0}
       <ffffffff8028ff68>{keventd_create_kthread+0}
       <ffffffff80231c11>{kthread+212}
       <ffffffff8025df7a>{child_rip+8}
       <ffffffff8028ff68>{keventd_create_kthread+0}
       <ffffffff80231b3d>{kthread+0}
       <ffffffff8025df72>{child_rip+0}

Code: 0f 0b 68 b5 4a 49 80 c2 7f 02 65 48 8b 04 25 00 00 00 00 41
RIP <ffffffff80261778>{rt_lock_slowlock+96} RSP <ffff8105f241bac8>
 <6>note: kjournald[1120] exited with preempt_count 1

-- 
Robert Crocombe
rcrocomb@gmail.com
