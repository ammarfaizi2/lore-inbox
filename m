Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSJaWbk>; Thu, 31 Oct 2002 17:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265441AbSJaWbk>; Thu, 31 Oct 2002 17:31:40 -0500
Received: from almesberger.net ([63.105.73.239]:62471 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265437AbSJaWa6>; Thu, 31 Oct 2002 17:30:58 -0500
Date: Thu, 31 Oct 2002 19:37:05 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021031193705.C2599@almesberger.net>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com> <3DC19A4C.40908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC19A4C.40908@pobox.com>; from jgarzik@pobox.com on Thu, Oct 31, 2002 at 04:02:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> That said, I used to be an LKCD cheerleader until a couple people made 
> some good points to me:  it is not nearly low-level enough to truly be 
> of use in crash situations.

I'm not so convinced about this. I like the Mission Critical
approach: save the dump to memory, then either boot through the
firmware or through bootimg (nowadays, that would be kexec),
then retrieve the dump from memory, and do whatever you like
with it.

The huge advantage here is that you don't need a ton of
specialized dump drivers and/or have much of the original kernel
infrastructure to be in a usable state. The rebooted system will
typically be stable enough to offer the full range of utilities,
including up to date drivers for all possible devices, so you
can safely write to disk, scp all the mess to your support
critter, or post an automatic flame to linux-kernel :-)

The weak points of the Mission Critical design are that early
memory allocation in the kernel needs to be tightly controlled,
that architectures that wipe CPU caches on reboot need to
commit them to memory before the firmware restart, and that
drivers need to be able to recover from an "unclean" hardware
state. (I think we'll see much of the latter happen as kexec
advances. The other two issues aren't really special.)

Actually, at the RAS BOF I thought that IBM were developing LKCD
in this direction, and had also eliminated a few not so elegant
choices of Mission Critical's original design. I haven't looked
at the LKCD code, but the descriptions sound as if all the
special-case cruft seems to be back again, which I would find a
little disappointing.

There might be a case for specialized low-overhead dump handlers
for small embedded systems and such, but they're probably better
maintained outside of the mainstream kernel. (They're more like
firmware anyway.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
