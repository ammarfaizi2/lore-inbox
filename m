Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRCZWPt>; Mon, 26 Mar 2001 17:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRCZWPb>; Mon, 26 Mar 2001 17:15:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:50192 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129506AbRCZWNo>; Mon, 26 Mar 2001 17:13:44 -0500
Date: Mon, 26 Mar 2001 14:12:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <John.L.Byrne@compaq.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Larger dev_t
In-Reply-To: <3ABFB20E.DFB37BFA@kahuna.cag.cpqcorp.net>
Message-ID: <Pine.LNX.4.31.0103261409490.12326-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Mar 2001, John Byrne wrote:

> > Re: Larger dev_t
> >
> On Sat Mar 24 2001 Linus Torvalds (torvalds@transmeta.com) wrote:
> > There is no way in HELL I will ever accept a 64-bit dev_t.
> >
> > I _will_ accept a 32-bit dev_t, with 12 bits for major numbers, and 20
> > bits for minor numbers.
>
> Do you have any interest in doing away with the concept of major and
> minor numbers altogether; turning the dev_t into an opaque unique id?

Inside the kernel we'll eventually do that.

However, outside the kernel you still need the notion of device numbers if
for no other reasons than legacy /dev space (other applications like 'tar'
care too, but they only care about uniqueness, not about much else).

> At the application level, the kinds of information that is derived from
> the major/minor number should probably be derived in some other manner
> such as a library or system call.

It is. It's called "stat()", and a lot of people do depend on a
device number being available. Few people care what that number actually
_is_, though.

So device numbers aren't going away, they are very much part of the UNIX
legacy. We don't need to care about them too much inside the kernel,
though. What most drivers really want to know is "sub-unit number", and
not much else.

			Linus

