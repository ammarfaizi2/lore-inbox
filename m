Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbULITUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbULITUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbULITUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:20:13 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:900 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261576AbULITUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:20:01 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1102602829.25841.393.camel@localhost.localdomain>
References: <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>
	 <1102526018.25841.308.camel@localhost.localdomain>
	 <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu>  <20041209131317.GA31573@elte.hu>
	 <1102602829.25841.393.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Thu, 09 Dec 2004 14:19:52 -0500
Message-Id: <1102619992.3882.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 09:33 -0500, Steven Rostedt wrote:
> On Thu, 2004-12-09 at 14:13 +0100, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > here's the full patch against a recent tree, or download the -32-12
> > patch from the usual place:
> > 
> >     http://redhat.com/~mingo/realtime-preempt/
> 
> Ingo,
> 
> I just tried out your changes with both my sillycaches test as well as
> my real modules that had the original problems. They both work fine.
> 
> I'll ever reboot my main machine now (SMP) and run your kernel there
> too, and see how it works.

Hi Ingo,

I just tried it on my main machine (SMP Dual Athlon MP, with a Gig of
RAM), and I just got the following dump on boot-up.  It never made it to
a prompt.

Freeing unused kernel memory: 216k freed
BUG: sleeping function called from invalid context IRQ 14(814) at
arch/i386/mm/highmem.c:5
in_atomic():0 [00000000], irqs_disabled():1
 [<c011c064>] __might_sleep+0xd4/0xf0 (8)
 [<c011749f>] kmap+0x1f/0x50 (36)
 [<c014ffb8>] bounce_copy_vec+0x28/0x70 (16)
 [<c01500bc>] copy_to_high_bio_irq+0x5c/0x70 (32)
 [<c0150221>] __bounce_end_io_read+0x41/0x50 (28)
 [<c0150258>] bounce_end_io_read+0x28/0x30 (20)
 [<c01686b9>] bio_endio+0x59/0x80 (12)
 [<c025a2bc>] ide_end_request+0x2c/0xc0 (16)
 [<c024bc02>] __end_that_request_first+0x1c2/0x230 (12)
 [<c01386cf>] up_mutex+0xaf/0x100 (16)
 [<c025a197>] __ide_end_request+0x77/0x170 (36)
 [<c025a2f5>] ide_end_request+0x65/0xc0 (36)
 [<c0260810>] task_end_request+0x40/0x80 (36)
 [<c0260941>] task_in_intr+0xf1/0x110 (24)
 [<c0260850>] task_in_intr+0x0/0x110 (20)
 [<c025bda1>] ide_intr+0xe1/0x170 (12)
 [<c0140e3b>] handle_IRQ_event+0x5b/0xd0 (32)
 [<c0141683>] do_hardirq+0xa3/0x100 (48)
 [<c01417f6>] do_irqd+0x116/0x1e0 (36)
 [<c01416e0>] do_irqd+0x0/0x1e0 (44)
 [<c0135e37>] kthread+0xb7/0xc0 (4)
 [<c0135d80>] kthread+0x0/0xc0 (28)
 [<c01012e5>] kernel_thread_helper+0x5/0x10 (16)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c01398e7>] .... print_traces+0x17/0x50
.....[<00000000>] ..   ( <= 0x0)


This looks like it was triggered by bounce_copy_vec calling kmap_atomic
which is now just kmap with irqs disabled.  Does this need to change to
__kmap_atomic?  Is this also used to make things more preemptible, and
start removing the local_irq_saves?  I'd like to know so that you don't
need to make the patches yourself and I can handle things like this, but
I need to know what the general ideas are.  Also, am I the only one that
has highmem support enabled, because this looks like this bug would have
been triggered by anyone.

Thanks,

-- Steve

