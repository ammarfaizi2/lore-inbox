Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbTFLBXT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264690AbTFLBXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:23:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29594
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264683AbTFLBXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:23:11 -0400
Date: Thu, 12 Jun 2003 03:37:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
Message-ID: <20030612013736.GI1500@dualathlon.random>
References: <1055292839.24111.180.camel@tiny.suse.com> <20030611010628.GO26270@dualathlon.random> <1055296630.23697.195.camel@tiny.suse.com> <20030611021030.GQ26270@dualathlon.random> <1055353360.23697.235.camel@tiny.suse.com> <20030611181217.GX26270@dualathlon.random> <1055356032.24111.240.camel@tiny.suse.com> <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au> <20030612012951.GG1500@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612012951.GG1500@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 03:29:51AM +0200, Andrea Arcangeli wrote:
> static void get_request_wait_wakeup(request_queue_t *q, int rw)
> {
> 	/*
> 	 * avoid losing an unplug if a second __get_request_wait did the
> 	 * generic_unplug_device while our __get_request_wait was
> 	 * running
> 	 * w/o the queue_lock held and w/ our request out of the queue.
> 	 */
> 	if (waitqueue_active(&q->wait_for_requests))
> 		run_task_queue(&tq_disk);

btw, that was the old version, Chris did it right
s/run_task_queue(&tq_disk)/__generic_unplug_device(q)/

Andrea
