Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265424AbUF3Ken@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265424AbUF3Ken (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 06:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUF3Ken
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 06:34:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43491 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265424AbUF3Kel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 06:34:41 -0400
Date: Wed, 30 Jun 2004 12:35:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'andrebalsa@altern.org'" <andrebalsa@altern.org>,
       "'Richard E. Gooch'" <rgooch@atnf.csiro.au>,
       "'rml@tech9.net'" <rml@tech9.net>, "'akpm@osdl.org'" <akpm@osdl.org>,
       "'Con Kolivas'" <kernel@kolivas.org>
Subject: Re: Preemption of the OS system call due to expiration of the time-sl ice for: a) SCHED_NORMAL (aka SCHED_OTHER) b) SCHED_RR
Message-ID: <20040630103531.GA24347@elte.hu>
References: <313680C9A886D511A06000204840E1CF08F42FAE@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313680C9A886D511A06000204840E1CF08F42FAE@whq-msgusr-02.pit.comms.marconi.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Povolotsky, Alexander <Alexander.Povolotsky@marconi.com> wrote:

> Con - thanks for your kind answers !
> 
> Preemption (due to the expiration of the time-slice) of the process,
> while it executes OS system call, - by another process (of equal or
> higher priority) when running under following scheduling policies:
> 
>  a) SCHED_NORMAL (aka SCHED_OTHER)
>  b) SCHED_RR 
> 
> Is it possible in Linux 2.6 ? Linux 2.4 ?

this is possible in 2.6 in CONFIG_PREEMPT is on. There's no guaranteed
latency due to non-preemptability of interrupts and critical sections
but the practical latencies are well below 1 msec. A bad driver or some
rare codepath we missed could introduce long latencies - but these are
usually easy to fix.

The core 2.6 kernel itself is very latency-friendly, in a very
controlled hardware environment utilizing well-reviewed userspace code,
a slimmed down kernel, no block IO and no high-rate interrupt source
(other than the interrupt source the application cares about) i'd say
it's quite close to hard-RT: all kernel functions have bound latency,
'all' you have to take care of are latencies introduced by hardware
interrupts.

in 2.4 kernel-preemption is done too in lots of places conditionally
(cooperatively), by kernel code. Unlike 2.6 there's no forced preemption
of kernel code.

	Ingo
