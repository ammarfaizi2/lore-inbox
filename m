Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261965AbRESXTz>; Sat, 19 May 2001 19:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbRESXTq>; Sat, 19 May 2001 19:19:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3462 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261965AbRESXTb>;
	Sat, 19 May 2001 19:19:31 -0400
Date: Sat, 19 May 2001 19:19:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]
 device arguments from lookup)
In-Reply-To: <Pine.LNX.4.21.0105191104240.14472-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105191904490.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Linus Torvalds wrote:

> 
> On Sat, 19 May 2001, Alexander Viro wrote:
> >
> > 	Folks, before you get all excited about cramming side effects into
> > open(2), consider the following case:
> 
> Your argument is stupid, imnsho.
> 
> Side-effects are perfectly fine if they are _local_ to the file
> descriptor. Your example is contrieved and idiotic.

Linus, would you _look_ at the uses of open() proposed upthread?

Would you like to argue that close(open("/bin/ls,-l,/etc/passwd", O_RDONLY));
as equivalent of spawn(3) is _not_ contrieved and idiotic?

Would you like to argue that close(open("/dev/md0/..add-...=/foo/bar",O_RDONLY))
as a way to add stripes is not contrieved and idiotic?
 
> These are _not_ side effects. They are very much naming conventions. If I

I would say that both examples above (both really proposed) _are_ side
effects by any definition.

> want to open a the floppy in one of the special extended modes, it makes a
> LOT more sense to just open it with the naming, than to open a "generic"
> floppy device only to them use a magic and very unreadable ioctl to set
> the mode of the device.

Who argues for ioctls? I'm perfectly OK with the stuff that affects future
IO on the descriptor you've opened. That's what open() is for, after all.
However, IMNSHO examples of abusing open() (see above, grep your mailbox if
you think that I'm making it up) posted to that thread _are_ side effects
- ugly as hell, contrieved and bound to be source of exploits.

