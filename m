Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVAJNqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVAJNqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVAJNqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:46:31 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:20881
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262251AbVAJNqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:46:10 -0500
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [2/3] Resend
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050110110252.GA1605@elte.hu>
References: <20050110013508.1.patchmail@tglx>
	 <1105318406.17853.2.camel@tglx.tec.linutronix.de>
	 <20050110010613.A5825@flint.arm.linux.org.uk>
	 <1105319915.17853.8.camel@tglx.tec.linutronix.de>
	 <20050110094624.A24919@flint.arm.linux.org.uk>
	 <1105351977.3058.2.camel@lap02.tec.linutronix.de>
	 <20050110110252.GA1605@elte.hu>
Content-Type: text/plain
Organization: Linutronix
Message-Id: <1105364769.3058.11.camel@lap02.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 Jan 2005 14:46:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 12:02, Ingo Molnar wrote:
> i wouldnt raise this issue if it was the name only, but there's more to
> preempt_schedule_irq() than its name: it gets called with irqs off and
> the scheduler returns with irqs off and with a guarantee that there is
> no (irq-generated) pending preemption request for this task right now. 
> I.e. the checks for need_resched can be skipped, and interrupts dont
> have to be disabled to do a safe return-to-usermode (as done on some
> architectures).
> 
> as far as i can see do_preempt_schedule() doesnt have these properties:
> what it guarantees is that it avoids the preemption recursion via the
> lowlevel code doing the PREEMPT_ACTIVE setting.
> 
> lets agree upon a single, common approach. I went for splitting up
> preempt_schedule() into two variants: the 'synchronous' one (called
> preempt_schedule()) is only called from syscall level and has no
> repeat-preemption and hence stack-recursion worries. The 'asynchronous'
> one (called preempt_schedule_irq()) is called from asynchronous contexts
> (hardirq events) and is fully ready to deal with all the reentrancy
> situations that may occur. It's careful about not re-enabling
> interrupts, etc.

Sure, I guessed that from your short description that it implies more
than the seperation I have done. I have no objection against your
approach at all.

tglx


