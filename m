Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbULOQge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbULOQge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbULOQge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:36:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64181 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262384AbULOQgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:36:15 -0500
Date: Wed, 15 Dec 2004 17:35:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
Message-ID: <20041215163541.GA29127@elte.hu>
References: <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu> <20041214224706.GA26853@elte.hu> <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org> <20041215085257.GA12545@elte.hu> <Pine.LNX.4.58.0412150740050.3279@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412150740050.3279@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Wed, 15 Dec 2004, Ingo Molnar wrote:
> > 
> > i ran the stresstest overnight with the 10 KHz NMI, and not a single
> > time did the new branch trigger, out of hundreds of millions of IRQs and
> > NMIs. I think this suggests that the race doesnt exist in current CPUs.
> 
> That may well be true, but I'm not convinced your test is meaningful
> or shows anything.
> 
> The thing is, either the CPU is busy, or it's idle. If it's busy,
> you'll never see this. And if it's idle, it will always be _in_ the
> "halt" instruction.

i deliberately started a test where there was roughly 50% idle time.

> The only way to see the case is in the borderline cases, and if/when
> there are multiple different interrupts (first non-NMI interrupt takes
> it out of the hlt, and then the NMI happens to catch the sti). And
> quite frankly, I don't see how you would stress-test it. A 1kHz timer
> interrupt with a 10kHz NMI interrupt is still very infrequent
> interrupts...

i started an infinite loop that generated disk IRQs, and started a
network test that generated network IRQs. The IRQ rate was roughly
10K/sec - this combined with the 10K/sec NMI rate should be an adequate
mix. (I also made sure that it's really default_idle that is used.)

	Ingo
