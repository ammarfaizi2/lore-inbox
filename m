Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTFKAp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTFKAp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:45:58 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:30638 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262439AbTFKAp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:45:56 -0400
Subject: RE: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Robert White <rwhite@casabyte.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGMECMCPAA.rwhite@casabyte.com>
References: <PEEPIDHAKMCGHDBJLHKGMECMCPAA.rwhite@casabyte.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055293132.24111.186.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Jun 2003 20:58:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 19:04, Robert White wrote:
> From: Chris Mason [mailto:mason@suse.com]
> Sent: Monday, June 09, 2003 7:13 PM
> 
> > 2) Provide a somewhat obvious patch that makes the current
> > __get_request_wait call significantly more fair, in hopes of either
> > blaming it for the stalls or removing it from the list of candidates
> 
> Without the a_w_q_exclusive() on add_wait_queue the FIFO effect is lost when
> all the members of the wait queue compete for their timeslice in the
> scheduler.  For all intents and purposes the fairness goes up some (you stop
> having the one guy sorted to the un-happy end of the disk) but low priority
> tasks will still always end up stalled on the dirty end of the stick.
> Basically each new round at the queue-empty moment is a mob rush for the
> door.
> 
> With the a_w_q_exclusive(), you get past fair and well into anti-optimal.
> Your FIFO becomes essentially mandatory with no regard for anything but the
> order things hit the wait queue.  (Particularly on an SMP machine, however)
> "new requestors" may/will jump to the head of the line because they were
> never *in* the wait queue.  

The patches flying around force new io into the wait queue any time
someone else is already waiting, nobody is allowed to jump to the head
of the line.

The rest of your ideas are interesting, we just can't smush them into
2.4.  Please consider doing some experiments on the 2.5 io schedulers
and making suggestions, it's a critical area.

-chris

