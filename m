Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131150AbQLPLRs>; Sat, 16 Dec 2000 06:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbQLPLR2>; Sat, 16 Dec 2000 06:17:28 -0500
Received: from janeway.cistron.net ([195.64.65.23]:48396 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S131150AbQLPLRX>; Sat, 16 Dec 2000 06:17:23 -0500
Date: Sat, 16 Dec 2000 11:46:45 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TIOCGDEV ioctl
Message-ID: <20001216114645.A8944@cistron.nl>
In-Reply-To: <Pine.LNX.4.10.10012151710040.1325-100000@penguin.transmeta.com> <Pine.GSO.4.21.0012152038560.13037-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012152038560.13037-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Dec 15, 2000 at 08:54:01PM -0500
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Alexander Viro:
> On Fri, 15 Dec 2000, Linus Torvalds wrote:
> 
> > Please instead do the same thing /dev/tty does, namely a sane interface
> > that shows it as a symlink in /proc (or even in /dev)
> 
> There you go... (/proc/tty/console -> /dev/tty<current_VC>; may very well

The current VT (fg_console) and /dev/console are 2 different things ...
/dev/console might be /dev/ttyS1. Besides to get at fg_console
we already have ioctl(/dev/tty0, TIOCLINUX, 12)

There is currently no way to find out with what device /dev/console
is associated.

Why is that needed? For example, I wrote a program 'bootlogd' that opens
/dev/console and a pty pair, uses TIOCCONS to redirect console
messages to the pty pair so they can be logged. However one would
like to write those messages to the _actual_ console as well, but
there is no way to find out what the real console is.

For this application a ioctl is better than a /proc symlink since
it would be started before /proc is even mounted.

Mike.
-- 
RAND USR 16514
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
