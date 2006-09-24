Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWIXVo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWIXVo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWIXVo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:44:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751580AbWIXVo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:44:58 -0400
Date: Sun, 24 Sep 2006 14:44:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Paul E McKenney <paulmck@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH] RCU: debug sleep check
Message-Id: <20060924144440.ca7e6464.akpm@osdl.org>
In-Reply-To: <20060924213508.GG13432@in.ibm.com>
References: <20060923152957.GA13432@in.ibm.com>
	<20060924183509.GB22448@in.ibm.com>
	<20060924115646.6b5b6482.akpm@osdl.org>
	<20060924213508.GG13432@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 03:05:08 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> On Sun, Sep 24, 2006 at 11:56:46AM -0700, Andrew Morton wrote:
> > On Mon, 25 Sep 2006 00:05:09 +0530
> > Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > 
> > > Add a debug check for rcu read-side critical section code calling
> > > a function that might sleep which is illegal. The check is enabled only
> > > if CONFIG_DEBUG_SPINLOCK_SLEEP is set.
> > > 
> > 
> > Does this actually change anything?  rcu_read_lock is preempt_disable(), and
> > might_sleep() already triggers if called inside preempt_disable().
> 
> It makes a difference if CONFIG_PREEMPT=n. AFAICS, preempt_disable()
> is a nop then and rcu needs its own check for sleeping while
> in read-side critical section.

Right.  I think enough people run with CONFIG_PREEMPT=y to make this
change rather unnecessary.

And if there are developers out there who are testing their code without an
effective CONFIG_DEBUG_SPINLOCK_SLEEP, then *that* is what we need to fix,
no?

