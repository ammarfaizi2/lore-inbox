Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUIBFdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUIBFdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUIBFdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:33:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:690 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267423AbUIBFdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:33:08 -0400
Date: Thu, 2 Sep 2004 07:34:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Thomas Charbonnel <thomas@undata.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
Message-ID: <20040902053445.GA12499@elte.hu>
References: <OFA48649D2.721211FD-ON86256F02.007CEFE1@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA48649D2.721211FD-ON86256F02.007CEFE1@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> One place where we may need to consider more mcount() calls is in the
> scheduler. I got another 500+ msec trace going from dequeue_task to
> __switch_to.

(you mean 500+ usec, correct?)

there's no way the scheduler can have 500 usecs of overhead going from
dequeue_task() to __switch_to(): we have all interrupts disabled and
take zero locks! This is almost certainly some hardware effect (i
described some possibilities and tests a couple of mails earlier).

In any case, please enable nmi_watchdog=1 so that we can see (in -Q7)
what happens on the other CPUs during such long delays.

> I also looked briefly at find_first_bit since it appears in a number
> of traces. Just curious, but the coding for the i386 version is MUCH
> different in style than several other architectures (e.g, PPC64,
> SPARC). Is there some reason why it is recursive on the x86 and a loop
> in the others?

what do you mean by recursive? It uses the SCAS (scan string) x86
instruction.

	Ingo
