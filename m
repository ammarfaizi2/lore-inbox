Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317539AbSGJJiZ>; Wed, 10 Jul 2002 05:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSGJJiY>; Wed, 10 Jul 2002 05:38:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10974 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317539AbSGJJiX>;
	Wed, 10 Jul 2002 05:38:23 -0400
Date: Thu, 11 Jul 2002 11:39:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: Re: O(1) scheduler "complex" macros
In-Reply-To: <Pine.LNX.4.44.0207111111280.6835-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207111137460.7442-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  #define task_running(rq, p) \
> 	((rq)->curr == (p)) && !spin_is_locked(&(p)->switch_lock)

one more implementational note: the above test is not 'sharp' in the sense
that on SMP it's only correct (the test has no barriers) if the runqueue
lock is held. This is true for all the critical task_running() uses in
sched.c - and the cases that use it outside the runqueue lock are
optimizations so they dont need an exact test.

	Ingo

