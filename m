Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971131-1169>; Wed, 4 Mar 1998 19:07:03 -0500
Received: from cygnus.com ([205.180.230.20]:4652 "EHLO cygint.cygnus.com" ident: "NO-IDENT-SERVICE") by vger.rutgers.edu with ESMTP id <971376-1169>; Wed, 4 Mar 1998 18:13:29 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: egcs 1.0.1 miscompiles Linux 2.0.33 
Reply-To: law@cygnus.com
In-reply-to: Your message of Wed, 04 Mar 1998 19:21:01 MST. <199803050021.TAA10868@saturn.cs.uml.edu> 
Date: Wed, 04 Mar 1998 17:34:31 -0700
Message-ID: <3451.889058071@hurl.cygnus.com>
From: Jeffrey A Law <law@hurl.cygnus.com>
Sender: owner-linux-kernel@vger.rutgers.edu


  In message <199803050021.TAA10868@saturn.cs.uml.edu>you write:
  > > Any asm which sets up a case where a clobber must match an input
  > > is wrong.  Plain and simple, it is wrong.
  > 
  > OK, this is a user interface issue. It seems most people want to
  > specify clobbered inputs. Why not support it? Just detect the case
  > and convert it to the way gcc wants to do things internally.
Doing this directly violates the GCC asm documentation.  Supporting
this also makes it much more difficult to fix a particular bug in
asm support that shows up on the x86.


  > if is_input and is_clobber then ...
  > 
  > > By claiming its a dummy output the compiler will not
  > > try to use that register to hold any other values across
  > > the asm statement.
  > 
  > Dummy outputs are a way to hack around the problem.
  > Think about it. Doesn't it look gross to you?
Marginally gross, but it describes the situation in such a way
as to make it possible for the compiler to do the right thing.

It also more closely models how machine descriptions are written
which will improve the reliability of your asm constructs.  In
fact this is *exactly* how similar situations are described in
the machine descriptions.

It also will allow for more compile-time checks of your asm statements
instead of letting the compiler silently generate incorrect code
(which is exactly what got this whole discussion started).

It also gives you the capability of allowing the compiler to select
a register which will allow the compiler to generate more efficient
code (assuming of course the asm statements are capable of using
varying registers).

It's also a tiny step in the right direction if we were to ever turn
off the SMALL_REGISTER_CLASSES hack/pessimization that is needed on
the x86 port.

Using a matching constraint and early clobber will work on more
than just the x86 port.  The hack currently used on x86 Linux
isn't likely to work on any port other than the x86.

In fact, in a private message Linus even said using earlyclobbers
with matching constraints was cleaner than showing the same reg
as an input and clobber.


  > > The need for the mechanism is obvious, the mechanism currently
  > > used by Linux is wrong.
  > 
  > Is it legal for any other purpose? If not, then nothing will break
  > when gcc does what most developers seem to expect.
No, the mechanism currently used by Linux is not valid in any
context.  You've been able to get away with it over the years, but
that doesn't make it correct or valid.


jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
