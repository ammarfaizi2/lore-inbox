Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTFZNEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTFZNEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:04:35 -0400
Received: from static-ctb-210-9-247-235.webone.com.au ([210.9.247.235]:28942
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261153AbTFZNEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:04:33 -0400
Message-ID: <3EFAF290.9020904@cyberone.com.au>
Date: Thu, 26 Jun 2003 23:18:08 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
References: <1055296630.23697.195.camel@tiny.suse.com>	 <20030611021030.GQ26270@dualathlon.random>	 <1055353360.23697.235.camel@tiny.suse.com>	 <20030611181217.GX26270@dualathlon.random>	 <1055356032.24111.240.camel@tiny.suse.com>	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>	 <20030612012951.GG1500@dualathlon.random>	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>	 <20030612024608.GE1415@dualathlon.random>	 <1056567822.10097.133.camel@tiny.suse.com>	 <3EFA8920.8050509@cyberone.com.au> <1056628116.20899.28.camel@tiny.suse.com> <3EFAEF71.1080109@cyberone.com.au>
In-Reply-To: <3EFAEF71.1080109@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

snip

>
> Yeah, something like that. I think that in a queue full situation,
> the processes are wanting to submit more than 1 request though. So
> the better thoughput you can achieve by batching translates to
> better effective throughput. Read my recent debate with Andrea 

                   ^^^^^^^^^^
Err, latency

snip

>
> No, the numbers (batch # requests, batch time) are not highly scientific.
> Simply when a process wakes up, we'll let them submit a small burst of
> requests before they go back to sleep.

by this, I mean that its not a big problem that we don't know how many
requests a process wants to submit.

snip

>
> The changes do seem to be a critical fix due to the starvation issue,
> but I'm worried that they take a big step back in performance under
> high disk load. I found my FIFO mechanism to be unacceptably slow for
> 2.5.


BTW. sorry for the lack of better benchmark numbers. I couldn't
find good ones lying around. I found uniprocessor tiobench to
be quite helpful at queue_nr_requests * 0.5, 2 threads to
measure different types of overloadedness.

Also, I didn't see much gain in read performance in my testing -
probably due to AS. I expect 2.4 and 2.5 non AS read performance
to show bigger improvements from batching (ie. regressions).


