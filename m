Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263623AbVBCUs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbVBCUs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbVBCUso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:48:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14025 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263174AbVBCUse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:48:34 -0500
Date: Thu, 3 Feb 2005 21:47:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, "Jack O'Quin" <joq@io.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050203204711.GB25018@elte.hu>
References: <200502031420.j13EKwFx005545@localhost.localdomain> <4202876F.3010302@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4202876F.3010302@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> >	* real inter-process handoff. i am thinking of something like
> >	    sched_yield(), but it would take a TID as the target
> >	    of the yield. this would avoid all the crap we have to 
> >	    go through to drive the graph of clients with FIFO's and
> >	    write(2) and poll(2). Futexes might be a usable
> >	    approximation in 2.6 (we are supporting 2.4, so we can't
> >	    use them all the time)
> 
> yield_to(tid) should not be too hard to implement. Ingo? What do you
> think?

i dont really like it - it's really the wrong interface to use. Futexes
are a much better locking/signalling interface. yield_to() would not be
available in 2.4 either. If the apropriate pthread objects are used then
libpthread will do it more or less optimally on 2.4 too, while on 2.6
they'd be perfectly fine and based on futexes. If 2.4 is not an issue
then a good, futex-based inter-process API is POSIX 1003.1b semaphores
(the sem_init()/sem_*() APIs). But if it should work inter-process on
non-futex kernels too, then only pthread spinlocks will do it.

	Ingo
