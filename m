Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSJVRcr>; Tue, 22 Oct 2002 13:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264816AbSJVRcr>; Tue, 22 Oct 2002 13:32:47 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:24472 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264815AbSJVRcq>; Tue, 22 Oct 2002 13:32:46 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 22 Oct 2002 10:47:43 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: "Charles 'Buck' Krasic" <krasic@acm.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <20021022172244.GA1314@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0210221043420.1563-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Mark Mielke wrote:

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

Since the sys_epoll ( and /dev/epoll ) fd support standard polling, you
can mix sys_epoll handling with other methods like poll() and the AIO's
POLL function when it'll be ready. For example, for devices that sys_epoll
intentionally does not support, you can use a method like :

	put_sys_epoll_fd_inside_XXX();
	...
	wait_for_XXX_events();
	...
	if (XXX_event_fd() == sys_epoll_fd) {
		sys_epoll_wait();
		for_each_sys_epoll_event {
			handle_fd_event();
		}
	}



- Davide


