Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVAEPsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVAEPsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVAEPio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:38:44 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4229 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262470AbVAEPT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:19:58 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20050105115213.GA17816@elte.hu>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us>
	 <1104865198.8346.8.camel@krustophenia.net>
	 <1104878646.17166.63.camel@localhost.localdomain>
	 <20050104175043.H469@build.pdx.osdl.net>
	 <1104890131.18410.32.camel@krustophenia.net>
	 <20050105115213.GA17816@elte.hu>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 10:19:53 -0500
Message-Id: <1104938394.8589.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 12:52 +0100, Ingo Molnar wrote:
> the RT-LSM thing is a bit dangerous because it doesnt really protect
> against a runaway, buggy app. So i think the right way to approach this
> problem is to not apply RT-LSM for the time being, but to provide an
> 'advanced latency needs' scheduling class that is _still_ safe even if
> the task is runaway, but behaves with near-RT priorities if the task is
> 'nice' (i.e. doesnt use up large amount of CPU time.)
> 
> incidentally, there is such a scheduling class already: negative nice
> levels. Please skip any preconceptions you might have about nice levels,
> nice levels have been improved in 2.6.10, the timeslices are now given
> out exponentially, giving nice -20 tasks far more weight and priority
> than they used to have. (They are obviously still preemptable if they
> keep looping burning CPU - but that we can consider a feature.) (Also,
> in 2.6 the negative nice levels have a much more agressive interactivity
> setting, allowing them to preempt everything lower-prio.)
> 
> so, could you try vanilla 2.6.10 (without LSM and without jackd running
> with RT priorities), with jackd set to nice -20? Make sure the
> jack-client process gets this priority too. Best to achieve this is to
> renice a shell to -20 and start up everything from there - the nice
> settings will be inherited. How does such an audio test compare to a
> test done with jackd running at SCHED_FIFO with RT priority 1?
> 
> if this works out well then we could achieve something comparable to
> RT-LSM, via nice levels alone.
> 

Adding Paul Davis to the cc:, as he has expressed very strong opinions
on this in the past.

Of course this does not address the problem as you still need to be root
to run at a negative nice value.

Lee

