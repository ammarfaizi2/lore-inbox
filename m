Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUIQGmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUIQGmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 02:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268476AbUIQGmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 02:42:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20680 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268474AbUIQGmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 02:42:05 -0400
Date: Fri, 17 Sep 2004 08:43:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: "David S. Miller" <davem@davemloft.net>, davidsen@tmr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040917064321.GA8146@elte.hu>
References: <m3vfefa61l.fsf@averell.firstfloor.org> <cic7f9$i4m$1@gatekeeper.tmr.com> <20040916222903.GA4089@nietzsche.lynx.com> <20040916154011.3f0dbd54.davem@davemloft.net> <20040916225102.GA4386@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916225102.GA4386@nietzsche.lynx.com>
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


* Bill Huey <bhuey@lnxw.com> wrote:

> Judging from how the Linux code is done and the numbers I get from
> Bill Irwin in casual conversation, the Linux SMP approach is clearly
> the right track at this time with it's hand honed per-CPU awareness of
> things. The only serious problem that spinlocks have as they aren't
> preemptable, which is what Ingo is trying to fix.

a clarification: note that the current BKL is a special case. No way do
i suggest that the BKS is the proper model for any SMP implementation.
It is a narrow special-case because it wraps historic UP-only kernel
code.

our primary multiprocessing primitives are still the following 4:
lockless data structures, RCU, spinlocks and mutexes. (reverse ordered
by level of parallelism.) The BKS is basically a fifth method, a special
type of semaphore that i'd never want to be seen used by any new SMP
code. It is completely local to sched.c.

	Ingo
