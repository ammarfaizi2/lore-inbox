Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWCZDHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWCZDHi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 22:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWCZDHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 22:07:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751477AbWCZDHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 22:07:37 -0500
Date: Sat, 25 Mar 2006 19:03:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       arjan@infradead.org
Subject: Re: [patch 04/10] PI-futex: scheduler support for PI
Message-Id: <20060325190349.6b8fe5f3.akpm@osdl.org>
In-Reply-To: <20060325184605.GE16724@elte.hu>
References: <20060325184605.GE16724@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> From: Ingo Molnar <mingo@elte.hu>
> 
> add framework to boost/unboost the priority of RT tasks.
> 
> This consists of:
> 
>  - caching the 'normal' priority in ->normal_prio
>  - providing a functions to set/get the priority of the task
>  - make sched_setscheduler() aware of boosting
> 
> ...
>
> +#ifdef CONFIG_RT_MUTEXES
> +
> +/*
> + * rt_mutex_setprio - set the current priority of a task
> + * @p: task
> + * @prio: prio value (kernel-internal form)
> + *
> + * This function changes the 'effective' priority of a task. It does
> + * not touch ->normal_prio like __setscheduler().
> + *
> + * Used by the rt_mutex code to implement priority inheritance logic.
> + */
> +void rt_mutex_setprio(task_t *p, int prio)
> +{

This function is not really rt-mutex-related at all, is it?  It's just a
piece of new scheduler functionality which various things might use.

If so, it should be named something non-mutexy and should be under a
different CONFIG_option which CONFIG_RT_MUTEXES selects.

Of course, we can do all that later on, if/when something else needs this
facility.

