Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131260AbRARGqp>; Thu, 18 Jan 2001 01:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131906AbRARGqf>; Thu, 18 Jan 2001 01:46:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8970 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131260AbRARGqW>; Thu, 18 Jan 2001 01:46:22 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Documenting stat(2)
Date: 17 Jan 2001 22:46:11 -0800
Organization: Transmeta Corporation
Message-ID: <9463fj$gsq$1@penguin.transmeta.com>
In-Reply-To: <20010118002812.A19810@thyrsus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010118002812.A19810@thyrsus.com>,
Eric S. Raymond <esr@thyrsus.com> wrote:
>
>* For a socket or FIFO (S_IFSOCK, S_IFIFO) it reports the count of bytes
>waiting to be read. 

Don't depend on it. That's pretty much implementation-defined: use the
FIONREAD ioctl to fetch available info from pipes, sockets, ttys etc.

Some versions of Linux will _not_ give the size of the pipe from stat(),
if I remember correctly.  And as far as I know, no version of Linux will
have st_size mean anything at all for sockets (pipes, yes.  Both named
and unnamed - at least with the current implementation.  But not
sockets.  How could, it, anyway, as a socket name is nothing but a bind
entry, and can have many sockets associated with it?). 

>* For a block special device (S_IFBLK) it returns 0.

Again, this is not something you should depend on. Older Linuxes tried
to return the size of the block device, again if my memory serves me.

>I don't know what it should be expected to return for terminal or
>other special devices.  My guess is number of characters waiting
>in clists.

Nope. Use FIONREAD for that.

Linux will normally return 0.

>Can anyone verify, correct, or expand on the above?  Reply to 
>esr@thyrsus.com, please, and thanks in advance.

Basically, the _only_ think you should depend on is that st_size
contains:
 - for regular files, the size of the file in bytes
 - for symlinks, the length of the symlink.

That's it. Anybody who tries to use anything else is nonportable, and is
almost guaranteed to not work reliably even on just different versions
of Linux, never mind anything else.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
