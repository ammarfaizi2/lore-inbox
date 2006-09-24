Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWIXV7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWIXV7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWIXV7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:59:07 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:55971 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751643AbWIXV7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:59:04 -0400
Date: Mon, 25 Sep 2006 03:28:52 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul E McKenney <paulmck@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH] RCU: debug sleep check
Message-ID: <20060924215851.GH13432@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060923152957.GA13432@in.ibm.com> <20060924183509.GB22448@in.ibm.com> <20060924115646.6b5b6482.akpm@osdl.org> <20060924213508.GG13432@in.ibm.com> <20060924144440.ca7e6464.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924144440.ca7e6464.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 02:44:40PM -0700, Andrew Morton wrote:
> On Mon, 25 Sep 2006 03:05:08 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > On Sun, Sep 24, 2006 at 11:56:46AM -0700, Andrew Morton wrote:
> > > 
> > > Does this actually change anything?  rcu_read_lock is preempt_disable(), and
> > > might_sleep() already triggers if called inside preempt_disable().
> > 
> > It makes a difference if CONFIG_PREEMPT=n. AFAICS, preempt_disable()
> > is a nop then and rcu needs its own check for sleeping while
> > in read-side critical section.
> 
> Right.  I think enough people run with CONFIG_PREEMPT=y to make this
> change rather unnecessary.

I would mostly agree except that for the rcupreempt (-rt) implementation
we don't use preempt_disable/enable in rcu read-side critical section.
So, I have to add a rcu_read_in_atomic() API anyway and there is
no harm in adding the same for rcuclassic (current default)
so that sleeping-while-rcu-atomic check happens irrespective
of CONFIG_PREEMPT. It is included only if CONFIG_DEBUG_SPINLOCK_SLEEP=y.

> 
> And if there are developers out there who are testing their code without an
> effective CONFIG_DEBUG_SPINLOCK_SLEEP, then *that* is what we need to fix,
> no?

Yes. With this patch, I am relying on people to test their
code with CONFIG_DEBUG_SPINLOCK_SLEEP so that we can catch
bad rcu users.

Thanks
Dipankar

