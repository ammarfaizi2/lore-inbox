Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261484AbTCYTLy>; Tue, 25 Mar 2003 14:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263199AbTCYTLy>; Tue, 25 Mar 2003 14:11:54 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:44976 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261484AbTCYTLx>; Tue, 25 Mar 2003 14:11:53 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 25 Mar 2003 11:33:48 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Philippe Meloche (LMC)" <Philippe.Meloche@ericsson.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Epoll + ephttpd2.0 + Coro
In-Reply-To: <3E80AAF2.6090301@lmc.ericsson.se>
Message-ID: <Pine.LNX.4.50.0303251128410.1988-100000@blue1.dev.mcafeelabs.com>
References: <3E80AAF2.6090301@lmc.ericsson.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Philippe Meloche (LMC) wrote:

> Hi,
>
> I'm trying to run the ephttpd 2.0 server on a PII with a 2.4.19 kernel
> patched with /dev/epoll.  But I have trouble with the coro ( C
> couroutine ) library.  The server always does a segmentation fault when
> the function dph_exit_conn() calls co_exit(0). It's the fatal() function
> that generates this segmentation fault. Plus, this fault is
> automatically generated each time there is no more requests on a
> connection and that dph_httpd() calls dph_exit_conn().
>
> I would like to know of you ever had this kind of problem and how you
> solved it. The version of coro I use is the 1.1.0-pre2. I need this http
> server to rebuild /dev/epoll tests on my computer for reference results.

You better use the latest patch :

http://www.xmailserver.org/linux-patches/epoll-lt-2.4.20-0.3.diff

and the latest library/ephttpd server :

http://www.xmailserver.org/linux-patches/epoll-lib-0.4.tar.gz

The new man pages are available here :

http://www.xmailserver.org/linux-patches/epoll.txt
http://www.xmailserver.org/linux-patches/epoll_create.txt
http://www.xmailserver.org/linux-patches/epoll_ctl.txt
http://www.xmailserver.org/linux-patches/epoll_wait.txt


The crashes you're seen are because of a gcc error compiling the coroutine
library. The one that you'll find inside the epoll-lib should work. If I
remember well the problem was solved by switching from -O3 to -O2 when
building the coro library ...




- Davide

