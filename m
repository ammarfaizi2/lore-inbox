Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSJ2B5Y>; Mon, 28 Oct 2002 20:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSJ2B5Y>; Mon, 28 Oct 2002 20:57:24 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:43677 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261340AbSJ2B5X>; Mon, 28 Oct 2002 20:57:23 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 18:13:10 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: Security critical race condition in epoll code
In-Reply-To: <3DBDE8AF.6090102@netscape.com>
Message-ID: <Pine.LNX.4.44.0210281811580.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, John Gardiner Myers wrote:

> First a user space program creates an epoll fd and adds a socket to it
> using sys_epoll_ctl(...EP_CTL_ADD...)
>
> Then the program creates two threads, A and B.  Simultaneously, A calls
> sys_epoll_ctl(...EP_CTL_MOD...) and B calls
> sys_epoll_ctl(...EP_CTL_DEL...) on the socket that was previously added.
>
> Thread A runs up through the point where ep_find() returns the (struct
> epitem *) for the socket.
>
> Thread B then runs and ep_remove() frees the (struct epitem *).
>
> Thread A then runs some more and stores the value of events into the now
> freed block of memory pointed to by dpi.

Ugh ... I forgot that you're the one that is handling an fd with 25000
threads :) This is true and it'll be fixed before you can read this
message ...



- Davide


