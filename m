Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbTDAPwK>; Tue, 1 Apr 2003 10:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbTDAPwK>; Tue, 1 Apr 2003 10:52:10 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:11406 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262609AbTDAPwI>; Tue, 1 Apr 2003 10:52:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 1 Apr 2003 08:15:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Philippe Meloche (LMC)" <Philippe.Meloche@ericsson.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Process limits for epoll tests
In-Reply-To: <3E89B55F.1010207@lmc.ericsson.se>
Message-ID: <Pine.LNX.4.50.0304010806060.1932-100000@blue1.dev.mcafeelabs.com>
References: <3E89B55F.1010207@lmc.ericsson.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Philippe Meloche (LMC) wrote:

> Hi,

Hi,


> We tried to reproduce the tests you've done with /dev/epoll and we've
> come to ask us some questions.

I hope you are not using the old /dev/epoll since it is no more supported.
The kernel 2.5.x has epoll, that is supported :

http://www.xmailserver.org/linux-patches/epoll.txt
http://www.xmailserver.org/linux-patches/epoll_create.txt
http://www.xmailserver.org/linux-patches/epoll_ctl.txt
http://www.xmailserver.org/linux-patches/epoll_wait.txt



> 1. How did you managed httperf to perform more than 1024 connections
> when it's using select() ?

Yes, you can't have more than 1024 simultaneous connections with httperf.
But if the session time is short, you can achieve a pretty high rate with
1024 maximum connections. Lately I am using the http blaster ( ver very
simple http loader ) that uses epoll. The latest source code is here :

http://www.xmailserver.org/linux-patches/epoll-lib-0.7.tar.gz

You need this coroutine library to build that package :

http://www.xmailserver.org/libpcl.html



> 2. Did you get some errors like client-timeout or connections reset when
> you were doing your tests ?
>
> 3. How much time did a burst test ( 27000 connections and 2 calls per
> connection ) last and how many sample did httperf
>     took during those tests.

You definitely have to tweak kernel/net params to run the test ( port
range, fin timeout, tw recycle, max files, ... ).




- Davide

