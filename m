Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131045AbRAPFAB>; Tue, 16 Jan 2001 00:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbRAPE7u>; Mon, 15 Jan 2001 23:59:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52496 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131045AbRAPE7h>; Mon, 15 Jan 2001 23:59:37 -0500
Date: Mon, 15 Jan 2001 20:59:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: [patch] sendpath() support, 2.4.0-test3/-ac9
In-Reply-To: <Pine.LNX.4.30.0101152049580.14995-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.10.10101152056170.12667-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jan 2001, dean gaudet wrote:

> On Mon, 15 Jan 2001, Ingo Molnar wrote:
> 
> > just for kicks i've implemented sendpath() support.
> >
> > _syscall4 (int, sendpath, int, out_fd, char *, path, off_t *, off, size_t, size)
> 
> hey so how do you implement transmit timeouts with sendpath() ?  (i.e.
> drop the client after 30 seconds of no progress.)

The whole "sendpath()" idea is just stupid.

You want to do a non-blocking send, so that you don't block on the socket,
and do some simple multiplexing in your server. 

And "sendpath()" cannot do that without having to look up the name again,
and again, and again. Which makes the performance "optimization" a
horrible pessimisation.

Basically, sendpath() seems to be only useful for blocking and
uninterruptible file sending.

Bad design. I'm not touching it with a ten-foot pole.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
