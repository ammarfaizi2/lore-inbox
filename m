Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbRAPJUc>; Tue, 16 Jan 2001 04:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbRAPJUX>; Tue, 16 Jan 2001 04:20:23 -0500
Received: from chiara.elte.hu ([157.181.150.200]:6417 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129735AbRAPJUI>;
	Tue, 16 Jan 2001 04:20:08 -0500
Date: Tue, 16 Jan 2001 10:19:39 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: [patch] sendpath() support, 2.4.0-test3/-ac9
In-Reply-To: <Pine.LNX.4.30.0101152049580.14995-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.30.0101161016250.673-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Jan 2001, dean gaudet wrote:

> > just for kicks i've implemented sendpath() support.
> >
> > _syscall4 (int, sendpath, int, out_fd, char *, path, off_t *, off, size_t, size)
>
> hey so how do you implement transmit timeouts with sendpath() ?
> (i.e. drop the client after 30 seconds of no progress.)

well this problem is not unique to sendpath(), sendfile() has it as well.

in TUX i've added per-socket connection timers, and i believe something
like this should be done in Apache as well - timers are IMO not a good
enough excuse for avoiding event-based IO models and using select() or
poll().

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
