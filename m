Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSGXIEW>; Wed, 24 Jul 2002 04:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSGXIEW>; Wed, 24 Jul 2002 04:04:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:909 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318266AbSGXIEV>;
	Wed, 24 Jul 2002 04:04:21 -0400
Date: Wed, 24 Jul 2002 10:06:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
       george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruptionin2.5.27?]
In-Reply-To: <20020724080329.GB25038@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0207241003570.7635-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, William Lee Irwin III wrote:

> Since we're on the subject of preempt_schedule() being done at
> inappropriate times, I'm seeing it being called and panicking the
> machine before the per-cpu GDT, IDT, TSS, and LDT are loaded in
> cpu_init() and suspect that may be a wee bit too early to be sane.

i've fixed this in my tree: the init thread needs to start up with a
nonzero preempt_count, and schedule_init() sets it to 0. [schedule_init()  
is the point after we can schedule.]

	Ingo

