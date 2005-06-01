Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVFAVhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVFAVhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFAVeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:34:50 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21876
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261184AbVFAUom
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:44:42 -0400
Date: Wed, 1 Jun 2005 22:44:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Karim Yaghmour <karim@opersys.com>,
       Esben Nielsen <simlo@phys.au.dk>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601204430.GA5413@g5.random>
References: <20050601143202.GI5413@g5.random> <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk> <20050601150527.GL5413@g5.random> <429DD533.6080407@opersys.com> <20050601153803.GO5413@g5.random> <1117648391.20785.7.camel@tglx.tec.linutronix.de> <20050601192224.GV5413@g5.random> <20050601193906.GA26939@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601193906.GA26939@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 09:39:06PM +0200, Ingo Molnar wrote:
> yes. As i said in an earlier mail:
> 
> > > (there are still some ways to introduce latencies into PREEMPT_RT, 
> > > but they are not common and we are working on ways to cover them
> > > all.)
>  
> local_irq_disable() is one way, preempt_disable() is another way. Adding 

btw, I didn't mention preempt_disable because that really is called a
pair of times in the whole drivers.

> asm("cli") to your driver is a third way. In practice these items are 
> not a big issue, so i'm not yet covering them. It's a small detail.  
> Check the amount of local-irq-disable instances in the driver space vs.  
> spinlock use.

It's not as frequent like spin_lock_irq, but it's still a relevant
driver API (unlike preempt_disable). So I think it worth fixing to
really provide the same guarantees as RTAI and rtlinux.
