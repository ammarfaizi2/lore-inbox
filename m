Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWDRQYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWDRQYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWDRQYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:24:40 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:13969 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750807AbWDRQYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:24:39 -0400
Subject: Re: [RT] bad BUG_ON in rtmutex.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1145376876.5447.58.camel@localhost.localdomain>
References: <1145324887.17085.35.camel@localhost.localdomain>
	 <1145362851.5447.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com>
	 <1145365886.5447.28.camel@localhost.localdomain>
	 <1145368228.17085.85.camel@localhost.localdomain>
	 <1145369381.5447.40.camel@localhost.localdomain>
	 <1145370733.17085.110.camel@localhost.localdomain>
	 <1145371913.5447.48.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604181058430.12720@gandalf.stny.rr.com>
	 <1145376876.5447.58.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 12:24:27 -0400
Message-Id: <1145377467.17085.133.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 09:14 -0700, Daniel Walker wrote:

> 
> > Actually, I always thought that running PREEMPT_DESKTOP with soft and hard
> > IRQS as threads was priority ceiling.  It's just that all locks have the
> > priority of MAX_RT_PRIO (no preemption allowed).  OK, this doesn't apply
> > to mutexes, but it does apply for spin_locks. :)
> 
> Interesting way to look at it .
> 
> Reminds me of the RT read/write locks, only one read or one writer at a
> time, so it's really just a mutex ..
> 

We'll read/write doesn't work well with PI (or latencies for that
matter).  But rw_locks have one advantage over normal rt_mutex, and that
is they are self recursive.  i.e. one rw_lock can be taken over and over
again (as read) by the same process, as long as it releases it the same
amount of times.

-- Steve


