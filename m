Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265020AbSJOW0C>; Tue, 15 Oct 2002 18:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265016AbSJOWZs>; Tue, 15 Oct 2002 18:25:48 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:17044 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264923AbSJOWT0>; Tue, 15 Oct 2002 18:19:26 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Oct 2002 15:33:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Myers <jgmyers@netscape.com>
cc: Dan Kegel <dank@kegel.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <3DAC8D8C.8060000@netscape.com>
Message-ID: <Pine.LNX.4.44.0210151528020.1554-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, John Myers wrote:

> Dan Kegel wrote:
>
> >The most effective way to use something like /dev/epoll in a
> >multithreaded
> >program might be to have one thread call "get next batch of events",
> >then divvy up the events across multiple threads.
> >
> That is a tautology.  As /dev/epoll is inherently a single threaded
> interface, of course the most effective way for a multithreaded program
> to use it is to have one thread call it then divvy up the events.
>  That's the *only* way a multithreaded program can deal with a single
> threaded interface.
>
> The cost to divvy up the events can be substantial, not the mention the
> cost of funneling them all through a single CPU.  This cost can easily
> be greater than what one saves by combining events.  io_getevents() is a
> great model for divvying events across multiple threads, the poll
> facility should work with that model.
>
> The solution for optimizing the amount of event collapsing is to
> implement concurrency control.

There're many ways to have /dev/epoll working in a threaded environment if
you think about it, and no you don't need to have a single thread fetching
events. You can have, if you really like threads, N fetching threads (
working on N private /dev/epoll fds ), feeding M queues, polled by P
service threads. If you like it ...




- Davide


