Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbULOPok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbULOPok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 10:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbULOPok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 10:44:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:3795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262368AbULOPoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 10:44:37 -0500
Date: Wed, 15 Dec 2004 07:44:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
In-Reply-To: <20041215085257.GA12545@elte.hu>
Message-ID: <Pine.LNX.4.58.0412150740050.3279@ppc970.osdl.org>
References: <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
 <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random>
 <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random>
 <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu>
 <20041214224706.GA26853@elte.hu> <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
 <20041215085257.GA12545@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Dec 2004, Ingo Molnar wrote:
> 
> i ran the stresstest overnight with the 10 KHz NMI, and not a single
> time did the new branch trigger, out of hundreds of millions of IRQs and
> NMIs. I think this suggests that the race doesnt exist in current CPUs.

That may well be true, but I'm not convinced your test is meaningful or 
shows anything.

The thing is, either the CPU is busy, or it's idle. If it's busy, you'll
never see this. And if it's idle, it will always be _in_ the "halt"  
instruction.

The only way to see the case is in the borderline cases, and if/when there
are multiple different interrupts (first non-NMI interrupt takes it out of
the hlt, and then the NMI happens to catch the sti). And quite frankly, I
don't see how you would stress-test it. A 1kHz timer interrupt with a
10kHz NMI interrupt is still very infrequent interrupts...

		Linus
