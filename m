Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbTGLUlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268426AbTGLUlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:41:07 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:25995 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268435AbTGLUlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:41:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 13:48:21 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Eric Varsanyi <e0206@foo21.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <20030712205114.GC15643@srv.foo21.com>
Message-ID: <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk>
 <20030712205114.GC15643@srv.foo21.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Eric Varsanyi wrote:

> > > In a level triggered world this all just works because the read ready
> > > indication is driven back to the app as long as the socket state is half
> > > closed. The event driven epoll mechanism folds these two indications
> > > together and thus loses one 'edge'.
> >
> > Well then, use epoll's level-triggered mode.  It's quite easy - it's
> > the default now. :)
>
> The problem with all the level triggered schemes (poll, select, epoll w/o
> EPOLLET) is that they call every driver and poll status for every call into
> the kernel. This appeared to be killing my app's performance and I verified
> by writing some simple micro benchmarks.

Look this is false for epoll. Given N fds inside the set and M hot/ready
fds, epoll scale O(M) and not O(N) (like poll/select). There's a huge
difference, expecially with real loads.



- Davide

