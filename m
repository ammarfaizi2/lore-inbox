Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSKAT76>; Fri, 1 Nov 2002 14:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbSKAT7x>; Fri, 1 Nov 2002 14:59:53 -0500
Received: from cse.ogi.edu ([129.95.20.2]:46059 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265728AbSKAT6W>;
	Fri, 1 Nov 2002 14:58:22 -0500
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Dan Kegel <dank@kegel.com>, Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
References: <Pine.LNX.4.44.0210311043380.1562-100000@blue1.dev.mcafeelabs.com>
	<3DC2BCF5.5010607@kegel.com> <20021101191643.GA1471@bjl1.asuk.net>
From: Charlie Krasic <krasic@acm.org>
Date: 01 Nov 2002 12:04:44 -0800
In-Reply-To: <20021101191643.GA1471@bjl1.asuk.net>
Message-ID: <xu43cqlys2r.fsf@turing.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jamie Lokier <lk@tantalophile.demon.co.uk> writes:

> For this sort of thing, I would like to see an option to automatically
> set the non-blocking flag on accept().  To really squeeze the system
> calls, you could also automatically epoll-register on accept(), and
> for super bonus automatically do the accept() at event delivery time.

> But it's getting very silly at that point.

> -- Jamie

I would like to see a new kind of nonblocking flag that implies the
use of epoll.  So instead of giving O_NONBLOCK to fctnl(F_SETFL), you
give O_NONBLOCK_EPOLL.  In addition to becoming non-blocking, the
socket is added to epoll interest set.  Furthermore, if the socket is
a "listener" socket, all connections accepted on the socket inherit
the non-blocking status and are added automatically to the same epoll
interest set.  It's true that this can get silly though.  I'd like to
do the same with other flags, like TCP_CORK.

-- Buck

> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
