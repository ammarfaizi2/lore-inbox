Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265613AbSJSQE7>; Sat, 19 Oct 2002 12:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265615AbSJSQE7>; Sat, 19 Oct 2002 12:04:59 -0400
Received: from cse.ogi.edu ([129.95.20.2]:53421 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265613AbSJSQE5>;
	Sat, 19 Oct 2002 12:04:57 -0400
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <20021018185528.GC13876@mark.mielke.cc>
	<Pine.LNX.4.44.0210181209510.1537-100000@blue1.dev.mcafeelabs.com>
	<20021019065624.GA17553@mark.mielke.cc>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 19 Oct 2002 09:10:52 -0700
In-Reply-To: <20021019065624.GA17553@mark.mielke.cc>
Message-ID: <xu4y98utnn7.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Mielke <mark@mark.mielke.cc> writes:

> They still represent an excessive complicated model that attempts to
> implement /dev/epoll the same way that one would implement poll()/select().

epoll is about fixing one aspect of an otherwise well established api.
That is, fixing the scalability of poll()/select() for applications
based on non-blocking sockets.

Yes, programming non-blocking sockets has its complexity.  Most people
probably end up writing their own API to simplify things, building
wrapper libraries above.  However, a wrapper library can not fix the
performance problems of poll()/select().

epoll() is a relatively modest kernel modification that delivers
impressive performance benefits.  It isn't exactly a drop in
replacement for poll()/select(), especially because of the difference
between level and edge semantics.  That's why wrapper libraries make
sense.   

> Sometimes the answer isn't emulation, or comparability.
> 
> Sometimes the answer is innovation.

> mark

Yes, building a better API into the kernel makes sense.  Not only to
eliminate wrappers, but to generalize beyond sockets.  I went to local
user group meeting this week where a guy gave an overview of what's
new in kernel 2.5.  When AIO was presented, the first question was
"why not use nonblocking IO?".  I bet more than half the programmers
in the room had no idea that nonblocking flags have absolutely no
effect for files.    

It seems to me that most people pushing on AIO so far have been using
it for files, e.g.  Oracle.  They have no choice.  It's either that or
use clumsy worker thread arrangements.  Network code on the other
hand, has had non-blocking IO available for years.  That's why there
are all kinds of examples of web servers that use threads only for the
disk side of things.

But let's not mix them up.  AIO is a new model (for linux anyway),
whose implementation is necessitating fairly major architectural
changes to the kernel.

epoll is a nice well contained fix, that fits neatly into the existing
architecture.   

As it happens, epoll will probably have a place in AIO too.  But there
is no mutual dependency between them.  They are both important on
their own.

-- Buck

