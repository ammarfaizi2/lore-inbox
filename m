Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261956AbREPOEp>; Wed, 16 May 2001 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261957AbREPOEZ>; Wed, 16 May 2001 10:04:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:34842 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261956AbREPOEW>; Wed, 16 May 2001 10:04:22 -0400
Date: Wed, 16 May 2001 16:04:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.20pre2aa1
Message-ID: <20010516160412.B15796@athlon.random>
In-Reply-To: <20010515235859.A2415@athlon.random> <Pine.LNX.4.33.0105152029580.7281-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105152029580.7281-100000@twinlark.arctic.org>; from dean-list-linux-kernel@arctic.org on Tue, May 15, 2001 at 08:33:05PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 08:33:05PM -0700, dean gaudet wrote:
> On Tue, 15 May 2001, Andrea Arcangeli wrote:
> 
> > o	fixed race in wake-one LIFO in accept(2). Apache must be compiled with
> > 	-DSINGLE_LISTEN_UNSERIALIZED_ACCEPT to take advantage of that.
> >
> > 00_wake-one-4
> >
> > 	Backport 2.4 waitqueues and in turn fixes an hanging condition in accept(2).
> >
> > 	(me)
> 
> apache since 1.3.15 has defined SINGLE_LISTEN_UNSERIALIZED_ACCEPT ...

That's definitely a good thing.

> 'cause that's what you guys asked me to do :)  does this mean there are
> known hangs on linux 2.2.x without your fix?

I never heard of anybody reproducing that but accpet() in 2.2
can _definitely_ miss events without the above 00_wake-one-4 patch
because it wrongly considers a progress wakeing up two times the same
exclusive task.

Furthmore the exclusive wakeup logic with the exclusive information
per-task and not per wait_queue_t will screwup if the tasks registers
itself like a wakeall after it was just registered as wakeone somewhere
else (however this second thing is more a theorical issue that shouldn't
trigger in 2.2).

Andrea
