Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266711AbUBQWwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUBQWwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:52:45 -0500
Received: from [212.28.208.94] ([212.28.208.94]:4107 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266711AbUBQWvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:51:00 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: John Bradford <john@grabjohn.com>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Date: Tue, 17 Feb 2004 23:50:58 +0100
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <Pine.LNX.4.58.0402171259440.2154@home.osdl.org> <200402172116.i1HLGESi000350@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200402172116.i1HLGESi000350@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402172350.58184.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 22.16, John Bradford wrote:
> Quote from Linus Torvalds <torvalds@osdl.org>:
> > On Tue, 17 Feb 2004, John Bradford wrote:
> > > > Ok, but... why?  What does 32-bit words get you that UTF-8 does not?
> > > > I can't think of a single advantage, just lots of disadvantages.
> > > The advantage is that you can use them to store UCS-4.
> > Wrong. UTF-8 can store UCS-4 characters just fine.
<nitpick>Yes and no. There are no UTF-8 or UCS-4 characters. These are encodings
for Unicode characters. </nitpick>

> At the end of the day, I just don't see how your suggestion of leaving
> UTF-8 undecoded unless you're presenting it to the user is ever going
> to be practical, which brings us back to my first point, that UTF-8
> can't, in the real world, represent UCS-4 characters acceptably,
> (I.E. unambiguously).
The standard say a decode should not accept invalid UTF-8 characters. Not
decoding them and just pass the garbage on is one way of not "accepting" them; i.e.
"i'm not decoding this trash". In UTF-8 seen as a byte stream this is trivial. Those that 
recode to a 16-bit encoding like QT (recode them to invalid UTF-16 so it can be encoded
back to the original invalid UTF-8). That's at least what the kopete people told me. (Haven't
read the code yet). With UCS-4 or UCS-2 the decoder must reject the data or make a very
good decision. Normalizing is a very bad one, since, as we know, an invalid UTF-8 sequence
simply does not represent a unicode character.

> > > Basically - no more multiple representations of the same thing.  No more
> > > funny corner cases where several different strings of bytes eventually
> > > resolve to the same name being presented to the user.
> > 
> > Welcome to normalized UTF-8. And realize that the "non-normalized" broken 
> > stuff is what allows us backwards compatibility.
And then (above) there is no normalized UTF-8. There are strings of valid characters
and invalid characters. Any app that tries to make sense of any garbage is a security
risk. This apples not only to UTF-8. but function like atof that decodes anything
to a double at best NaN).

-- robin


-- robin
