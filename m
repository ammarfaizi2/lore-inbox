Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261388AbSJ2A6I>; Mon, 28 Oct 2002 19:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbSJ2A6I>; Mon, 28 Oct 2002 19:58:08 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:7325 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261388AbSJ2A6I>; Mon, 28 Oct 2002 19:58:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 17:13:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021029005332.GA32426@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210281708120.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, bert hubert wrote:

> Ok, so that is two things that need to be in the manpage and probably in
> bold:
>
> 	1) epoll only works on pipes and sockets
>               (not on tty, not on files)
>
>         2) epoll must be used on non-blocking sockets only
>               (and describe the race that happens otherwise)
>
> If you send me the source of your manpages I'll work it in if you want.

No problem ...


> I still vote for checking at insert time however unless that is too
> expensive. Yes, we want people to read the manpages and heed them, but we
> also not want to create interfaces that are needlessly errorprone.

This will make the API to be really error prone by giving the user the
impression that he can go sleeping for a given fd each time he wants. The
rule "you can wait for events only after you received EAGAIN" looks like a
very short and precise rule. On the contrary of "you can go wait for
events after you received EAGAIN or after accept/connect". And the fact on
using the fd immediately after an accept/connect is enforced by two very
likely facts :

1) on accept() it's very likely that the first packet brough you something
	more than SYN

2) on connect() you have the full I/O write space available



- Davide


