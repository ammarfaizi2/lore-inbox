Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265394AbUEUHvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbUEUHvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbUEUHvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:51:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17621 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265394AbUEUHvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:51:15 -0400
Date: Fri, 21 May 2004 09:50:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, alexeyk@mysql.com, linuxram@us.ibm.com,
       peter@mysql.com, linux-kernel@vger.kernel.org
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
Message-ID: <20040521075027.GN1952@suse.de>
References: <200405022357.59415.alexeyk@mysql.com> <1084480888.22208.26.camel@dyn319386.beaverton.ibm.com> <1084815010.13559.3.camel@localhost.localdomain> <200405200506.03006.alexeyk@mysql.com> <20040520145902.27647dee.akpm@osdl.org> <20040520152305.3dbfa00b.akpm@osdl.org> <40ADB062.8050005@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ADB062.8050005@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21 2004, Nick Piggin wrote:
> Andrew Morton wrote:
> 
> >Open questions are:
> >
> >a) Why is 2.6 write coalescing so superior to 2.4?
> >
> >b) Why is 2.6 issuing more read requests, for less data?
> >
> >c) Why is Alexey seeing dissimilar results?
> >
> 
> 
> Interesting. I am not too familiar with 2.4's IO scheduler,
> but 2.6's have pretty comprehensive merging systems. Could
> that be helping, Jens? Or is 2.4 pretty equivalent?

2.4 will give up merging faster than 2.6, elevator_linus will stop
looking for a merge point if the sequence drops to zero. 2.6 will always
merge. So that could explain the fewer writes.

> What about things like maximum request size for 2.4 vs 2.6
> for example? This is another thing that can have an impact,
> especially for writes.

I think that's pretty similar. Andrew didn't say what device he was
testing on, but 2.4 ide defaults to max 64k where 2.6 defaults to 128k.

> I'll take a guess at b, and say it could be as-iosched.c.
> Another thing might be that 2.6 has smaller nr_requests than
> 2.4, although you are unlikely to hid the read side limit
> with only 16 threads if they are doing sync IO.

Andrew, you did numbers for deadline previously as well, but no rq
statistics there? As for nr_requests that's true, would be worth a shot
to bump available requests in 2.6.

-- 
Jens Axboe

