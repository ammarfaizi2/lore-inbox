Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262753AbSJCGi1>; Thu, 3 Oct 2002 02:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262756AbSJCGi1>; Thu, 3 Oct 2002 02:38:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18123 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262753AbSJCGi0>;
	Thu, 3 Oct 2002 02:38:26 -0400
Date: Thu, 3 Oct 2002 08:54:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: colpatch@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] kernel/sched.c oddness?
In-Reply-To: <3D9B89FD.1060400@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0210030840110.4477-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [...] However, I noticed on my 2xSMP system that quite unbalanced loads
> weren't getting even CPU time best example - 3 processes in busywait
> loops - one would get 100% of one cpu while two would get 50% each of
> the other.

this was done intentionally, and this scenario (1+2 tasks) is the very
worst scenario. The problem is that by trying to balance all 3 tasks we
now have 3 tasks that trash their cache going from one CPU to another.  
(this is what happens with your patch - even with another approach we'd
have to trash at least one task)

By keeping 2 tasks on one CPU and 1 task on the other CPU we avoid
cross-CPU migration of threads. Think about the 2+3 or 4+5 tasks case
rather, do we want absolutely perfect balancing, or good SMP affinity and
good combined performance?

	Ingo

