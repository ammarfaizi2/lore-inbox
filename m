Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbULOIxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbULOIxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 03:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbULOIxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 03:53:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18599 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261811AbULOIxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 03:53:12 -0500
Date: Wed, 15 Dec 2004 09:52:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
Message-ID: <20041215085257.GA12545@elte.hu>
References: <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu> <20041214224706.GA26853@elte.hu> <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
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

> > find the correct patch below. I've tested it with an NMI watchdog
> > frequency artificially increased to 10 KHz, and i've instrumented the
> > new branch in the NMI handler, but even under heavy IRQ load i was not
> > able to trigger the branch. Maybe newer CPUs handle this case somehow
> > and make sti;hlt truly atomic?
> 
> Now that you mention it, I have this dim memory of the one-instruction
> "sti-shadow" actually disabling NMI's (and debug traps) too. The CPU
> literally doesn't test for async events following "sti". 

i ran the stresstest overnight with the 10 KHz NMI, and not a single
time did the new branch trigger, out of hundreds of millions of IRQs and
NMIs. I think this suggests that the race doesnt exist in current CPUs.

	Ingo
