Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbSJ2Bpd>; Mon, 28 Oct 2002 20:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSJ2Bpd>; Mon, 28 Oct 2002 20:45:33 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:54183 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261439AbSJ2Bpc>;
	Mon, 28 Oct 2002 20:45:32 -0500
Date: Tue, 29 Oct 2002 01:51:39 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029015139.GB18727@bjl1.asuk.net>
References: <20021028234434.GB18415@bjl1.asuk.net> <Pine.LNX.4.44.0210281556020.966-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210281556020.966-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Jamie, doing that is not a real problem. The fact is that sys_epoll aimed
> to solve issues where scalability on huge number of fds is involved. By
> covering sockets ( network connections ) and pipes ( cgi execution ) you
> have a pretty wide scalability addressing. Usually you know from where and
> fd born, so you're typically able to handle it correctly. Those reasons,
> togheter with the fact that I did not want to introduce revolutions in the
> kernel, drove me to limit the sys_epoll coverage to sockets and pipes.

Oh I agree this is an acceptable limitation.  Just wondering whether I
can safely depend on an fd being a socket/pipe being sufficient?
I.e. does it work on a non-IP socket, a packet socket, an IPX socket
etc?

It would be good if epoll would at least refuse to register fds that
it can't handle, returning EINVAL for them.  If it's as simple as
socket+pipe, that's a trivial test in ep_insert.

I've just read the /dev/epoll patch.  I think it makes sense, in the
long run, to share infrastructure with that other event notification
subsystem - sigio.  The two should really be interchangable interfaces
to the same underlying event notification system - not one interface
handling some fds and the other handling different fds.

(Ideally, though, with the new waitqueue wakeup callback functions
that were needed for aio the old fd poll mechanism can be made to
generate events - which epoll and sigio and aio and poll() could all
use - full circle back to a beautiful and harmonious unix world once
more.)

-- Jamie
