Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVA1EnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVA1EnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 23:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVA1EnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 23:43:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:35781 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261450AbVA1EnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 23:43:15 -0500
Date: Fri, 28 Jan 2005 05:43:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: George Anzinger <george@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
Subject: Re: High resolution timers and BH processing on -RT
Message-ID: <20050128044301.GD29751@elte.hu>
References: <1106871192.21196.152.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106871192.21196.152.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Some numbers to make this more transparent.
> 
> Machine: PIII Celeron 333MHz
> RT - T0: 1ms cyclic
> RT - T1: 2ms cyclic
> ....
> 
> Load average is ~4.0 for all tests. The numbers are maximum deviation
> from the timeline in microseconds. Test time was ~60 minutes for each
> szenario.
> 
> Running all timers in high resolution mode (ksoftirqd) results in:
> [T0  Prio:  60]  2123
> [T1  Prio:  59]  2556
> [T2  Prio:  58]  2882
> [T3  Prio:  57]  2993
> [T4  Prio:  56]  2888
> 
> Running all timers in high resolution mode (seperated timer softirqd
> PRIO=70) results in:
> [T0  Prio:  60]  423
> [T1  Prio:  59]  372
> [T2  Prio:  58]  756
> [T3  Prio:  57]  802
> [T4  Prio:  56]  1208

is this due to algorithmic/PIT-programming overhead, or due to the noise
introduced by other, non-hard-RT timers? I'd guess the later from the
looks of it, but did your test introduce such noise (via networking and
application workloads?).

	Ingo
