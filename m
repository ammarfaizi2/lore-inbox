Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUBOClg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 21:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUBOClf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 21:41:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:14274 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263800AbUBOClc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 21:41:32 -0500
Date: Sat, 14 Feb 2004 18:41:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior
In-Reply-To: <200402150107.26277.robin.rosenberg.lists@dewire.com>
Message-ID: <Pine.LNX.4.58.0402141827200.14025@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Feb 2004, Robin Rosenberg wrote:
> > 
> > Bullshit.  It has _nothing_ to characters, wide or not.  For system filenames
> > are opaque.  The only things that have special meanings are:
> > 	octet 0x2f ('/') splits the pathname into components
> > 	"." as a component has a special meaning
> > 	".." as a component has a special meaning.
> > That's it.  The rest is never interpreted by the kernel.
>
> I know how it is (to some degree), and its wrong. The user sees inside the filename
> and sees a string of characters, not a byte sequence.

Yes, the user sees a string of characters, but the octet 0x2f ('/') and 
the terminating NUL character '\0' are still perfectly normal characters 
and there is no confusion.

The reason: UTF-8. It's the only sane encoding (apart from a pure extended
ASCII setup, which is also sane, but is obviously unacceptable for a large
portion of the world).

If some misguided person has told you about UCS-2 and horrors like UTF-9,
just ignore them. They are crazy and deluded, and - perhaps more
importantly - stupid.

In short: the kernel talks bytestreams, and that implies that if you want 
to talk to the kernel, you HAVE TO USE UTF-8.

At which point there are no locale issues any more. The only locale issue 
you can have is user space mistaking a stream of bytes as extended ASCII, 
which will cause all your pretty UTF-8 characters to be shown as strange 
latin1 (or other) squiggles.

> It seems you simply don't want to understand the problem, which is that users 
> CAN HAVE DIFFERENT LOCALES on the same system and on different system. 
> Sigh...

People understand the problem. And UTF-8 is the solution.

It's getting there. I think even Microsoft has seen the light, and is
phasing out their crapola (UCS-2LE? Whatever). 

> I less concerned with which solution than that a solution should be found. So it
> seems no file system has a solution today. Still an iocharset option would relieve
> the problem for removable media and muli-boot systems.

No. Things like "iocharset" are not the solution. They are literally the
_problem_. The solution is to use something that not only acts as ASCII,
but also has a wide enough range to cover the whole required space (UCS-2
fails _both_ of these fundamental tests). At which point "iocharset" makes 
no sense any more, and only exists as a way to translate legacy crap into 
the one true format.

And that one true format is UTF-8. End of story. If you try to talk to the 
kernel in UCS-2 or anything else, you _will_ fail.

			Linus
