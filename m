Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268033AbUH3N1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268033AbUH3N1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUH3N1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:27:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41133 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268033AbUH3N1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:27:49 -0400
Date: Mon, 30 Aug 2004 15:29:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] cpu hotplug fixes for dependent_sleeper and wake_sleeping_dependent
Message-ID: <20040830132925.GA1531@elte.hu>
References: <1093858876.11274.50.camel@biclops.private.network>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093858876.11274.50.camel@biclops.private.network>
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


* Nathan Lynch <nathanl@austin.ibm.com> wrote:

> To recap, offlining a cpu with current bk results in the "Aiee,
> killing interrupt handler!" panic from do_exit().  This seems to be
> triggered only with CONFIG_PREEMPT and CONFIG_SCHED_SMT both enabled. 
> I believe the problem is that when do_stop() calls schedule(),
> dependent_sleeper() drops the "offline" cpu's rq->lock and never
> reacquires it.
> 
> The following seems to work (tested on ppc64).  Is there a better way?

> -	if (!(sd->flags & SD_SHARE_CPUPOWER))
> +	if (!(sd->flags & SD_SHARE_CPUPOWER) || cpu_is_offline(this_cpu))

> +	if (!(sd->flags & SD_SHARE_CPUPOWER) || cpu_is_offline(this_cpu))

it would really be nice to do this without any runtime overhead. Rusty?

	Ingo
