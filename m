Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbTCIX7j>; Sun, 9 Mar 2003 18:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbTCIX7i>; Sun, 9 Mar 2003 18:59:38 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:34570
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262674AbTCIX7i>; Sun, 9 Mar 2003 18:59:38 -0500
Subject: Re: [PATCH] small fixes in brlock.h
From: Robert Love <rml@tech9.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.50.0303091901370.1464-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303091843250.1464-100000@montezuma.mastecende.com>
	 <1047254400.680.10.camel@phantasy.awol.org>
	 <Pine.LNX.4.50.0303091901370.1464-100000@montezuma.mastecende.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047255023.680.16.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 09 Mar 2003 19:10:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 19:03, Zwane Mwaikambo wrote:

> > 	cpu = smp_processor_id();
> > 	/* do not want to preempt here, but we can! */
> > 	preempt_disable();
> > 	_raw_read_lock(&__brlock_array[cpu][idx]);
> 
> How are we able to preempt there? Timer tick?

Yep.  Any interrupt, actually.

Or the reschedule IPI on SMP systems.

Kernel preemption off an interrupt is actually the most common (and the
ideal) place to preempt since an interrupt is usually what wakes up a
task off I/O and sets need_resched.  So kernel preemption lets us
reschedule the higher priority task the moment the interrupt wakes it
up.  Of course, if a lock is held, we have to wait till we drop it.

	Robert Love

