Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264708AbTFLCtq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTFLCtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:49:46 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15749
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264708AbTFLCtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:49:45 -0400
Date: Thu, 12 Jun 2003 05:04:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
Message-ID: <20030612030412.GG1415@dualathlon.random>
References: <20030611181217.GX26270@dualathlon.random> <1055356032.24111.240.camel@tiny.suse.com> <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au> <20030612012951.GG1500@dualathlon.random> <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au> <20030612024608.GE1415@dualathlon.random> <3EE7EA4A.5030105@cyberone.com.au> <3EE7EAB2.5010705@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE7EAB2.5010705@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:51:30PM +1000, Nick Piggin wrote:
> I guess you could fix this by having a "last woken" flag, and
> allow that process to allocate requests without blocking from
> the batch limit until the queue full limit. That is how
> batch_requests is supposed to work.

I see what you mean, I did care about the case of each request belonging
to a different task, but of course this doesn't work if there's just one
task. In such case there will be a single wakeup and one for each
request, so it won't be able to eat all the requests and it'll keep
hanging on the full bitflag. So yes, the ->full bit partly disabled the
batch sectors in presence of only 1 task. With multiple tasks and the
wake_up_nr batch_sectors will still work. However I don't care about
that right now ;), it's a minor issue I guess, single task I/O normally
doesn't seek heavily so more likely it will run into the oversized queue
before being able to take advantage of the batch sectors.

Andrea
