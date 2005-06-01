Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVFAOt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVFAOt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVFAOtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:49:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48831 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261398AbVFAOra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:47:30 -0400
Date: Wed, 1 Jun 2005 16:45:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601144544.GA13936@elte.hu>
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601143202.GI5413@g5.random>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> > you are wrong. This codepath is not running with interrupts disabled on 
> > PREEMPT_RT. irqs-off spinlocks dont turn off interrupts on PREEMPT_RT.  
> 
> Then I'm afraid preempt-RT infringe on the patent [...]

i'd have expected you to say "oops, i was wrong, thanks for the 
explanation", but now you come up with a completely nontechnical topic 
instead?

> > (there are still some ways to introduce latencies into PREEMPT_RT, but 
> > they are not common and we are working on ways to cover them all.)
> 
> How can you schedule a task while a spinlock is held? Ok irqs will 
> keep going, but how can you reschedule risking to deadlock? As long as 
> there are regular spinlocks in any driver out there (i.e. all of them) 
> then you can still introduce latencies. It doesn't seem too uncommon 
> to me to take a spinlock. [...]

yes, and everything works just fine, if it's deadlock-free under normal 
SMP Linux. The key to that is that the whole execution flow is 'flat'.  
I.e. _all_ driver code (except a few notable exceptions that dont count) 
runs in a thread context. So spinlocks are _never_ recursively taken by 
the same thread under PREEMPT_RT - and the scheduler sorts out all the 
inter-thread blocking.

This is the basic concept of PREEMPT_RT. [ I have to say that I'm happy 
that while you have already written 12 emails into this thread with a 
seemingly firm and competent opinion - arguing against various aspects 
of PREEMPT_RT - today you finally seem to have gotten closer to 
understanding its basics ;-) ]

	Ingo
