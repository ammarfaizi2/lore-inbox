Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSJ2Al2>; Mon, 28 Oct 2002 19:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSJ2Al2>; Mon, 28 Oct 2002 19:41:28 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:24987 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261426AbSJ2Al0>; Mon, 28 Oct 2002 19:41:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 16:57:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021029004034.GA32118@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210281652270.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, bert hubert wrote:

> If that code dares to read immediatly from the fd without having an explicit
> POLLIN event, which also means that epoll can only be used in this fashion
> with nonblocking sockets.

The epoll interface has to be used with non-blocking fds. The EAGAIN
return code from read/write tells you that you can go safely to wait for
events for that fd because you making the read/write to return EAGAIN, you
consumed the whole I/O space for that fd. Consuming the whole I/O space
meant that you brought the signal to zero ( talking in ee terms ), and a
followinf 0->1 transaction will trigger the event. Where 1 means I/O space
available ...



- Davide


