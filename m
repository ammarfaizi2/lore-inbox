Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265713AbSKACmB>; Thu, 31 Oct 2002 21:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbSKACmB>; Thu, 31 Oct 2002 21:42:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:12172 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265713AbSKACl7>; Thu, 31 Oct 2002 21:41:59 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 31 Oct 2002 18:54:01 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Matthew D. Hall" <mhall@free-market.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
In-Reply-To: <3DC1DEFB.6070206@free-market.net>
Message-ID: <Pine.LNX.4.44.0210311838060.972-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Matthew D. Hall wrote:

> *  Unless every conceivable event is to be represented as a file (rather
> unintuitive IMHO), his proposed interface fails to accomodate non-I/O
> events (e.g. timers,  signals, directory updates, etc.).  As much as I
> appreciate the UNIX Way, making everything a file is a massive
> oversimplification.  We can often stretch the definition far enough to
> make this work, but I'd be impressed to see how one intends to call,
> e.g., a timer a type of file.

The fact that a timer is a file garanties you the usage of an existing
infrastructure and existing APIs to use it. For example epoll_create(2)
returns you a file descriptor, and this enable you ( for example ) to drop
this file descriptor inside a poll set. Also you get the cleanup
infrastructure that otherwise you would have to code every time, for each
new object that you create, by yourself. Something like :

int timer_create(void);
int timer_set(struct timespec *ts);

and you can use epoll or poll to get the timer event, and close(2) to
destroy it. You get automatic compatibility with lots of nice stuff having
an object that is actually a file and I usually like it as idea.



> *  I'm sure everyone would agree that passing an opaque "user context"
> pointer is necessary with each event.

I asked this about a week ago. It's _trivial_ to do in epoll. I did not
receive any feedback, so I didn't implement it. Feedback will be very much
appreciated here ...




- Davide




