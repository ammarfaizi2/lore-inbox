Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUEXGmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUEXGmY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUEXGmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:42:23 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:3733 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261300AbUEXGmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:42:12 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 23 May 2004 23:41:20 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: scheduler: IRQs disabled over context switches
In-Reply-To: <20040524083715.GA24967@elte.hu>
Message-ID: <Pine.LNX.4.58.0405232340070.2676@bigblue.dev.mdolabs.com>
References: <20040523174359.A21153@flint.arm.linux.org.uk> <20040524083715.GA24967@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004, Ingo Molnar wrote:

> 
> * Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > The 2.6.6 scheduler disables IRQs across context switches, which is
> > bad news for IRQ latency on ARM - to the point where 16550A FIFO UARTs
> > to overrun.
> > 
> > I'm considering defining prepare_arch_switch & co as follows on ARM,
> > so that we release IRQs over the call to context_switch().
> 
> > The question is... why are we keeping IRQs disabled over
> > context_switch() in the first case?  Looking at the code, the only
> > thing which is touched outside of the two tasks is rq->prev_mm.  Since
> > runqueues are CPU- specific and we're holding at least one spinlock, I
> > think the above is preempt safe and SMP safe.
> 
> historically x86 context-switching has been pretty fragile when done
> with irqs enabled. (x86 has tons of legacy baggage, segments, etc.) It's
> also slightly faster to do the context-switch in one atomic swoop. On
> x86 we do this portion in like 1 usec so it's not a latency issue.

We used to do it in 2.4. What changed to make it fragile? The threading 
(TLS) thing?


- Davide

