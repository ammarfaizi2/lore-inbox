Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSKSB5N>; Mon, 18 Nov 2002 20:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbSKSB5N>; Mon, 18 Nov 2002 20:57:13 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:62092 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264915AbSKSB5M>; Mon, 18 Nov 2002 20:57:12 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 18:04:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <3DD99D33.1030900@kegel.com>
Message-ID: <Pine.LNX.4.44.0211181759130.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Dan Kegel wrote:

> Davide Libenzi wrote:
> > On Mon, 18 Nov 2002, Dan Kegel wrote:
> >>Second, epoll_ctl(2) doesn't define the meaning of the
> >>event mask.  It should give the allowed bits and define
> >>their meanings.  If we use the traditional POLLIN etc, we
> >>can say
> >>   POLLIN - the fd has become ready for reading
> >>   POLLOUT - the fd has become ready for writing
> >>   Note: If epoll tells you e.g. POLLIN, it means that
> >>            poll will tell you the same thing,
> >>            since poll gives the current status,
> >>            and epoll gives changes in status.
> >
> >
> > I will have to change man pages also to fit EPOLL* definitions.
>
> IMHO changing from using POLLIN etc. to EPOLLIN
> will obscure the essential relationship between
> epoll and poll (namely, that the epoll bits
> are the time derivative of the poll bits).
>
> I would prefer to continue using POLLIN, etc.

Dan, at the beginning I had the same thought as yours. Now I sort of
changed my mind. The epoll interface is basically seeing the light in
these days and even if right now it uses f_op->poll(), tomorrow we don't
know. To avoid painful code changes later is IMHO better to define EPOLL*
bits right now. They'll be the same of the POLL* bits but will enable
epoll to be independent from poll.h bits. At least to the outside world.
Same for the event structure.



- Davide


