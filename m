Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUGWFrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUGWFrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 01:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUGWFrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 01:47:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7041 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267553AbUGWFrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 01:47:46 -0400
Date: Fri, 23 Jul 2004 07:47:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040723054735.GA14108@elte.hu>
References: <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721154428.GA24374@elte.hu> <40FF48F9.1020004@yahoo.com.au> <20040722070743.GA7553@elte.hu> <40FF9CD1.7050705@yahoo.com.au> <20040722162357.GB23972@elte.hu> <41003BA3.70806@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41003BA3.70806@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >this doesnt work either: once we've committed ourselves to do an
> >'immediate' softirq processing pass we are risking latencies. We cannot
> >preempt the idle task while it's processing softirqs the same way we can
> >do the lock-break if they are always deferred.
> >
> 
> It is a preempt off region no matter where it is run. I don't see how
> moving it to ksoftirqd can shorten that time any further.

look at my latest patches to see how it's done. We can preempt softirq
handlers via lock-break methods. The same method doesnt work in the idle
thread. With this method i've reduced worst-case softirq latencies from
~2-4 msecs to 100-200 usecs on a 2GHz x86 box.

	Ingo
