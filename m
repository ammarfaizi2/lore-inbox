Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264671AbTFLCJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264672AbTFLCJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:09:24 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:21684 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S264671AbTFLCJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:09:23 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030612012951.GG1500@dualathlon.random>
References: <20030611003356.GN26270@dualathlon.random>
	 <1055292839.24111.180.camel@tiny.suse.com>
	 <20030611010628.GO26270@dualathlon.random>
	 <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
	 <1055353360.23697.235.camel@tiny.suse.com>
	 <20030611181217.GX26270@dualathlon.random>
	 <1055356032.24111.240.camel@tiny.suse.com>
	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>
	 <20030612012951.GG1500@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1055384547.24111.322.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jun 2003 22:22:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 21:29, Andrea Arcangeli wrote:

> this will avoid get_request_wait_wakeup to mess the wakeup, so we can
> wakep_nr(rq.count) safely.
> 
> then there's the last issue raised by Chris, that is if we get request
> released faster than the tasks can run, still we can generate a not
> perfect fairness. My solution to that is to change wake_up to have a
> nr_exclusive not obeying to the try_to_wakeup retval. that should
> guarantee exact FIFO then, but it's a minor issue because the requests
> shouldn't be released systematically in a flood. So I'm leaving it
> opened for now, the others already addressed should be the major ones.

I think the only time we really need to wakeup more than one waiter is
when we hit the q->batch_request mark.  After that, each new request
that is freed can be matched with a single waiter, and we know that any
previously finished requests have probably already been matched to their
own waiter.

-chris



