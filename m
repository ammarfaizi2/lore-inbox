Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132566AbRAVSyg>; Mon, 22 Jan 2001 13:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132685AbRAVSy0>; Mon, 22 Jan 2001 13:54:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:33808 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132566AbRAVSyT>; Mon, 22 Jan 2001 13:54:19 -0500
Date: Mon, 22 Jan 2001 10:54:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Val Henson <vhenson@esscom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010122111344.A17540@esscom.com>
Message-ID: <Pine.LNX.4.10.10101221051520.15227-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jan 2001, Val Henson wrote:

> On Wed, Jan 17, 2001 at 11:32:35AM -0800, Linus Torvalds wrote:
> > 
> > However, for socket->socket, we would not have such an advantage.  A
> > socket->socket sendfile() would not avoid any copies the way the
> > networking is done today.  That _may_ change, of course.  But it might
> > not.  And I'd rather tell people using sendfile() that you get EINVAL if
> > it isn't able to optimize the transfer.. 
> 
> Yes, socket->socket sendfile is not that sexy.  I actually did this
> for 2.2.16 in the obvious (and stupid) way, copying data into a buffer
> and writing it it out again.  The performance was unsurprisingly
> _exactly_ identical to a userspace read()/write() loop.

The thing is, that if I knew that I could always beat the user-space
numbers (by virtue of having fewer system calls etc), I would still
consider "sendfile()" to be ok for it.

But we can actually do _worse_ in sendfile() than in user-space
applications. For example, userspace "read+write" may now more about
packet boundary behaviour etc, which sendfile is totally clueless about,
so a userspace application might actually get _better_ performance by
doing it by hand.

That's why I currently want sendfile() to only work for the things we
_know_ we can do better.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
