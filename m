Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261947AbRESSOh>; Sat, 19 May 2001 14:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261939AbRESSO1>; Sat, 19 May 2001 14:14:27 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64785 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261932AbRESSOM>; Sat, 19 May 2001 14:14:12 -0400
Date: Sat, 19 May 2001 11:13:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]
 device arguments from lookup)
In-Reply-To: <Pine.GSO.4.21.0105190940310.5339-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105191104240.14472-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 May 2001, Alexander Viro wrote:
>
> 	Folks, before you get all excited about cramming side effects into
> open(2), consider the following case:

Your argument is stupid, imnsho.

Side-effects are perfectly fine if they are _local_ to the file
descriptor. Your example is contrieved and idiotic.

Filename extensions would not replace ioctl's. But they are wonderful ways
to avoid unnecessary binary name-spaces, like the ones we have with
"callout" TTY names, and the one that the fb people had.

For example, do a "ls -l /dev/fd0*", and ponder. Also, realize that we
have these hard-coded names in _addition_ to the magic ioctl to set even
more parameters. These are all stupid and bad, and it would have been a
_lot_ cleaner to be able to do

	open("/dev/fd0/H1440", O_RDWR)..

or

	open("/dev/fd0/HD,18,85", O_RDWD)

to open special non-standard high-density modes.

We already did this, in a very limited and stupid way, by encoding the
minor number and generating a standard naming scheme. We can do the same
thing in a _much_ more generic way by just realizing that we wanted the
open to be name-based in the first place.

These are _not_ side effects. They are very much naming conventions. If I
want to open a the floppy in one of the special extended modes, it makes a
LOT more sense to just open it with the naming, than to open a "generic"
floppy device only to them use a magic and very unreadable ioctl to set
the mode of the device.

In short, I don't buy your arguments for one single second.

		Linus

