Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVAJKOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVAJKOu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 05:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVAJKOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 05:14:49 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:657
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262197AbVAJKOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 05:14:42 -0500
Subject: Re: [PATCH 2.6.10-mm2] Fix preemption race [1/3] (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050110091559.GB25034@elte.hu>
References: <20050110013508.1.patchmail@tglx>
	 <20050110091559.GB25034@elte.hu>
Content-Type: text/plain
Organization: Linutronix
Message-Id: <1105352084.3058.5.camel@lap02.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 Jan 2005 11:14:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 10:15, Ingo Molnar wrote:
> * tglx@linutronix.de <tglx@linutronix.de> wrote:
> 
> > The idle-thread-preemption-fix.patch introduced a race, which is not
> > critical, but might give us an extra turn through the scheduler. When
> > interrupts are reenabled in entry.c and an interrupt occures before we
> > reach the add_preempt_schedule() in preempt_schedule we get
> > rescheduled again in the return from interrupt path.
> 
> i agree that there's a race. I solved this in the -RT patchset a couple
> of weeks ago, but in a different wasy. I introduced the
> preempt_schedule_irq() function and this solves the problem via keeping
> the whole IRQ-preemption path irqs-off. This has the advantage that if
> an IRQ signals preemption of a task and the kernel is immediately
> preemptable then we are able to hit that task atomically without
> re-enabling IRQs again. I'll split out this patch - can you see any
> problems with the preempt_schedule_irq() approach?

No.
I did not look into your RT patch for this, but please have a look at
RMK's ARM code, as he is doing some sanity check on
thread_info->preemption down there.

tglx


