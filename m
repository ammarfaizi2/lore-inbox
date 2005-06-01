Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVFAVAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFAVAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFAU7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:59:23 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64975
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261244AbVFAUzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:55:52 -0400
Subject: Re: RT patch acceptance
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Karim Yaghmour <karim@opersys.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050601192224.GV5413@g5.random>
References: <20050601143202.GI5413@g5.random>
	 <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk>
	 <20050601150527.GL5413@g5.random> <429DD533.6080407@opersys.com>
	 <20050601153803.GO5413@g5.random>
	 <1117648391.20785.7.camel@tglx.tec.linutronix.de>
	 <20050601192224.GV5413@g5.random>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 01 Jun 2005 22:56:07 +0200
Message-Id: <1117659367.20785.20.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 21:22 +0200, Andrea Arcangeli wrote:
> On Wed, Jun 01, 2005 at 07:53:11PM +0200, Thomas Gleixner wrote:
> > Thank god thats not the case. We did a patent research on this last year
> > and the result was that you can replace the cli/sti by a software flag
> > in the OS itself without violating the patent.
> 
> Did you publish something about it (so that people won't have to do it
> over and over again)?

I have no permission from the customer who actually payed the survey to
publish the results yet. But I continue asking for it.

> > The combination of replacing it in the host OS and running said host OS
> > as an idle task of the underlying RTOS would violate the patent.
> > 
> > So if PREEMPT-RT would use a soft cli/sti emulation, no problem should
> > arise.
> 
> So I wonder why it doesn't do that and it leaves local_irq_disable
> uncovered making it a "metal hard" instead of "ruby hard" like rtai.

I have a slightly outdated patch with that around on top of RT, but it
introduces yet another level of ugliness. 
You must carefully identify the places where you really need the
hard_local_irq_dis/enable(). It's not hard though. 

I used it in the early days of PREEMPT_RT to identify the IRQ off
sections and some other deadlocking scenarios. I kept this always as an
option for adding on top of Ingos implementation to close the gap to
"ruby".

tglx


