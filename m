Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161320AbWGNWjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161320AbWGNWjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 18:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161319AbWGNWjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 18:39:04 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:37018 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1161320AbWGNWjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 18:39:03 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Jul 2006 15:38:55 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Michael Lindner <mikell@optonline.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: epoll_wait() returns wrong events for EOF with EPOLLOUT
In-Reply-To: <200607141518.58635.mikell@optonline.net>
Message-ID: <Pine.LNX.4.64.0607141535070.2463@alien.or.mcafeemobile.com>
References: <200607141518.58635.mikell@optonline.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006, Michael Lindner wrote:

> [2.] Full description of the problem/report:
> 	If a program is waiting in epoll_wait() for EPOLLOUT event on a
> 	socket and the socket is closed, epoll_wait() returns EPOLLHUP|EPOLLERR,
> 	but *not* EPOLLOUT.
>
> 	This differs from the expected behavior in several ways:
>
> 	1. epoll_wait is not returning the events it was told to wait for.
> 	    Why not return EPOLLOUT? select() returns an FD as writable on EOF.

Because it is not supposed to.



> 	2. epoll_wait() is returning events it was not told to wait for.

Because they are non-maskeable.



> 	3. EPOLLHUP is not returned if EPOLLIN was requested, why
> 	   do so on EPOLLOUT?

Please take a look at the POSIX docs for poll(2).



> 	Also a minor issue - epoll_ctl doesn't check if the fd in events.data.fd
> 	is the same as the fd that's been passed in as argument 3. If they differ
> 	(due to programmer error), epoll_wait will return an event with the
> 	incorrect events.data.fd specified to epoll_ctl().

That's an opaque union and epoll couldn't care less of the content.



- Davide


