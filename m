Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSFRUJo>; Tue, 18 Jun 2002 16:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317594AbSFRUJn>; Tue, 18 Jun 2002 16:09:43 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:61206 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317593AbSFRUJi>; Tue, 18 Jun 2002 16:09:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Robert Love <rml@tech9.net>, torvalds@transmeta.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-reply-to: Your message of "Tue, 18 Jun 2002 15:29:49 -0400."
             <20020618152949.B16091@redhat.com> 
Date: Wed, 19 Jun 2002 06:13:44 +1000
Message-Id: <E17KPMG-0003oZ-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020618152949.B16091@redhat.com> you write:
> On Wed, Jun 19, 2002 at 04:51:31AM +1000, Rusty Russell wrote:
> > You could do a loop here, but the real problem is the broken userspace
> > interface.  Can you fix this so it takes a single CPU number please?
> > 
> > ie.
> > 	/* -1 = remove affinity */
> > 	sys_sched_setaffinity(pid_t pid, int cpu);
> > 
> > This will work everywhere, and doesn't require userspace to know the
> > size of the cpu bitmask etc.
> 
> That doesn't work.  Think of SMT CPU pairs (aka HyperThreading) or 
> quads that share caches.

This is the NUMA "I want to be in this group" problem.  If you're
serious about this, you'll go for a sys_sched_groupaffinity call, or
add an extra arg to sys_sched_setaffinity, or simply use the top 16
bits of the cpu arg.

You will also add /proc/cpugroups or something to export this
information to users so there's a point.

Sorry, the current interface is insufficient for NUMA *and* is
impossible[1] for the user to use correctly.

Rusty.
[1] Defined as "too hard for them to ever do it properly"
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
