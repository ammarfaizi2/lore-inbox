Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131640AbQLPLqu>; Sat, 16 Dec 2000 06:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131622AbQLPLq3>; Sat, 16 Dec 2000 06:46:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44779 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131043AbQLPLqT>;
	Sat, 16 Dec 2000 06:46:19 -0500
Date: Sat, 16 Dec 2000 06:15:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Miquel van Smoorenburg <miquels@cistron.nl>
cc: Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TIOCGDEV ioctl
In-Reply-To: <20001216114645.A8944@cistron.nl>
Message-ID: <Pine.GSO.4.21.0012160550240.15518-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Miquel van Smoorenburg wrote:

> There is currently no way to find out with what device /dev/console
> is associated.
> 
> Why is that needed? For example, I wrote a program 'bootlogd' that opens
> /dev/console and a pty pair, uses TIOCCONS to redirect console
> messages to the pty pair so they can be logged. However one would
> like to write those messages to the _actual_ console as well, but
> there is no way to find out what the real console is.
> 
> For this application a ioctl is better than a /proc symlink since
> it would be started before /proc is even mounted.

So mount it... It's not like you didn't have enough privileges for that,
after all, and mount("proc", "/proc", "proc", 0, 0); doesn't look too
complex.

OK, I can see the point of finding out where the console is redirected
to. How about the following:

	/proc/sys/vc -> /dev/tty<n>
	/proc/sys/console -> where the hell did we redirect it or
			     vc if there's no redirect right now
Will that be OK with you?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
