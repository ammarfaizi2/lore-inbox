Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSJOXJN>; Tue, 15 Oct 2002 19:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265166AbSJOXJN>; Tue, 15 Oct 2002 19:09:13 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:10134 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265095AbSJOXJJ>; Tue, 15 Oct 2002 19:09:09 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Oct 2002 16:23:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Dan Kegel <dank@kegel.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <3DAC9D2B.4050309@netscape.com>
Message-ID: <Pine.LNX.4.44.0210151608350.1554-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, John Gardiner Myers wrote:

> Davide Libenzi wrote:
>
> >There're many ways to have /dev/epoll working in a threaded environment if
> >you think about it, and no you don't need to have a single thread fetching
> >events. You can have, if you really like threads, N fetching threads (
> >working on N private /dev/epoll fds ), feeding M queues
> >
> In such models, you still have to pay the cost of divvying up the events
> after you receive them.  You also have to worry about keeping load
> distributed evenly enough.

That's exactly the reason why you don't want to use many threads. Typical
applications that uses multiplex interfaces uses only one task (
eventually for each CPU ) that handles many connections. And again, you
can also use threads, if you design your application correctly. It is not
that expensive having service threads popping from an array. Yes, you have
a lock to be acquired but this is a price you have to pay as soon as you
choose threads.



- Davide



