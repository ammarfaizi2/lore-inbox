Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276894AbRKDAqI>; Sat, 3 Nov 2001 19:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRKDAp7>; Sat, 3 Nov 2001 19:45:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3081 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276894AbRKDApw>; Sat, 3 Nov 2001 19:45:52 -0500
Date: Sat, 3 Nov 2001 16:43:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Juergen Doelle <jdoelle@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Pls apply this spinlock patch to the kernel
In-Reply-To: <20011103130156.D5984@twiddle.net>
Message-ID: <Pine.LNX.4.33.0111031640350.2283-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 3 Nov 2001, Richard Henderson wrote:
>
> On Sat, Nov 03, 2001 at 12:20:53PM -0800, Linus Torvalds wrote:
> > If you have a 4-byte entry that is aligned to 128 bytes, you have 124
> > bytes of stuff that the linker _will_ fill up with other things.
>
> If you put the alignment on the type, not the variable, e.g.

That doesn't work.

The whole _point_ here is to make the thing variable-specific, so that we
can say _this_ spinlock needs a cache-line of its own, without blowing up
all spinlocks to 128 bytes.

There's no way we want 128-byte spinlocks in general. We want to mark 4-5
spinlocks as being so critical that they can have a cacheline of their
own. But I do _not_ want to have special operations for those spinlocks,
so I don't want those spinlocks to have any special types (ie the actual
_user_ should not need to care, so that you can play around with testing
the different spinlocks one by one without having to edit all the users of
any specific spinlock).

		Linus

