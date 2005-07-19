Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVGSNvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVGSNvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVGSNvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:51:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48285 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261254AbVGSNvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:51:49 -0400
Date: Tue, 19 Jul 2005 15:50:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Bill Huey <bhuey@lnxw.com>,
       Esben Nielsen <simlo@phys.au.dk>, Daniel Walker <dwalker@mvista.com>,
       Dave Chinner <dgc@sgi.com>, greg@kroah.com,
       Nathan Scott <nathans@sgi.com>, Steve Lord <lord@xfs.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: RT and XFS
Message-ID: <20050719135056.GA19552@elte.hu>
References: <20050714160835.GA19229@infradead.org> <Pine.OSF.4.05.10507171848440.14250-100000@da410.phys.au.dk> <20050719032624.GA22060@nietzsche.lynx.com> <20050719123457.GC12368@elte.hu> <20050719132750.GA20595@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719132750.GA20595@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jul 19, 2005 at 02:34:57PM +0200, Ingo Molnar wrote:
> > (I do disagree with Christoph on another point: i do think we eventually 
> > want to change the standard semaphore type in a similar fashion upstream 
> > as well - but that probably has to come with a s/struct semaphore/struct 
> > mutex/ change as well.)
> 
> Actually having a mutex_t in mainline would be a good idea even 
> without preempt rt, to document better what kind of locking we expect.

cool! I'll cook up a patch for that. Right now these are the numbers: 
there are 526 uses of struct semaphore in 2.6.12. In the -RT tree i had 
to change 23 of them to be compat_semaphore - i.e. 23 uses were 
definitely non-mutex.

(We sure have missed some cases - but it would be fair to say that the 
expected number of cases is less than 50, and that we've mapped the most 
common ones already. That makes it a 90%/10% splitup: more than 90% of 
all struct semaphore use is pure mutex.)

Of the remaining <10% cases, the majority is of the type of completions, 
and there are a handful of (<10) cases of 'counted semaphore' uses: 
semaphores with a count larger than 1. (e.g. ACPI uses it to count 
resources, some audio code too - but it's very rare) Btw., that's the 
only 'true' (in terms of CS) semaphore use.

	Ingo
