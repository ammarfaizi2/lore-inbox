Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUIOQAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUIOQAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUIOP5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:57:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35500 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265795AbUIOP5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:57:19 -0400
Date: Wed, 15 Sep 2004 17:58:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040915155836.GA11925@elte.hu>
References: <2EJTp-7bx-1@gated-at.bofh.it> <m3vfefa61l.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3vfefa61l.fsf@averell.firstfloor.org>
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


* Andi Kleen <ak@muc.de> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > the attached patch is a new approach to get rid of Linux's Big Kernel
> > Lock as we know it today.
> 
> Interesting approach. Did you measure what it does to context switch
> rates? Usually adding semaphores tends to increase them a lot.

not yet - i've coded it up today. Perhaps the lowlatency audio folks
(who are most interested in BKL-latency removal) could report some
numbers?

but as i've replied to Linus too, i believe that _if_ the context-switch
rate goes up then some piece of code uses the BKL way too often! So
having a semaphore here might in fact help fixing those rare cases.

> One minor comment only: 
> Please CSE "current" manually. It generates much better code
> on some architectures because the compiler cannot do it for you.

yeah, agreed, will do.

	Ingo
