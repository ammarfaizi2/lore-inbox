Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271244AbRHTPW3>; Mon, 20 Aug 2001 11:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271269AbRHTPWT>; Mon, 20 Aug 2001 11:22:19 -0400
Received: from waste.org ([209.173.204.2]:12346 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S271244AbRHTPWO>;
	Mon, 20 Aug 2001 11:22:14 -0400
Date: Mon, 20 Aug 2001 10:22:20 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Theodore Tso <tytso@mit.edu>, David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <3B8124C4.7A4275B9@nortelnetworks.com>
Message-ID: <Pine.LNX.4.30.0108201007380.4612-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Chris Friesen wrote:

> Alex Bligh - linux-kernel wrote:
>
> > An alternative approach to all of this, perhaps, would be to use extremely
> > finely grained timers (if they exist), in which case more bits of entropy
> > could perhaps be derived per sample, and perhaps sample them on
> > more operations. I don't know what the finest resolution timer we have
> > is, but I'd have thought people would be happier using ANY existing
> > mechanism (including network IRQs) if the timer resolution was (say)
> > 1 nanosecond.
>
> Why don't we also switch to a cryptographically secure algorithm for
> /dev/urandom?  Then we could seed it with a value from /dev/random and we would
> have a known number of cryptographically secure pseudorandom values.  Once we
> reach the end of the png cycle, we could re-seed it with another value from
> /dev/random.

/dev/random and /dev/urandom use the same SHA1 hashing algorithm and there
are no known practical attacks against them. What makes /dev/random
different is that it keeps track of how much random information has been
put in vs how much is taken out and never lets you go below zero. This
means that the data coming out (already unguessable in practice) is now
unguessable even in theory[1].

This whole discussion is pretty silly. /dev/urandom is already at least as
strong as any encryption scheme you're likely to use with it. To break it,
you're going to have break SHA over a 512-bit pool with a nasty round
function, never mind all the other complexities. It's almost certainly
more practical for someone to brute force your 128-bit SSL session keys or
factor your RSA keys. Or beat your root password out of you with a rubber
hose.

[1] Assuming its entropy estimates are conservative enough.
--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

