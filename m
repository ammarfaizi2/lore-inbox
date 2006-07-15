Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945941AbWGOBbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945941AbWGOBbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 21:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945962AbWGOBbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 21:31:40 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:55668 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1945941AbWGOBbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 21:31:39 -0400
From: David Brownell <david-b@pacbell.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2.6.18-rc1] genirq: {en,dis}able_irq_wake() need refcounting too
Date: Fri, 14 Jul 2006 18:31:34 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
       mingo@redhat.com, Andrew Victor <andrew@sanpeople.com>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
References: <200607091458.52298.david-b@pacbell.net> <20060710085849.GA6016@elte.hu>
In-Reply-To: <20060710085849.GA6016@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607141831.35311.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 July 2006 1:58 am, Ingo Molnar wrote:
> 
> * David Brownell <david-b@pacbell.net> wrote:
> 
> > It's not just "normal" mode operation that needs refcounting for the 
> > {en,dis}able_irq() calls ... "wakeup" mode calls need it too, for the 
> > very same reasons.
> > 
> > This patch adds that refcounting.  I expect that some ARM drivers will 
> > be triggering the new warning, but this call isn't yet widely used. 
> > (Which is probably why the bug has lingered this long...)
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> we should also add disable_irq_wake() / enable_irq_wake() APIs and start 
> migrating most ARM users over to the new APIs, agreed? That makes the 
> APIs more symmetric and the code more readable too.

To recap, the driver code _is_ that symmetric, it's just the implementation
that's asymmetric.  That is, {en,dis}able_irq() are two separate routines,
while {en,dis}able_irq_wake() are just wrap set_irq_wake().

I'll forward this patch to the the ARM kernel list, to help avoid surprises.
There aren't many in-tree drivers using these calls.

- Dave

