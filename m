Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSKUAqt>; Wed, 20 Nov 2002 19:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbSKUAqt>; Wed, 20 Nov 2002 19:46:49 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:651 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262322AbSKUAqs>;
	Wed, 20 Nov 2002 19:46:48 -0500
Date: Thu, 21 Nov 2002 00:55:02 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021121005502.GE12650@bjl1.asuk.net>
References: <20021120235135.GA32715@mark.mielke.cc> <Pine.LNX.4.44.0211201546250.974-100000@blue1.dev.mcafeelabs.com> <20021121003332.GE32715@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121003332.GE32715@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> It looks fine to me for as long as we can guarantee that sizeof(void *)
> will be less than or equal to sizeof(__uint64_t) (relatively safe).

It is fine, for epoll itself, even if sizeof(void *) > sizeof(__uint64_t).

Conversion functions for legacy 32-bit code running on a 128-bit chip
will be more complex, but epoll is the _least_ of problems in that case...

> I still prefer 'userdata' over 'obj', but the name of thing is not very
> important to me.

The AIO subsystem has a very similar cookie, which is simply declared
as `__u64 aio_data' in user-supplied requests, and returned in the
responses.  It's converted to a field called `ki_user_data' in the
kernel.

Just a few reference points...  I like `user_data' myself.

> I'm not sure if this is wise or not, but an 'fd' member might be
> useful as well:
> [...]
> For applications that wish to store fd's (probably common due to
> poll() roots), this would help them avoid casting magic as well. Also,
> it allows for 64 bit file descriptors if that ever became necessary.

That is a good idea, if we go for the union.

-- Jamie
