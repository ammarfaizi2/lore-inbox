Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbRGEQyd>; Thu, 5 Jul 2001 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265915AbRGEQyY>; Thu, 5 Jul 2001 12:54:24 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:14090 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S264754AbRGEQyM>; Thu, 5 Jul 2001 12:54:12 -0400
Date: Thu, 5 Jul 2001 12:54:09 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Rick Hohensee <humbubba@smarty.smart.net>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010705125409.A21739@munchkin.spectacle-pond.org>
In-Reply-To: <20010704210227.A19675@munchkin.spectacle-pond.org> <200107050154.VAA21513@smarty.smart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107050154.VAA21513@smarty.smart.net>; from humbubba@smarty.smart.net on Wed, Jul 04, 2001 at 09:54:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2001 at 09:54:05PM -0400, Rick Hohensee wrote:
> > 
> > On Tue, Jul 03, 2001 at 11:37:28PM -0400, Rick Hohensee wrote:
> > > That's with the GNU tools, without asm(), and without proper declaration
> > > of printf, as is my tendency. I don't actually return an int either, do I?
> > > LAAETTR.
> > 
> > Under ISO C rules, this is illegal, since you must have a proper prototype in
> > scope when calling variable argument functions.  In fact, I have worked on
> > several GCC ports, where the compiler uses a different calling sequence for
> > variable argument functions than it does for normal functions.  For example, on
> > the Mips, if the first argument is floating point and the number of arguments
> > is not variable, it is passed in a FP register, instead of an integer
> > register.  For variable argument functions, everything is passed in the integer
> > registers.
> > 
> 
> I didn't know that, but...
> 
> You seem to be saying the use of assumptions about args passing is
> non-standard. I know. It's more standard than GNU extensions to C though,
> C_labels_in_asms in particular, and even in your examples it appears that
> the particular function abusing these tenets will know what it can expect
> from a particular compiler, since it knows what it's arguments are. It
> can't know what it can expect from any compiler. This perhaps is where
> #ifdef comes in, or similar. Well, it's not more standard than GNU, but
> the differences would be less detailed in the case of just dealing with
> various args passing schemes, and there may be some compiler-to-compiler
> overlap, where there won't be any with stuff like C_labels_in_asms.

Doing this is a losing game.  How many different platforms does Linux currently
run on?  Do you know exactly what the ABI is for each of the machines?  What
happens when Linux is ported to a new machine?  My point is:

	extern int printf (const char *, ...);
	printf ("%d %d\n", 1, 2);

and

	extern int my_printf (const char *, int, int);
	my_printf ("%d %d\n", 1, 2);

under some ABIs will pass arguments completely differently and as I said, I
have worked on various GCC ports that did this, so it is not a theoretical
possibility.

> It's illegal to not declare main() as int. I don't know of a unix that
> actually passes anything but a byte to the calling process. I got flamed
> mightily for this in comp.unix.programmer until people ran some checks on
> thier big Real Unix(TM) boxes of various types. Linux won't pass void
> either, you have to get a 0 at least. Compliance is subjective. It's
> easier when things make sense.

Yes, that is an artifact of the original UNIX implementation on the PDP-11 (16
bit ints, signal number is passed back in one byte, and the return value in
another byte).

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
