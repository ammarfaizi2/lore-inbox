Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVA1IYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVA1IYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVA1IYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:24:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:29857 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261177AbVA1IYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:24:50 -0500
Date: Fri, 28 Jan 2005 09:24:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: George Anzinger <george@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
Subject: Re: High resolution timers and BH processing on -RT
Message-ID: <20050128082439.GA3984@elte.hu>
References: <1106871192.21196.152.camel@tglx.tec.linutronix.de> <20050128044301.GD29751@elte.hu> <1106900411.21196.181.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106900411.21196.181.camel@tglx.tec.linutronix.de>
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

> > is this due to algorithmic/PIT-programming overhead, or due to the noise
> > introduced by other, non-hard-RT timers? I'd guess the later from the
> > looks of it, but did your test introduce such noise (via networking and
> > application workloads?).
> 
> Right, it's due to noise by non-RT timers, which I enforced by adding
> networking and applications.
> 
> This adds random timer expires and admittedly the PIT reprogramming
> overhead is adding portions of that noise.

i havent seen your latest code - what is the basic data-structure? The
stock kernel has arrays of timers with increasing granularity and a
cascade mechanism to move timers down the arrays as they slowly expire -
but with a high-resolution API (1 usec accuracy?) how does the basic
data structure look like?

Is the "noise" due to timers expiring "at once" - but isnt it unlikely
for 'normal' timers to expire in exactly the same usec as the real
high-resolution one?

or is it that we have a 'group' of normal timers expiring, which, if
they happen to occur _just_ prior a HRT event will generate a larger
delay?

	Ingo
