Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265318AbSJRRwi>; Fri, 18 Oct 2002 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbSJRRwh>; Fri, 18 Oct 2002 13:52:37 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:44938 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265318AbSJRR1I>; Fri, 18 Oct 2002 13:27:08 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Oct 2002 10:41:28 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: Mark Mielke <mark@mark.mielke.cc>, John Myers <jgmyers@netscape.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <3DB044C6.1080908@kegel.com>
Message-ID: <Pine.LNX.4.44.0210181027440.1537-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Dan Kegel wrote:

> I was afraid someone would be confused by the examples.  Davide loves
> coroutines (check out http://www.xmailserver.org/linux-patches/nio-improve.html )
> and I think his examples are written in that style.  He really means
> what you think he should be meaning :-)
> which is something like
>      while (1) {
>          grab next bunch of events from epoll
>          for each event
>              while (do_io(event->fd) != EAGAIN);
>      }
> I'm pretty sure.

Yes, I like coroutines :) even if sometimes you have to be carefull with
the stack usage ( at least if you do not want to waste all your memory ).
Since there're N coroutines/stacks for N connections even 4Kb does mean
something when N is about 100000. The other solution is a state machine,
cheaper about memory, a little bit more complex about coding. Coroutines
though helps a graceful migration from a thread based application to a
multiplexed one. If you take a thread application and you code your
connect()/accept()/recv()/send() like the ones coded in the example http
server linked inside the epoll page, you can easily migrate a threaded app
by simply adding a distribution loop like :

for (;;) {
	get_events();
	for_each_fd
		call_coroutines_associated_with_ready_fd();
}



- Davide


