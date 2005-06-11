Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVFKQ2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVFKQ2u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVFKQ2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:28:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54006 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261698AbVFKQ2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:28:36 -0400
Date: Sat, 11 Jun 2005 09:28:22 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <20050611135111.GB31025@elte.hu>
Message-ID: <Pine.LNX.4.10.10506110920250.27294-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2005, Ingo Molnar wrote:

> - for raw spinlocks i've reintroduced raw_local_irq primitives again.
>   This helped get rid of some grossness in sched.c, and the raw
>   spinlocks disable preemption anyway. It's also safer to just assume
>   that if a raw spinlock is used together with the IRQ flag that the
>   real IRQ flag has to be disabled.

I don't know about this one .. That grossness was there so people aren't
able to easily add new disable sections. 

Could we add a new raw_raw_spinlock_t that really disable interrupt , then
investigate each one . There are really only two that need it, runqueue
lock , and the irq descriptor lock . If you add it back for all raw types
you just add back more un-needed disable sections. The only way a raw lock
needs to disable interrupts is if it's possible to enter that region from
interrupt context .


Daniel


