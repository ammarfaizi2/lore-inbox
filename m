Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTEHGyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 02:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTEHGyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 02:54:12 -0400
Received: from dp.samba.org ([66.70.73.150]:35263 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261190AbTEHGyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 02:54:11 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: rml@tech9.net, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] How to write a portable "run_on" program? 
In-reply-to: Your message of "Wed, 07 May 2003 22:31:43 MST."
             <Pine.LNX.4.44.0305072221120.16772-100000@home.transmeta.com> 
Date: Thu, 08 May 2003 17:00:24 +1000
Message-Id: <20030508070647.E83062C052@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0305072221120.16772-100000@home.transmeta.com> you write:
> In other words, the proper way to do set_cpu() is
> 
> 	int set_cpu(int cpu)
> 	{
> 		fd_set cpuset;
> 
> 		FD_ZERO(&cpuset);
> 		FD_SET(cpu, cpuset);
> 		return sched_setaffinity(getpid(), sizeof(cpuset), &cpuset);
> 	}
> 
> which is a HELL OF A LOT more readable than the crap you're spouting 
> (either your "before" _or_ your "after" crap).

Sorry, I remember your solution now.  You're absolutely right (still).

I preferred the "include/exclude" flag, which covers the "what to do
when cpus come online/go offline" as well as the size issue, but
that's personal preference.

However, I shall dutifully attack the glibc people for this, then
(/usr/include/sched.h):

#ifdef __USE_GNU
/* Set the CPU affinity for a task */
extern int sched_setaffinity (__pid_t __pid, unsigned long int __len,
			      unsigned long int *__mask) __THROW;

/* Get the CPU affinity for a task */
extern int sched_getaffinity (__pid_t __pid, unsigned long int __len,
			      unsigned long int *__mask) __THROW;
#endif

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
