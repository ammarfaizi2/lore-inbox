Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbRE0UoL>; Sun, 27 May 2001 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbRE0UoB>; Sun, 27 May 2001 16:44:01 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28689 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262197AbRE0Unu>; Sun, 27 May 2001 16:43:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Edgar Toernig <froese@gmx.de>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Sun, 27 May 2001 22:45:17 +0200
X-Mailer: KMail [version 1.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105270036060Z.06233@starship> <3B1101ED.3BF181F6@gmx.de>
In-Reply-To: <3B1101ED.3BF181F6@gmx.de>
MIME-Version: 1.0
Message-Id: <01052722451714.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 May 2001 15:32, Edgar Toernig wrote:
> Daniel Phillips wrote:
> > It won't, the open for "." is handled in the VFS, not the
> > filesystem - it will open the directory.  (Without needing to be
> > told it's a directory via O_DIRECTORY.)  If you do open("magicdev")
> > you'll get the device, because that's handled by magicdevfs.
>
> You really mean that "magicdev" is a directory and:
>
> 	open("magicdev/.", O_RDONLY);
> 	open("magicdev", O_RDONLY);
>
> would both succeed but open different objects?

Yes, and:

        open("magicdev/.", O_RDONLY | O_DIRECTORY);
        open("magicdev", O_RDONLY | O_DIRECTORY);

will both succeed and open the same object.

> > I'm not claiming there isn't breakage somewhere,
>
> you break UNIX fundamentals.  But I'm quite relieved now because I'm
> pretty sure that something like that will never go into the kernel.

OK, I'll take that as "I couldn't find a piece of code that breaks, so 
it's on to the legal issues".

SUS doesn't seem to have a lot to say about this.  The nearest thing to 
a ruling I found was "The special filename dot refers to the directory 
specified by its predecessor".  Which is not the same thing as:

   open("foo", O_RDONLY) == open ("foo/.", O_RDONLY)

I don't know about POSIX (I don't have it: a pox on standards 
organizations that don't make their standards freely available) but SUS 
doesn't seem to forbid this.

--
Daniel
