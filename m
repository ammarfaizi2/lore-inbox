Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266833AbSKHR1E>; Fri, 8 Nov 2002 12:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266834AbSKHR1E>; Fri, 8 Nov 2002 12:27:04 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:60808 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266833AbSKHR1D>; Fri, 8 Nov 2002 12:27:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 8 Nov 2002 09:43:46 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Hamblin <MarkHamblin@cox.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.46: epoll ep_insert doesn't wake waiters if events
 exist 
In-Reply-To: <014f01c2873e$794089b0$0200a8c0@cirilium.com>
Message-ID: <Pine.LNX.4.44.0211080938081.1768-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Mark Hamblin wrote:

> Looking at the documentation at
> http://www.xmailserver.org/linux-patches/epoll_wait.txt, I noticed that the
> description for epoll_wait states:  "On success, epoll_wait(2) returns the
> number of file descriptors ready for the requested I/O."  My question is if
> I have, for example, 1000 sockets registered with epoll and 100 of them have
> received data and I call epoll_wait with max_events set to 10, will
> epoll_wait return 10 or 100?  Furthermore, does the edge-triggered nature of
> epoll "eat the edge" for the other 90 sockets even though they didn't get
> returned?  Finally, if those 10 sockets get more data before I call
> epoll_wait with max_events = 10 again, will those same 10 sockets get
> returned?

epoll will return 10 and the remaining 90 will remain available for future
epoll_wait() calls. The last question will trigger a change in my code,
from list_add() to list_add_tail(). Since I don't want to stress Linus
with 24590 patches, I'll wait for 2.5.47 to merge the new code ...



- Davide


