Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSJQAJG>; Wed, 16 Oct 2002 20:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261715AbSJQAJG>; Wed, 16 Oct 2002 20:09:06 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:399 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261568AbSJQAJC>; Wed, 16 Oct 2002 20:09:02 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Oct 2002 17:23:12 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Mark Mielke <mark@mark.mielke.cc>, Benjamin LaHaise <bcrl@redhat.com>,
       Dan Kegel <dank@kegel.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <3DADFAD0.1070108@netscape.com>
Message-ID: <Pine.LNX.4.44.0210161705460.1548-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, John Gardiner Myers wrote:

> Mark Mielke wrote:
>
> >Not to enter into any of the other discussions on this issue, I wouldn't
> >usually do what you suggest above. [...] if I did I
> >a recv() or read() of 2K, and I only received 1K, there is no reason why
> >another system call should be invoked on the resource that likely will not
> >have any data ready.
> >
> >
> You're into the minutiae here.  Sure, you can optimize the read() in
> some cases, but Mr. Libenzi's example of a correct code scheme is no
> better than mine when it comes to this.

The poll()-like code :

int my_io(...) {

	if (poll(...))
		do_io(...);

}

The epoll-like code :

int my_io(...) {

	while (do_io(...) == EAGAIN)
		event_wait(...);

}

I would say that the epoll-like code generates less system calls because
if you call my_io() by processing small chunks of the I/O space, the
epoll-like code will generate only one system call while the poll()-like
code two. In case of I/O that ends up in wait the poll()-like code
generate two system calls while epoll-like code three. Globally the number
of system calls are about the same and from a performance point of view
/dev/epoll looks "pretty good" ( see /dev/epoll page ).




- Davide


