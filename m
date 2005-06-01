Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVFATko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVFATko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVFATkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:40:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63204 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261362AbVFATj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:39:56 -0400
Date: Wed, 1 Jun 2005 21:39:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Karim Yaghmour <karim@opersys.com>,
       Esben Nielsen <simlo@phys.au.dk>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601193906.GA26939@elte.hu>
References: <20050601143202.GI5413@g5.random> <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk> <20050601150527.GL5413@g5.random> <429DD533.6080407@opersys.com> <20050601153803.GO5413@g5.random> <1117648391.20785.7.camel@tglx.tec.linutronix.de> <20050601192224.GV5413@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601192224.GV5413@g5.random>
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

> > So if PREEMPT-RT would use a soft cli/sti emulation, no problem should
> > arise.
> 
> So I wonder why it doesn't do that and it leaves local_irq_disable
> uncovered [...]
>
> Perhaps that's planned and not yet implemented?

yes. As i said in an earlier mail:

> > (there are still some ways to introduce latencies into PREEMPT_RT, 
> > but they are not common and we are working on ways to cover them
> > all.)
 
local_irq_disable() is one way, preempt_disable() is another way. Adding 
asm("cli") to your driver is a third way. In practice these items are 
not a big issue, so i'm not yet covering them. It's a small detail.  
Check the amount of local-irq-disable instances in the driver space vs.  
spinlock use.

	Ingo
