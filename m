Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSJVSgv>; Tue, 22 Oct 2002 14:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264868AbSJVSgv>; Tue, 22 Oct 2002 14:36:51 -0400
Received: from cse.ogi.edu ([129.95.20.2]:33246 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S264867AbSJVSgt>;
	Tue, 22 Oct 2002 14:36:49 -0400
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <20021018185528.GC13876@mark.mielke.cc>
	<Pine.LNX.4.44.0210181209510.1537-100000@blue1.dev.mcafeelabs.com>
	<20021019065624.GA17553@mark.mielke.cc>
	<xu4y98utnn7.fsf@brittany.cse.ogi.edu>
	<20021022172244.GA1314@mark.mielke.cc>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 22 Oct 2002 11:42:17 -0700
In-Reply-To: <20021022172244.GA1314@mark.mielke.cc>
Message-ID: <xu48z0ql3hy.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't think the big picture is that complicated.   

epoll is useful for programs that use the old nonblocking socket API.
It improves performance significantly for a case where poll() and
select() are deficient (large numbers of slow or idle connections).

There are a number of people, including myself, who already use epoll.
At least some of us don't think it is too complicated.  I claim most
of the complication is in the nonblocking socket API, in which case
the complexity falls under the category of "the devil you know...".

The old nonblocking socket API (and hence epoll) does nothing for file
IO, and it just doesn't make sense relative to file IO.  (EAGAIN,
POLLIN, POLLOUT, etc. aren't terribly useful signals from a disk
device).

So, its a great thing that the new AIO API is forthcoming.

So maybe epoll's moment of utility is only transient.  It should have
been in the kernel a long time ago.  Is it too late now that AIO is
imminent?  

-- Buck

Mark Mielke <mark@mark.mielke.cc> writes:

> On Sat, Oct 19, 2002 at 09:10:52AM -0700, Charles 'Buck' Krasic wrote:
> > Mark Mielke <mark@mark.mielke.cc> writes:
> > > They still represent an excessive complicated model that attempts to
> > > implement /dev/epoll the same way that one would implement poll()/select().
> > epoll is about fixing one aspect of an otherwise well established api.
> > That is, fixing the scalability of poll()/select() for applications
> > based on non-blocking sockets.
> 
> epoll is not a poll()/select() enhancement (unless it is used in
> conjuction with poll()/select()). It is a poll()/select()
> replacement.
> 
> Meaning... purposefully creating an API that is designed the way one
> would design a poll()/select() loop is purposefully limiting the benefits
> of /dev/epoll.
> 
> It's like inventing a power drill to replace the common screw driver,
> but rather than plugging the power drill in, manually turning the
> drill as if it was a socket wrench for the drill bit.
> 
> I find it an excercise in self defeat... except that /dev/epoll used the
> same way one would use poll()/select() happens to perform better even
> when it is crippled.
> 
> mark
> 
> -- 
> mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
> .  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
> |\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
> |  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada
> 
>   One ring to rule them all, one ring to find them, one ring to bring them all
>                        and in the darkness bind them...
> 
>                            http://mark.mielke.cc/
