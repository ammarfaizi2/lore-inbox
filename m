Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262182AbRETTnS>; Sun, 20 May 2001 15:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbRETTnI>; Sun, 20 May 2001 15:43:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18418 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262182AbRETTmy>;
	Sun, 20 May 2001 15:42:54 -0400
Date: Sun, 20 May 2001 15:42:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Russell King <rmk@arm.linux.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.LNX.4.21.0105201208360.7553-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105201512450.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Linus Torvalds wrote:

> No, but the point is, everybody _would_ consider it a bug if a
> low-level driver "write()" did anything but touched the explicit buffer.
> 
> Code like that would not pass through anybody's yuck-o-meter. People would
> point fingers and say "That is not a legal write() function". Anybody who
> tried to make write() follow pointers would be laughed at as a stupid git.

Linus, as much as I'd like to agree with you, you are hopeless optimist.
90% of drivers contain code written by stupid gits.
 
> Anybody who makes "ioctl()" do the same is just following years of
> standard practice, and the yuck-o-meter doesn't even register.

Nobody reads the drivers. Because otherwise yuck-o-meters would go off-scale.

How about yuck value of the
	* removing a file by writing "-1" into it?
	* mkdir() populating directory.
	* unlink() not working in said directory.
	* rmdir() happily removing it. And freeing all associated structures.
Opened files? What opened files? Whaddya mean, "oops"?

How about sprintf(s + strlen(s), foo)?

How about a collection of b0rken strtoul() implementations? Including one
that contains
	switch (...) {
		case 48:
		case 49:
	(all 22 cases)

How about declaring global array and comparing it with NULL?

How about the whole binfmt_misc.c?

Ehh...

Linus, I've been doing exactly that (reading through the large parts of
tree) and trust me, yuck-o-meter was off-scale almost permanently. Level
of idiocy in the obvious bugs is such that I bet you anything that code
had never been really read through by anyone who knew C.

I would love it if more people actually cared to read the fscking code.
Too few are doing that.

And yes, it's a psychological problem, not a technical one. Oh, well...

Sorry about the rant - I've just spent a couple of hours wading through
the piles of excrements in drivers/*. Ouch.

