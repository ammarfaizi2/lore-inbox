Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129471AbRBURzY>; Wed, 21 Feb 2001 12:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129512AbRBURzO>; Wed, 21 Feb 2001 12:55:14 -0500
Received: from oboe.it.uc3m.es ([163.117.139.101]:60426 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S129471AbRBURyz>;
	Wed, 21 Feb 2001 12:54:55 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200102211754.f1LHscA12507@oboe.it.uc3m.es>
Subject: Re: plugging in 2.4. Does it work?
In-Reply-To: <20010221182743.W1447@suse.de> from "Jens Axboe" at "Feb 21, 2001
 06:27:43 pm"
To: "Jens Axboe" <axboe@suse.de>
Date: Wed, 21 Feb 2001 18:54:38 +0100 (MET)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Jens Axboe wrote:"
> The implementation in ll_rw_blk.c (and other places) assumes that
> a failed request just means the first chunk and it then makes sense
> to just end i/o on that buffer and resetup the request for the next
> buffer. If you want to completely scrap the request on an error, then
> you'll just have to do that manually (ie loop end_that_request_first
> and end_that_request_last at the end).
> 
> void my_end_request(struct request *rq, int uptodate)
> {
> 	while (end_that_request_first(rq, uptodate))
> 		;
> 
> 	io_lock
> 	end_that_request_last(rq);
> 	io_unlock
> }

OK, thanks!

> And why you keep insisting on a duplicate end_that_request_first I don't
> know?!

Backwards compatibility.  The code has to keep working under older
kernel versions too in order to pass the regression tests, and the
simplest thing is to put the front while loop in an ifdef while I work
on it.  At some stage soon I'll do as you want. Things have stopped
oopsing on write now, and I've sent it for testing.

That's also why I have the io_lock around the whole code instead of
only the last part. I have to put it around something that at least
existed in 2.2 and even 2.0. I've stepped the version number and will
be revising the code while its being tested. But thanks for the
concern :-). I appreciate it!

Peter

