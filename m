Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBHTwx>; Thu, 8 Feb 2001 14:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbRBHTwo>; Thu, 8 Feb 2001 14:52:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129098AbRBHTwa>; Thu, 8 Feb 2001 14:52:30 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: TCP_NOPUSH on FreeBSD, TCP_CORK on Linux (was: Is sendfile all that
Date: 8 Feb 2001 11:52:01 -0800
Organization: Transmeta Corporation
Message-ID: <95utd1$6rh$1@penguin.transmeta.com>
In-Reply-To: <3A81F60C.7C1DB09A@alumni.caltech.edu> <20010208035803.L74296@hand.dotat.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010208035803.L74296@hand.dotat.at>,
Tony Finch  <dot@dotat.at> wrote:
>Dan Kegel <dank@alumni.caltech.edu> wrote:
>>
>>Tony, are people using the TCP_NOPUSH define as a way to detect
>>the presence of T/TCP support?
>
>No, MSG_EOF is the right way to do that.

However, I think ank is at least partially correct: TCP_NOPUSH has some
magic behaviour for sockets in listen state, and turns on at least some
T/TCP semantics, if I remember correctly. Tony?

If I remember correctly, may I suggest something: make a new BSD option
called (ehh, just random name ;) TCP_CORK, and make the old BSD
TCP_NOPUSH option be a superset of TCP_CORK that also turns on T/TCP on
listen sockets.

Linux TCP_CORK doesn't have anything to do with T/TCP (not surprisingly,
as T/TCP is considered a broken protocol in Linux and other circles).

And Linux TCP_CORK _is_ used on listen sockets: it makes sockets that
are accepted from the listen socket have the corking semantics. In
contrast, BSD TCP_NOPUSH, I think, has this overloading issue..

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
