Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBFX1l>; Tue, 6 Feb 2001 18:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129800AbRBFX1b>; Tue, 6 Feb 2001 18:27:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51217 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129106AbRBFX1S>; Tue, 6 Feb 2001 18:27:18 -0500
Date: Tue, 6 Feb 2001 15:26:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Jens Axboe <axboe@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.21.0102061900060.23574-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10102061516570.1972-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Marcelo Tosatti wrote:
> 
> Its arguing against making a smart application block on the disk while its
> able to use the CPU for other work.

There are currently no other alternatives in user space. You'd have to
create whole new interfaces for aio_read/write, and ways for the kernel to
inform user space that "now you can re-try submitting your IO".

Could be done. But that's a big thing.

> An application which sets non blocking behavior and busy waits for a
> request (which seems to be your argument) is just stupid, of course.

Tell me what else it could do at some point? You need something like
select() to wait on it. There are no such interfaces right now...

(besides, latency would suck. I bet you're better off waiting for the
requests if they are all used up. It takes too long to get deep into the
kernel from user space, and you cannot use the exclusive waiters with its
anti-herd behaviour etc).

Simple rule: if you want to optimize concurrency and avoid waiting - use
several processes or threads instead. At which point you can get real work
done on multiple CPU's, instead of worrying about what happens when you
have to wait on the disk.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
