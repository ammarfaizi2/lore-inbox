Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267652AbSKTHee>; Wed, 20 Nov 2002 02:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbSKTHdR>; Wed, 20 Nov 2002 02:33:17 -0500
Received: from mark.mielke.cc ([216.209.85.42]:55812 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267652AbSKTHdC>;
	Wed, 20 Nov 2002 02:33:02 -0500
Date: Wed, 20 Nov 2002 02:47:32 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>, Edgar Toernig <froese@gmx.de>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021120074732.GA26018@mark.mielke.cc>
References: <3DD9CDB2.2075CCB4@gmx.de> <Pine.LNX.4.44.0211191721350.1918-100000@blue1.dev.mcafeelabs.com> <20021120030919.GA9007@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120030919.GA9007@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 03:09:19AM +0000, Jamie Lokier wrote:
> [ ... regarding 'struct epollfd' ('struct epoll_fd'?) ... ]
> What value does the `fd' field have when a file descriptor being
> polled has been renumbered (by dup/close or dup2/close or
> fcntl(F_DUPFD)/close or passing through a unix domain socket)?

As long as the kernel doesn't freeze up or leak memory, I believe it is
the responsibility of the application code to ensure that the correct
file descriptors are registered (and deregistered). If the application
code does screwy things, it should expect a little bit of undefined
behaviour.

> The `fd' field, on the other hand, is not guaranteed to correspond
> with the correct file descriptor number.  So.... perhaps the structure
> should contain an `obj' field and _no_ `fd' field?

Whether the 'fd' field is in kernel space or user space or both does
not really affect the ability of the application code to be able to
perform dup() operations without needing to change references to the
'fd'. For the people that do not wish to use the 'obj' field, the 'fd'
field will be more natural. (Anybody who dups a file descriptor, and
then tells the event loop to watch both file descriptors, is asking for
trouble under any scheme...)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

