Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261739AbSJQSTC>; Thu, 17 Oct 2002 14:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261753AbSJQSTC>; Thu, 17 Oct 2002 14:19:02 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:41358 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261739AbSJQSTB>; Thu, 17 Oct 2002 14:19:01 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 17 Oct 2002 11:33:15 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <3DAEFC0D.9010103@netscape.com>
Message-ID: <Pine.LNX.4.44.0210171121390.1631-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, John Gardiner Myers wrote:

> Davide Libenzi wrote:
>
> >>Nonsense.  If you wish to make such a claim, you need to provide an
> >>example of a situation in which it won't work.
> >>
> >>
> >
> >Your welcome. This is your code :
> >
> >for (;;) {
> >     fd = event_wait(...);
> >     while (do_io(fd) != EAGAIN);
> >}
> >
> >If the I/O space is not exhausted when you call event_wait(...); you'll
> >never receive the event because you'll be waiting a 0->1 transaction
> >without bringing the signal to 0 ( I/O space exhausted ).
> >
> My code above does exhaust the I/O space.

Look, I'm usually very polite but you're really wasting my time. You
should know that an instruction at line N is usually executed before an
instruction at line N+1. Now this IS your code :

[N-1] for (;;) {
[N  ]     fd = event_wait(...);
[N+1]     while (do_io(fd) != EAGAIN);
[N+2} }

I will leave you as an exercise to understand what happens when you call
the first event_wait(...); and there is still data to be read/write on the
file descriptor. The reason you're asking /dev/epoll to drop an event at
fd insertion time shows very clearly that you're going to use the API is
the WRONG way and that you do not understand how such APIs works. And the
fact that there're users currently using the rt-sig and epoll APIs means
that either those guys are genius or you're missing something.




- Davide



