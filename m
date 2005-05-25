Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVEYLgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVEYLgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVEYLgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:36:31 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:41647 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262204AbVEYLgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:36:18 -0400
Date: Wed, 25 May 2005 13:35:26 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: john cooper <john.cooper@timesys.com>
Cc: Sven Dietrich <sdietrich@mvista.com>, Andrew Morton <akpm@osdl.org>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       mingo@elte.hu, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <4293F580.3010601@timesys.com>
Message-Id: <Pine.OSF.4.05.10505251323490.28057-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2005, john cooper wrote:

> [...] 
> I'd like to hear some technical arguments of why IRQ threads
> are held with such suspicion.  Also it isn't the case prior
> mechanisms are being obsoleted.   Exception context interrupt
> processing and raw_spinlocks to synchronize with them are
> still available and will be for those edge cases which
> are not addressable via spinlock-mutexes.
>

Performance! Even on RT systems you do NOT make all interrupts run in
threads. Simple devices like UARTS run everything in interrupt context.
Introducing a context switch for every character received on such a
channel can be _very_ expensive.

I think it would be safe to convert almost every driver back to run in
exception context and use raw spinlocks for locking accordingly. Very few
driver actually does a lot of work on the interrupt level. Only those
devices high bandwidth and no DMA is a problem (old IDE and ethernet
devices spring to mind).

Therefore a framework where it can be configured per device would be the
ideal solution.

I do not know the structure of the code very well and I do not have any
time to look into it now. But I could imagine kbuild can be set up to
change the relavant between being a mutex and a raw spinlocks depending on
which code runs in exception context or in a thread.

> -john
> 
> 

Esben


