Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVFMH4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVFMH4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVFMH4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:56:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7920 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261420AbVFMHyg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:54:36 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10506130942140.10063-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506130942140.10063-100000@da410.phys.au.dk>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 00:53:16 -0700
Message-Id: <1118649197.5729.68.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 09:44 +0200, Esben Nielsen wrote:
> On Mon, 13 Jun 2005, Sven-Thorsten Dietrich wrote:
> 
> > On Sat, 2005-06-11 at 22:03 +0200, Ingo Molnar wrote:
> > > * Esben Nielsen <simlo@phys.au.dk> wrote:
> > > 
> > > > > the jury is still out on the accuracy of those numbers. The test had 
> > > > > RT_DEADLOCK_DETECT (and other -RT debugging features) turned on, which 
> > > > > mostly work with interrupts disabled. The other question is how were 
> > > > > interrupt response times measured.
> > > > > 
> > > > You would accept a patch where I made this stuff optional?
> > > 
> > > I'm not sure why. The soft-flag based local_irq_disable() should in fact 
> > > be a tiny bit faster than the cli based approach, on a fair number of 
> > > CPUs. But it should definitely not be slower in any measurable way.
> > > 
> > 
> > Is there any such SMP concept as a local_preempt_disable()  ?
> > 
> You must think of preempt_disable() ? Except for the interface is a little
> bit different using flags in local_irq_save(), preempt_disable() works
> exactly the same way, blocking for everything but interrupts - on the
> _local_ CPU. (Under PREEMPT_RT it ofcourse also blocks for threaded IRQ
> handlers.)

Doesn't preempt_disable() also block rescheduling on other CPUs?

We only need to prevent rescheduling on THIS CPU.



