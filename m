Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbTFLCbn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbTFLCbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:31:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64388
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264687AbTFLCbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:31:41 -0400
Date: Thu, 12 Jun 2003 04:46:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
Message-ID: <20030612024608.GE1415@dualathlon.random>
References: <1055296630.23697.195.camel@tiny.suse.com> <20030611021030.GQ26270@dualathlon.random> <1055353360.23697.235.camel@tiny.suse.com> <20030611181217.GX26270@dualathlon.random> <1055356032.24111.240.camel@tiny.suse.com> <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au> <20030612012951.GG1500@dualathlon.random> <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE7E876.80808@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:41:58PM +1000, Nick Piggin wrote:
> 
> 
> Chris Mason wrote:
> 
> >On Wed, 2003-06-11 at 21:29, Andrea Arcangeli wrote:
> >
> >
> >>this will avoid get_request_wait_wakeup to mess the wakeup, so we can
> >>wakep_nr(rq.count) safely.
> >>
> >>then there's the last issue raised by Chris, that is if we get request
> >>released faster than the tasks can run, still we can generate a not
> >>perfect fairness. My solution to that is to change wake_up to have a
> >>nr_exclusive not obeying to the try_to_wakeup retval. that should
> >>guarantee exact FIFO then, but it's a minor issue because the requests
> >>shouldn't be released systematically in a flood. So I'm leaving it
> >>opened for now, the others already addressed should be the major ones.
> >>
> >
> >I think the only time we really need to wakeup more than one waiter is
> >when we hit the q->batch_request mark.  After that, each new request
> >that is freed can be matched with a single waiter, and we know that any
> >previously finished requests have probably already been matched to their
> >own waiter.
> >
> >
> Nope. Not even then. Each retiring request should submit
> a wake up, and the process will submit another request.
> So the number of requests will be held at the batch_request
> mark until no more waiters.
> 
> Now that begs the question, why have batch_requests anymore?
> It no longer does anything.

it does nothing w/ _exclusive and w/o the wake_up_nr, that's why I added
the wake_up_nr.

Andrea
