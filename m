Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUH1Mez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUH1Mez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 08:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUH1Mez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 08:34:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60323 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263778AbUH1Mex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 08:34:53 -0400
Date: Sat, 28 Aug 2004 14:36:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: manas.saksena@timesys.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] PPC/PPC64 port of voluntary preempt patch
Message-ID: <20040828123622.GC17908@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <20040824195122.GA9949@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824195122.GA9949@yoda.timesys>
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


* Scott Wood <scott@timesys.com> wrote:

> Another thing that I forgot to mention is that I have some doubts as
> to the current generic_synchronize_irq() implementation.  Given that
> IRQs are now preemptible, a higher priority RT thread calling
> synchronize_irq can't just spin waiting for the IRQ to complete, as it
> never will (and it wouldn't be a great idea for non-RT tasks either). 
> I see that a do_hardirq() call was added, presumably to hurry
> completion of the interrupt, but is that really safe?  It looks like
> that could end up re-entering handlers, and you'd still have a
> partially executed handler after synchronize_irq() finishes (causing
> not only an extra end() call, but possibly code being executed after
> it's been unloaded, and other synchronization violations).
> 
> If I'm missing something, please let me know, but I don't see a good
> way to implement it without blocking for the IRQ thread's completion
> (such as with the per-IRQ waitqueues in M5).

agreed, this is a hole in generic_synchronize_irq(). I've added
handler-completion waitqueues to my current tree, it will show up in
-Q1.

	Ingo
