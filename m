Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262018AbREPRZ4>; Wed, 16 May 2001 13:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbREPRZp>; Wed, 16 May 2001 13:25:45 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:4368 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S262018AbREPRZe>; Wed, 16 May 2001 13:25:34 -0400
Date: Wed, 16 May 2001 10:25:32 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.20pre2aa1
In-Reply-To: <20010516160412.B15796@athlon.random>
Message-ID: <Pine.LNX.4.33.0105161018440.25320-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2001, Andrea Arcangeli wrote:

> On Tue, May 15, 2001 at 08:33:05PM -0700, dean gaudet wrote:
> > apache since 1.3.15 has defined SINGLE_LISTEN_UNSERIALIZED_ACCEPT ...
>
> That's definitely a good thing.

hmm, i'm not so sure -- 1.3.x is our stable release, and it sounds like
this change has added an instability.

> > 'cause that's what you guys asked me to do :)  does this mean there are
> > known hangs on linux 2.2.x without your fix?
>
> I never heard of anybody reproducing that but accpet() in 2.2
> can _definitely_ miss events without the above 00_wake-one-4 patch
> because it wrongly considers a progress wakeing up two times the same
> exclusive task.

i'm guessing from your description that the missed event will be noticed
when the next socket arrives.  i.e. if the server is pretty busy then the
missed events are not important.  but if it's not a busy server, like a
hit every hour, then the missed event may be noticeable to browsers (as a
timeout waiting for server activity).

does that pretty much sum it up?

> Furthmore the exclusive wakeup logic with the exclusive information
> per-task and not per wait_queue_t will screwup if the tasks registers
> itself like a wakeall after it was just registered as wakeone somewhere
> else (however this second thing is more a theorical issue that shouldn't
> trigger in 2.2).

i.e. if the socket was used both in accept() and in select() at the same
time?  (which apache doesn't do)

thanks
-dean

