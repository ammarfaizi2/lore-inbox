Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVFKR2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVFKR2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVFKR1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:27:55 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:54965
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261755AbVFKRZx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:25:53 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
In-Reply-To: <Pine.LNX.4.10.10506110930050.27294-100000@godzilla.mvista.com>
References: <Pine.LNX.4.10.10506110930050.27294-100000@godzilla.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 11 Jun 2005 19:26:57 +0200
Message-Id: <1118510817.13312.88.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 09:36 -0700, Daniel Walker wrote:
> 
> On Sat, 11 Jun 2005, Esben Nielsen wrote:
> 
> > For me it is perfectly ok if RCU code, buffer caches etc use
> > raw_local_irq_disable(). I consider that code to be "core" code.
> 
> This distinction seem completly baseless to me. Core code doesn't
> carry any weight . The question is , can the code be called from real
> interrupt context ? If not then don't protect it.
> 
> > 
> > The current soft-irq states only gives us better hard-irq latency but
> > nothing else. I think the overhead runtime and the complication of the
> > code is way too big for gaining only that. 
> 
> Interrupt response is massive, check the adeos vs. RT numbers . They did
> one test which was just interrupt latency.

Performance on RT systems is more than IRQ latencies. 

The wide spread misbelief that 
  "Realtime == As fast as possible" 

seems to be still stuck in peoples mind.

  "Realtime == As fast as specified"
is the correct equation.

There is always a tradeoff between interrupt latencies and other
performance values, as you have to invent new mechanisms to protect
critical sections. In the end, they can be less effective than the gain
on irq latencies.

While working on high resolution timers on top of RT, I can prove that
changing a couple of shortheld spinlocks  into raw locks (with hardirq
disable), results in 50-80% latency improvement of the scheduled tasks
but increases the interrupt latency by only 5-10%. The differrent
numbers are related to different CPUs (x86/PPC,ARM). 

tglx


