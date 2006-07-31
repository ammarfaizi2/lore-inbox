Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWGaL4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWGaL4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 07:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWGaL4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 07:56:08 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17028 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750856AbWGaL4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 07:56:06 -0400
Date: Mon, 31 Jul 2006 13:49:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christian Borntraeger <borntrae@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] bug in futex unqueue_me
Message-ID: <20060731114931.GA2003@elte.hu>
References: <200607271841.56342.borntrae@de.ibm.com> <20060730063821.GA8748@elte.hu> <200607311004.15878.borntrae@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607311004.15878.borntrae@de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christian Borntraeger <borntrae@de.ibm.com> wrote:

> On Sunday 30 July 2006 08:38, Ingo Molnar wrote:
> > interesting, how is this possible? We do a spin_lock(lock_ptr), and
> > taking a spinlock is an implicit barrier(). So gcc must not delay
> > evaluating lock_ptr to inside the critical section. And as far as i can
> > see the s390 spinlock implementation goes through an 'asm volatile'
> > piece of code, which is a barrier already. So how could this have
> > happened?
> 
> spin_lock is a barrier, but isnt the barrierness too late here? The 
> compiler reloads the value of lock_ptr after the "if(lock_ptr)" and 
> *before* calling spin_lock(lock_ptr):

ah, indeed. So your patch is a real fix. Thanks,

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
