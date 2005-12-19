Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVLSQ4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVLSQ4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVLSQ4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:56:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14720 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964825AbVLSQ4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:56:36 -0500
Date: Mon, 19 Dec 2005 17:55:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219165552.GA8635@elte.hu>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <Pine.LNX.4.58.0512190744350.9001@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512190744350.9001@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > The numbers make me suspect that Ingo's mutexes are unfair too, but I've
> > not looked at the code yet.
> 
> Yes, Ingo's code does act like this unfairness.  Interesting also is 
> that Ingo's original code for his rt_mutexes was fair, and it killed 
> performance for high priority processes.  I introduced a "lock 
> stealing" algorithm that would check if the process trying to grab the 
> lock again was a higher priority then the one about to get it, and if 
> it was, it would "steal" the lock from it unfairly as you said.

yes, it's unfair - but stock semaphores are unfair too, so what i've 
measured is still a fair comparison of the two implementations.

lock stealing i've eliminated from this patch-queue, and i've moved the 
point of acquire to after the schedule(). (lock-stealing is only 
relevant for PI, where we always need to associate an owner with the 
lock, hence we pass ownership at the point of release.)

> Now, you are forgetting about PREEMPT.  Yes, on multiple CPUs, and 
> that is what Ingo is testing, to wait for the other CPU to schedule in 
> and run is probably not as bad as with PREEMPTION. (Ingo, did you have 
> preemption on in these tests?). [...]

no, CONFIG_PREEMPT was disabled in every test result i posted. (but i 
get similar results even with it enabled.)

	Ingo
