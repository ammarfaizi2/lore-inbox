Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbRETTMS>; Sun, 20 May 2001 15:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262150AbRETTMM>; Sun, 20 May 2001 15:12:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37064 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262148AbRETTLy>;
	Sun, 20 May 2001 15:11:54 -0400
Date: Sun, 20 May 2001 15:11:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
In-Reply-To: <Pine.LNX.4.21.0105201150110.7553-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105201509060.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Linus Torvalds wrote:

> Now, a good way to force the issue may be to just remove the "ioctl"
> function pointer from the file operations structure altogether. We don't
> have to force peopel to use "read/write" - we can just make it clear that
> ioctl's _have_ to be wrapped, and that the only ioctl's that are
> acceptable are the ones that are well-designed enough to be wrappable. So
> we'd have a "linux/fs/ioctl.c" that would do all the wrapping, and would
> also be able to do all the stuff that is currently done by pretty much
> every single architecture out there (ie emulation of ioctl's for different
> native modes).

Pheeew... Could you spell "about megabyte of stuff in ioctl.c"?

> It would probably not be that horrible. Many ioctl's are probably not all
> that much used by any real programs any more. The most common ones by far
> are the tty ones - and the truly generic ones like "FIONREAD" that it
> actually would make sense to generalize more.

Networking stuff. It _is_ used.
 
> Catching stuff like EJECT at a higher layer and turning THOSE kinds of
> things into real block device operations would clean up drivers and make
> them more uniform.
> 
> Would fs/ioctl.c be an ugly mess of some special cases? Yes. But would
> that make the ugliness explicit and possibly easier to try to manage and
> fix? Very probably. And it would mean that driver writers could not just
> say "fuck design, I'm going to do this my own really ugly way". 

How about moratorium on new ioctls in the meanwhile? Whatever we do in
fs/ioctl.c, it _will_ take time.
								Al

