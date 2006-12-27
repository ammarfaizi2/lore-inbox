Return-Path: <linux-kernel-owner+w=401wt.eu-S1754757AbWL0VFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbWL0VFZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbWL0VFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:05:25 -0500
Received: from homer.mvista.com ([63.81.120.158]:38920 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbWL0VFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:05:24 -0500
Subject: Re: [PATCH -rt] update kmap_atomic on !HIGHMEM
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061227205403.GA8464@elte.hu>
References: <20061227193550.324850000@mvista.com>
	 <20061227205403.GA8464@elte.hu>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 13:04:41 -0800
Message-Id: <1167253481.14081.41.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 21:54 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > I got some scheduling while atomic on x86-64 , [...]
> 
> please post those messages too.
> 
> 	Ingo

Ok .. This is from 2.6.20-rc2-rt0 tho .

BUG: scheduling while atomic: kswapd0/0x00000001/244, CPU#1

Call Trace:
[<ffffffff80268f80>] __sched_text_start+0xb0/0xb9f
[<ffffffff8028fa8c>] task_rq_lock+0x4c/0x90
[<ffffffff8028fdd3>] rt_mutex_setprio+0xb3/0xd0
[<ffffffff802bb2c4>] add_preempt_count+0x14/0xf0
[<ffffffff802b1353>] task_blocks_on_rt_mutex+0x163/0x1d0
[<ffffffff80269da5>] schedule+0xe5/0x110
[<ffffffff8026afa2>] rt_spin_lock_slowlock+0x102/0x1b0
[<ffffffff802c9b71>] swap_duplicate+0x51/0x100
[<ffffffff802c94b2>] move_to_swap_cache+0x32/0x70
[<ffffffff802cf4ba>] shmem_writepage+0xaa/0x1a0
[<ffffffff802c35e0>] shrink_inactive_list+0x430/0x950
[<ffffffff802134f4>] shrink_zone+0xe4/0x110
[<ffffffff8025e629>] kswapd+0x379/0x510
[<ffffffff802a8270>] autoremove_wake_function+0x0/0x30
[<ffffffff8025e2b0>] kswapd+0x0/0x510
[<ffffffff80234c89>] kthread+0xd9/0x120
[<ffffffff8022981c>] schedule_tail+0xdc/0x130
[<ffffffff802a80a0>] keventd_create_kthread+0x0/0x90
[<ffffffff80265ef8>] child_rip+0xa/0x12
[<ffffffff802a80a0>] keventd_create_kthread+0x0/0x90
[<ffffffff80234bb0>] kthread+0x0/0x120
[<ffffffff80265eee>] child_rip+0x0/0x12

---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
 .. [<ffffffff802cc111>] .... shmem_swp_entry+0x31/0x1a0
 .....[<00000000>] ..   ( <= 0x0)


