Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWJER5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWJER5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWJER5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:57:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:16521 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751757AbWJER5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:57:15 -0400
Subject: Re: 2.6.18-mm2 boot failure on x86-64
From: Steve Fox <drfickle@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <200610051740.58511.ak@suse.de>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <1160061173.9569.43.camel@dyn9047017100.beaverton.ibm.com>
	 <1160062332.29690.10.camel@flooterbu>  <200610051740.58511.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 12:57:12 -0500
Message-Id: <1160071032.29690.19.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 17:40 +0200, Andi Kleen wrote:

> Please don't snip the Code: line. It is fairly important.

Sorry about that. The remote console I was using appears to overwrite
some text after I force the reboot. Here's a clean one.

global ffffffffffffffff
Unable to handle kernel NULL pointer dereference at 0000000000000827 RIP:
 [<ffffffff80470766>] xfrm_register_mode+0x36/0x60
PGD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.18-git22 #3
RIP: 0010:[<ffffffff80470766>]  [<ffffffff80470766>] xfrm_register_mode+0x36/0x60
RSP: 0000:ffff810bffcbded0  EFLAGS: 00010286
RAX: 000000000000081f RBX: ffffffff805588a0 RCX: 0000000000000000
RDX: ffffffffffffffff RSI: 0000000000000046 RDI: ffffffff80559550
RBP: 00000000ffffffef R08: 0000000000007a02 R09: 000000000000000e
R10: 0000000000000006 R11: ffffffff80334660 R12: 0000000000000000
R13: ffff810bffcbdef0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff805d2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000827 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff810bffcbc000, task ffff810bffcbb4e0)
Stack:  0000000000000000 ffffffff8061fb48 0000000000000000 ffffffff80207182
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 0000000000000000 0000000000000000 0000000000000000 0000000000090000
Call Trace:
 [<ffffffff80207182>] init+0x162/0x330
 [<ffffffff8020a9a8>] child_rip+0xa/0x12
 [<ffffffff803394c2>] acpi_ds_init_one_object+0x0/0x82
 [<ffffffff80207020>] init+0x0/0x330
 [<ffffffff8020a99e>] child_rip+0x0/0x12


Code: 48 83 78 08 00 75 06 48 89 58 08 31 ed 48 89 d7 e8 65 fd ff
RIP  [<ffffffff80470766>] xfrm_register_mode+0x36/0x60
 RSP <ffff810bffcbded0>
CR2: 0000000000000827
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

> My guess is that something is wrong with the global variable it is accessing.
> Can you post the output of grep -5 xfrm_policy_afinfo ? 

elm3b239:/boot # grep -5 xfrm_policy_afinfo System.map-2.6.18-git22
ffffffff805594c0 d xfrm4_state_afinfo
ffffffff80559500 D xfrm_cfg_mutex
ffffffff80559530 d xfrm_dev_notifier
ffffffff80559548 d xfrm_policy_lock
ffffffff8055954c d xfrm_policy_gc_lock
ffffffff80559550 d xfrm_policy_afinfo_lock
ffffffff80559560 d xfrm_hash_work
ffffffff805595c0 d hash_resize_mutex
ffffffff80559600 D sysctl_xfrm_aevent_etime
ffffffff80559604 D sysctl_xfrm_aevent_rseqth
ffffffff80559610 D km_waitq
--
ffffffff8075bfd8 b idiagnl
ffffffff8075bfe0 B xfrm_policy_count
ffffffff8075bff8 b xfrm_policy_gc_list
ffffffff8075c000 b dummy.28400
ffffffff8075c038 b idx_generator.27450
ffffffff8075c040 b xfrm_policy_afinfo
ffffffff8075c140 b xfrm_policy_gc_work
ffffffff8075c1a0 b xfrm_policy_inexact
ffffffff8075c1e0 B xfrm_nl
ffffffff8075c1e8 b xfrm_state_gc_list
ffffffff8075c1f0 b acqseq.27386

> And please add a 
> printk("global %p\n",  xfrm_policy_afinfo[family]);
> at the beginning of net/xfrm/xfrm_poliy.c:xfrm_policy_lock_afinfo
> and post the output.

Included above.

-- 

Steve Fox
IBM Linux Technology Center
