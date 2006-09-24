Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752141AbWIXS5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbWIXS5P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbWIXS5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:57:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752141AbWIXS5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:57:14 -0400
Date: Sun, 24 Sep 2006 11:56:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Paul E McKenney <paulmck@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH] RCU: debug sleep check
Message-Id: <20060924115646.6b5b6482.akpm@osdl.org>
In-Reply-To: <20060924183509.GB22448@in.ibm.com>
References: <20060923152957.GA13432@in.ibm.com>
	<20060924183509.GB22448@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 00:05:09 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> Add a debug check for rcu read-side critical section code calling
> a function that might sleep which is illegal. The check is enabled only
> if CONFIG_DEBUG_SPINLOCK_SLEEP is set.
> 

Does this actually change anything?  rcu_read_lock is preempt_disable(), and
might_sleep() already triggers if called inside preempt_disable().

> -#define rcu_read_lock() __rcu_read_lock()
> +#define rcu_read_lock()	\
> +	do {	\
> +		rcu_add_read_count();	\
> +		__rcu_read_lock();	\

I don't have any __rcu_read_lock().  I guess this is against your
to-be-resent RCU patches?

> +DEFINE_PER_CPU(int, rcu_read_count);

Can have static scope.


