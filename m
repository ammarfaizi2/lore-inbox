Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279024AbRKDVlw>; Sun, 4 Nov 2001 16:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279105AbRKDVlm>; Sun, 4 Nov 2001 16:41:42 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:49423 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S279024AbRKDVlX>;
	Sun, 4 Nov 2001 16:41:23 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111042141.fA4LfDY191148@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 4 Nov 2001 16:41:13 -0500 (EST)
Cc: tim@tjansen.de (Tim Jansen), phillips@bonn-fries.net (Daniel Phillips),
        jakob@unthought.net (Jakob =?iso-8859-1?q?=D8stergaard=20?=),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111041321300.21449-100000@weyl.math.psu.edu> from "Alexander Viro" at Nov 04, 2001 01:30:38 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> Folks, could we please deep-six the "ASCII is tough" mentality?

Sure. How about:
It's a PITA to break out the dragon book, bloat sucks,
and I'd just rather not have to write the code.

I also like:
Trusting every little status app to not have exploitable
buffer overruns is worrisome.

The more serious problem:
ASCII formats change in unpredictable ways. (see below)

>  Idea of
> native-endian data is so broken that it's not even funny.  Exercise:
> try to export such thing over the network.

Ooh! You're making /proc NFS exportable?

>  Another one: try to use
> that in a shell script.  One more: try to do it portably in Perl script.

FOO=`ps -o foo= -p $$`    # Get our FOO value out of binary /proc

> It had been tried.  Many times.  It had backfired 100 times out 100.
> We have the same idiocy to thank for fun trying to move a disk with UFS
> volume from Solaris sparc to Solaris x86.

Disks are slow, so native endian UFS was indeed a poor choice.

>  We have the same idiocy to
> thank for a lot of ugliness in X.

This was a necessary performance hack. Hopefully nobody wrote
an X server or client that would do conditional byte swaps
all over the code.

> At the very least, use canonical bytesex and field sizes.  Anything less
> is just begging for trouble.  And in case of procfs or its equivalents,
> _use_ the_ _damn_ _ASCII_ _representations_.  scanf(3) is there for
> purpose.

SigCgt in /proc/self/status wasn't always spelled that way.
It wasn't always in the same location either. ASCII bites
because people can't resist screwing with it.

