Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbREVPX4>; Tue, 22 May 2001 11:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbREVPXp>; Tue, 22 May 2001 11:23:45 -0400
Received: from waste.org ([209.173.204.2]:38757 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261856AbREVPXe>;
	Tue, 22 May 2001 11:23:34 -0400
Date: Tue, 22 May 2001 10:24:53 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device
 arguments from lookup)
In-Reply-To: <01052122143002.06233@starship>
Message-ID: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Daniel Phillips wrote:

> On Monday 21 May 2001 19:16, Oliver Xymoron wrote:
> > What I'd like to see:
> >
> > - An interface for registering an array of related devices (almost
> > always two: raw and ctl) and their legacy device numbers with a
> > single userspace callout that does whatever /dev/ creation needs to
> > be done. Thus, naming and permissions live in user space. No "device
> > node is also a directory" weirdness...
>
> Could you be specific about what is weird about it?

*boggle*

Without precedent in any other UNIX? Or other operating systems, for that
matter? Can you honestly say it doesn't strike you as weird? It's beating
the least surprise rule with a big stick, fercryinoutloud.

Ok, so technically UNIX directories were once just files. But it's been a
long time since people thought exposing that implementation detail was a
good idea, and anyway, it's the opposite situation (and no longer true on
modern fses).

I don't think it's likely to be even workable. Just consider the directory
entry for a moment - is it going to be marked d or [cb]? If it doesn't
have the directory bit set, Midnight commander won't let me look at it,
and I wouldn't blame cd or ls for complaining. If it does have the 'd' bit
set, I wouldn't blame cp, tar, find, or a million other programs if they
did the wrong thing. They've had 30 years to expect that files aren't
directories. They're going to act weird.

Linus has been kicking this idea around for a couple years now and it's
still a cute solution looking for a problem. It just doesn't belong in
UNIX.

More importantly, there's no call for the weirdness. Look, we've already
got to have a userspace callout for new devices so that we can do config,
firmware downloading, automounting, etc. There's no reason we can't stick
the rest of the dynamic /dev/ magic in userspace with the same mechanism.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

