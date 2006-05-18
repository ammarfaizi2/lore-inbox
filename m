Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWERH6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWERH6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWERH6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:58:19 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4002 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751160AbWERH6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:58:18 -0400
Date: Thu, 18 May 2006 09:58:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       mingo@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][-rt PATCH] Try to safely error out when mixing pi/non-pi futex operations on the same futex.
Message-ID: <20060518075810.GB30387@elte.hu>
References: <1147900129.9363.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147900129.9363.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> Ingo,
> 	We've been seeing some oopses because there are waiters on pi 
> futexes that do not have pi_states. This seems to be because they were 
> used w/ futex_wait in one path and futex_lock_pi in another.

indeed, that's a bug.

> I'm told this shouldn't ever happen, but if it did, the kernel should 
> safely error out, instead of oopsing or never releasing a lock.
> 
> Not sure if this is a solid fix (it does build and boot), but 
> hopefully it will stir up some discussion.

applied. I made some small fixes: i made the printk rate-limited and 
dependent on CONFIG_DEBUG_RT_MUTEXES. The right thing is indeed to 
-EINVAL.

	Ingo
