Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbULNX2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbULNX2C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbULNXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:15:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:32158 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261755AbULNXKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:10:14 -0500
Date: Tue, 14 Dec 2004 15:09:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
In-Reply-To: <20041214224706.GA26853@elte.hu>
Message-ID: <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
References: <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com>
 <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com>
 <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
 <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random>
 <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random>
 <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu>
 <20041214224706.GA26853@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Ingo Molnar wrote:
> 
> find the correct patch below. I've tested it with an NMI watchdog
> frequency artificially increased to 10 KHz, and i've instrumented the
> new branch in the NMI handler, but even under heavy IRQ load i was not
> able to trigger the branch. Maybe newer CPUs handle this case somehow
> and make sti;hlt truly atomic?

Now that you mention it, I have this dim memory of the one-instruction
"sti-shadow" actually disabling NMI's (and debug traps) too. The CPU 
literally doesn't test for async events following "sti". 

Or maybe that was "mov->ss". That one also has that strange "black hole"  
for one instruction.

Hmm.. You could be evil and try to fill up 64kB worth of memory with a 
"mov %ax,%ss", and jump to it in vm86 mode and see what happens. The eip 
will just keep wrapping around...

		Linus
