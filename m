Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUHBHil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUHBHil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 03:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUHBHil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 03:38:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5772 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266327AbUHBHij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 03:38:39 -0400
Date: Mon, 2 Aug 2004 09:39:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
Message-ID: <20040802073938.GA8332@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <1091141622.30033.3.camel@mindpipe> <20040730064431.GA17777@elte.hu> <1091228074.805.6.camel@mindpipe> <1091234100.1677.41.camel@mindpipe> <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com> <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091407585.862.40.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> If we have any suspects for the code paths involved, couldn't this be
> verified by adding a udelay(10) to the path, and verifying that the
> hump moves by 10?  This technique could also be used to distinguish
> different code paths with similar execution times.  It looks like they
> are finite and few in number.

i believe wli's latency-timing patch gives a pretty good indication of
the code path(s) involved - i'm using something quite similar to that. 
The printout triggers immediately at the end of a high latency, so the
stack contains a number of clues about what went on before.

> At this point there are no latency problems I can see, all that
> remains is to understand the causes of the observed latencies.  Then
> assuming any "direct-irq" drivers and anything you run SCHED_FIFO is
> realtime safe, what else remains to be done in order to make hard
> realtime guarantees?

what remains i believe is to improve wli's patch and to observe (and
fix) the maximum latencies. Also, your workload is a subset of what
other people might be running so wider testing is obviously needed as
well.

btw., with what max_sectors setting were you testing during these tests? 
In -O2 the hardirqs are not preemptable (yet) so with 1024 sectors you
should see quite high latencies due to the completion activity.

	Ingo
