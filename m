Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSJ2AE7>; Mon, 28 Oct 2002 19:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbSJ2AE7>; Mon, 28 Oct 2002 19:04:59 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:19098 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261424AbSJ2AE5>; Mon, 28 Oct 2002 19:04:57 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 16:20:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021029000339.GA31212@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210281616190.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, bert hubert wrote:

> On Mon, Oct 28, 2002 at 11:44:34PM +0000, Jamie Lokier wrote:
>
> > :( I was hoping sys_epoll would be scalable without increasing the
> > number of system calls per event.
>
> I see only one call per event? sys_epoll_wait. Perhaps sys_epoll_ctl to
> register a new interest.

In theory you can register the fd at creation time with the full interest
set and you can leave it in there for its whole life without having to
call epoll_ctl() every switch between read/write. It's true that you could
receive false events, but by studying the frequency of those false events
on a "very high loaded" HTTP server, it resulted to be both very little
and uneffective on the server performance.



- Davide


