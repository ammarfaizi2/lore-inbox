Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVFMJRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVFMJRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 05:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVFMJRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 05:17:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51399 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261441AbVFMJQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 05:16:57 -0400
Date: Mon, 13 Jun 2005 11:13:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050613091309.GA21318@elte.hu>
References: <1118649905.5729.76.camel@sdietrich-xp.vilm.net> <Pine.OSF.4.05.10506131043300.10063-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506131043300.10063-100000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> I will also try to make a lock which introduces the "notion of 
> locallity" (i.e. have the same semantics as a normal spin_lock/mutex) 
> into the code, but in !PREEMPT_RT will turn out to be just 
> local_irq_disable() or preempt_disable(). A lot of the 
> local_irq_disable() should be replaced with that.

yes, this would be the right approach. Note that we already do something 
like that in the per_cpu_locked API, we hide a spinlock there, which 
gets turned off for !PREEMPT_RT. For local_irq_disable() replacements 
we'd need a separate API.

(one thing to watch out for are smp_call_function() handlers. These 
still execute in hardirq context even on PREEMPT_RT. E.g. in buffer.c 
you'll see such code.)

	Ingo
