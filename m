Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbQKBWrS>; Thu, 2 Nov 2000 17:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKBWrI>; Thu, 2 Nov 2000 17:47:08 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:32655 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129312AbQKBWq4>;
	Thu, 2 Nov 2000 17:46:56 -0500
Date: Thu, 2 Nov 2000 17:46:20 -0500
Message-Id: <200011022246.RAA21440@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Tim Riker <Tim@Rikers.org>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: Tim Riker's message of Thu, 02 Nov 2000 13:53:55 -0700,
	<3A01D463.9ADEF3AF@Rikers.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 02 Nov 2000 13:53:55 -0700
   From: Tim Riker <Tim@Rikers.org>

   As is being discussed here, C99 has some replacements to the gcc syntax
   the kernel uses. I believe the C99 syntax will win in the near future,
   and thus the gcc syntax will have to be removed at some point. In the
   interim the kernel will either move towards supporting both, or a
   quantum jump to support the new gcc3+ compiler only. I am hoping a
   little thought can get put into this such that this change will be less
   painful down the road.

That's reasonable as a long-term goal.  Keep in mind that though there
have been questions in the past about code correctness assumptions of
kernel versus specific GCC versions.  This has been one place where GCC
has tended to blame the kernel developers, and kernel developers have
pointed out (rightly, in my opinion) that the GCC documentation of some
of these features has been less than stellar --- in fact, some would say
non-existent.  If it's not documented, then you don't have much moral
ground to stand upon when people complain that the changes you made
breaks things.

So moving to a C99 syntax is useful simply from the point of view that
it's well documented (unlike the register constraints for inline
functions, which still give me a headache whenever I try to look at the
GCC "documentation").  The problem here is that C99 doesn't (as far as I
know) give us everything we need, so simply moving to C99 syntax won't
be sufficient to support propietary C compilers.

There will also be work needed to make sure that a kernel compiled with
gcc 3.x (whenever it's ready) will actually omit code which was intended
by the kernel developers.  So we're definitely looking at a 2.5+
project, and one which may actually be fairly high risk; it's certainly
not a trivial task.

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
