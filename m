Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWHaO7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWHaO7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHaO7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:59:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:41105 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932168AbWHaO7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:59:46 -0400
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
From: Badari Pulavarty <pbadari@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, petkov@math.uni-muenster.de,
       akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200608310941.40076.ak@suse.de>
References: <20060820013121.GA18401@fieldses.org>
	 <1156974410.16136.1.camel@dyn9047017100.beaverton.ibm.com>
	 <44F6AD47.76E4.0078.0@novell.com>  <200608310941.40076.ak@suse.de>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 08:02:58 -0700
Message-Id: <1157036578.22667.6.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 09:41 +0200, Andi Kleen wrote:

> -Andi
> 
> P.S.: Badari, we worked out your kernel_math_context trace too:
> that one is actually a gcc bug related to dubious unwind tables generated
> for noreturn calls (in your case do_exit). We were still discussing the best 
> workaround for that one.
> 

I will verify them when I get a chance to move to latest kernel.
Unfortunately, so called testcases are the *real* problems I am
trying to track down in 2.6.18-rc4 and I have a setup/config/testcase
which can reproduce them consistently. I don't want to change
any kernel/config till I debug these issues. Once I figure out whats
happening - I will move to latest and verify one more time.

BTW, I have one more issue - may not be related to unwinder. As
you can see when I get a assert on CPU1, I get its stack correctly.
But CPU 2 is getting stuck while printing OOPS. 

Do you know, why ?

Thanks,
Badari

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/buffer.c:2791
invalid opcode: 0000 [1] SMP
CPU 1
Modules linked in: sg sd_mod qla2xxx firmware_class scsi_transport_fc
scsi_mod ipv6 thermal processor fan button battery ac dm_mod floppy
parport_pc lp parport
Pid: 4216, comm: kjournald Not tainted 2.6.18-rc4 #3
RIP: 0010:[<ffffffff80282d39>]  [<ffffffff80282d39>] submit_bh
+0x29/0x130
RSP: 0018:ffff8101bde8dd08  EFLAGS: 00010246
RAX: 0000000000000005 RBX: ffff8101bd0ad250 RCX: ffff8101df880e88
RDX: ffff8101733887c0 RSI: ffff8101bd0ad250 RDI: 0000000000000001
RBP: ffff8101bde8dd28 R08: ffff8101a033be38 R09: ffff81017605d7c0
R10: 00000000000a8f52 R11: 00000000000a8f54 R12: ffff8101a0113260 R13:
0000000000000001 R14: 0000000000000003 R15: 0000000000000080 FS:
00002b5b2e4476d0(0000) GS:ffff8101800a5140(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b5b2e1bd000 CR3: 0000000000201000 CR4: 00000000000006e0
Process kjournald (pid: 4216, threadinfo ffff8101bde8c000, task
ffff810180259790)
Stack:  ffff810174897f70 ffff8101bd0ad250 ffff8101a0113260
000000000000004c
 ffff8101bde8dd68 ffffffff80284179 00000000bde8dd68 ffff81017441d250
 ffff8101769ee910 ffff8101dd2518c0 0000000000000080 ffff8101a0059200
Call Trace:
 [<ffffffff80284179>] ll_rw_block+0x79/0xd0
 [<ffffffff8030e868>] journal_commit_transaction+0x478/0x1170
 [<ffffffff80312c8e>] kjournald+0xde/0x290
 [<ffffffff8024562c>] kthread+0xdc/0x110
 [<ffffffff8020abe2>] child_rip+0x8/0x12 DWARF2 unwinder stuck at
child_rip+0x8/0x12
Leftover inexact backtrace:
 [<ffffffff80245550>] kthread+0x0/0x110
 [<ffffffff8020abda>] child_rip+0x0/0x12


Code: 0f 0b 68 d3 e0 50 80 c2 e7 0a 48 83 7b 38 00 75 0a 0f 0b 68
RIP  [<ffffffff80282d39>] submit_bh+0x29/0x130
 RSP <ffff8101bde8dd08>
 <1>Unable to handle kernel paging request at 0000000146f4eac0 RIP:
 [<ffffffff802277b8>] task_rq_lock+0x38/0x90
PGD 1ddc2e067 PUD 0
Oops: 0000 [2] SMP


