Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265356AbSKAR3e>; Fri, 1 Nov 2002 12:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265358AbSKAR3e>; Fri, 1 Nov 2002 12:29:34 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:7045 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265356AbSKAR3e>; Fri, 1 Nov 2002 12:29:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 1 Nov 2002 09:45:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <3DC2BCF5.5010607@kegel.com>
Message-ID: <Pine.LNX.4.44.0211010940010.1715-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Dan Kegel wrote:

> Davide Libenzi wrote:
> >>Do you avoid the cost of epoll_ctl() per new fd?
> >
> > Jamie, the cost of epoll_ctl(2) is minimal/zero compared with the average
> > life of a connection.
>
> Depends on the workload.  Where I work, the http client I'm writing
> has to perform extremely well even on 1 byte files with HTTP 1.0.
> Minimizing system calls is suprisingly important - even
> a gettimeofday hurts.

Dan, is it _one_ gettimeofday() or a gettimeofday() inside a loop ?
gettimeofday() is of the order of few microseconds ... and If your clients
works with anything alse than a loopback, few microseconds shouldn't weigh
in much compared to connect/send/recv/close on a network connection. It is
not much the fact that you transfer one byte, it's the whole TCP handshake
cost that weighs in.



- Davide


