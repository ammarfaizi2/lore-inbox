Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157065AbPLVL6p>; Wed, 22 Dec 1999 06:58:45 -0500
Received: by vger.rutgers.edu id <S156684AbPLVL6U>; Wed, 22 Dec 1999 06:58:20 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:1984 "EHLO smtp1.cern.ch") by vger.rutgers.edu with ESMTP id <S157099AbPLVL5v>; Wed, 22 Dec 1999 06:57:51 -0500
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, wendling@ganymede.isdn.uiuc.edu, linux-kernel@vger.rutgers.edu
Subject: Re: [patch] read[bwl] and ioremap problem
References: <199912212348.SAA10433@tsx-prime.MIT.EDU>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 22 Dec 1999 12:57:33 +0100
In-Reply-To: "Theodore Y. Ts'o"'s message of "Tue, 21 Dec 1999 18:48:18 -0500"
Message-ID: <d3zov39oia.fsf@lxplus005.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-kernel@vger.rutgers.edu

>>>>> "Ted" == Theodore Y Ts'o <tytso@mit.edu> writes:

Ted> We've historically said that this kind of thing is horrible for
Ted> performance reasons, and the SCO and NetBSD approaches of doing
Ted> parameterized I/O has been derided for that reason.  However,
Ted> it's something that perhaps we should rethink; on modern CPU's,
Ted> the extra procedure activation/deactivation isn't *that*
Ted> expensive, and it ends up making the drivers much more portable
Ted> and easier to support multiple architectures.  The alternative is
Ted> that each driver author ends up writing their own I/O dispatch
Ted> routines, such as what's currently in the serial driver.  While
Ted> this approach does have some advantages, in that each driver
Ted> author can decide whether or not he/she wishes to pay the
Ted> indirection overhead, it can mean code duplication and a delay
Ted> before certain devices get supported on non-mainline
Ted> architectures.

Oh it still is horrible ;-), and therefore it is something you don't
just want to implement in one big generic solution. You may want to
implement a generic interface that slow devices can use, but for some
high performance devices you really want the bigger freedom and the
option to control which parts are inlined and which are not. Ie. for a
Gigabit Ethernet or a high speed serial driver you may want to inline
parts of this in the fast path while using non-inlined versions for
the slow path bits of it (device initialization etc) to save space.

As a device driver author you may also want to use function pointers
rather than a list of if's for the non inlined case.

Jes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
