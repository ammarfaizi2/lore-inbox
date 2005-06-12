Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVFLKoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVFLKoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 06:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVFLKoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 06:44:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17360 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261822AbVFLKoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 06:44:05 -0400
Date: Sun, 12 Jun 2005 12:39:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zoltan Boszormenyi <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050612103913.GB10808@elte.hu>
References: <42AC0084.50502@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AC0084.50502@freemail.hu>
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


* Zoltan Boszormenyi <zboszor@freemail.hu> wrote:

> >does -48-13 work any better?
> >
> >	Ingo
> 
> x86-64 needs the attached patch to compile.

(patch MIA)

> Some drivers also fail to compile because of
> SPIN_LOCK_UNLOCKED changes, e.g. softdog and
> four files under net/atm. [...]

i'll fix those up.

> A question, though: why do you comment out the DMPS timer in 
> drivers/char/vt.c? Does it cause any problems? I applied the -RT tree 
> after the multiconsole patch and I had to modify those four chunks 
> manually.

this is a quick hack. The timer code is fully preemptible, but for 
debugging one wants to have a working printk from hardirq contexts too.  
I.e. the mod_timer()/del_timer() would print warnings on PREEMPT_RT. 
We'll need some other approach to solve this cleanly.

	Ingo
