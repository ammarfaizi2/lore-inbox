Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262514AbREUWLE>; Mon, 21 May 2001 18:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262511AbREUWKz>; Mon, 21 May 2001 18:10:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23307 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262509AbREUWKl>; Mon, 21 May 2001 18:10:41 -0400
Date: Mon, 21 May 2001 15:10:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alexander Viro <viro@math.psu.edu>, Pavel Machek <pavel@suse.cz>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <E151xfH-0000xg-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0105211503560.10331-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 May 2001, Alan Cox wrote:
>
> > Sure. But we have to do two syscalls only if ioctl has both in- and out-
> > arguments that way. Moreover, we are talking about non-trivial in- arguments.
> > How many of these are in hotspots?
>
> There is also a second question. How do you ensure the read is for the right
> data when you are sharing a file handle with another thread..
>
> ioctl() has the nice property that an in/out ioctl is implicitly synchronized

I don't think we can generically replace ioctl's with read-write, and we
shouldn't bend over backwards even _trying_.

The important thing would be to give them more structure, and as far as
I'm personally concerned I don't even care if the user-level access method
ends up being the same old thing. After all, we have magic numbers
everywhere: even a system call uses magic numbers for the syscall entry
numbering. The thing that makes system call numbers nice is that the
number gets turned into a more structured thing with proper type checking
and well-defined semantics very very early on indeed.

It shouldn't be impossible to do the same thing to ioctl numbers. Nastier,
yes. No question about it. But we don't necessarily have to redesign the
whole approach - we only want to re-design the internal kernel interfaces.

That, in turn, might be as simple as changing the ioctl incoming arguments
of <cmd,arg> into a structure like <type,cmd,inbuf,inlen,outbuf,outlen>.

		Linus

