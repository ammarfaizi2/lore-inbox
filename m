Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUIOTix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUIOTix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUIOTic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:38:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4770 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267350AbUIOThs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:37:48 -0400
Date: Wed, 15 Sep 2004 21:39:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040915193911.GA17052@elte.hu>
References: <20040915155555.GA11019@elte.hu> <Pine.GSO.4.33.0409151300280.10693-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0409151300280.10693-100000@sweetums.bluetronic.net>
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


* Ricky Beam <jfbeam@bluetronic.net> wrote:

> On Wed, 15 Sep 2004, Ingo Molnar wrote:
> >yes, but progress in this area seems to have slowed down, and people are
> >hurting from the latencies introduced by the BKL meanwhile. Who cares if
> >some rare big chunk of code runs under a semaphore, as long as it's
> >preemptable?
> 
> "as long as it's preemptable" is the key there.  Not all arch's can
> run with PREEMPT enabled (yet) -- sparc/sparc64 for but one.  And at
> the moment, PREEMPT is a bit on the hosed side.

there's no problem at all - with my patch you'll still get the other
advantage:

- there is no time wasted spinning on the BKL if there's BKL contention

so if a platform doesnt support PREEMPT (or a user doesnt enable it)
then BKS-holding kernel code wont be preempted of course.

	Ingo
