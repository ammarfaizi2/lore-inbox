Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVFMH7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVFMH7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVFMH7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:59:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44218 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261419AbVFMH7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:59:51 -0400
Date: Mon, 13 Jun 2005 09:56:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050613075635.GA16151@elte.hu>
References: <Pine.OSF.4.05.10506130942140.10063-100000@da410.phys.au.dk> <1118649197.5729.68.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118649197.5729.68.camel@sdietrich-xp.vilm.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sven-Thorsten Dietrich <sdietrich@mvista.com> wrote:

> > > Is there any such SMP concept as a local_preempt_disable()  ?
> > > 
> > You must think of preempt_disable() ? Except for the interface is a little
> > bit different using flags in local_irq_save(), preempt_disable() works
> > exactly the same way, blocking for everything but interrupts - on the
> > _local_ CPU. (Under PREEMPT_RT it ofcourse also blocks for threaded IRQ
> > handlers.)
> 
> Doesn't preempt_disable() also block rescheduling on other CPUs?
> 
> We only need to prevent rescheduling on THIS CPU.

it doesnt. It's 2-4 instructions similar to the assembly i posted 
before, changing current_thread_info->preempt_count, nothing else.

	Ingo
