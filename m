Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970862-1169>; Wed, 4 Mar 1998 12:12:10 -0500
Received: from cygnus.com ([205.180.230.20]:4239 "EHLO cygint.cygnus.com" ident: "NO-IDENT-SERVICE") by vger.rutgers.edu with ESMTP id <970984-1169>; Wed, 4 Mar 1998 12:03:13 -0500
To: Christof Petig <christof.petig@wtal.de>
cc: linux-kernel@vger.rutgers.edu, egcs@cygnus.com
Subject: Re: egcs 1.0.1 miscompiles Linux 2.0.33 
Reply-To: law@cygnus.com
In-reply-to: Your message of Tue, 03 Mar 1998 10:19:10 MST. <34FBCB0C.42D8AD1C@wtal.de> 
Date: Wed, 04 Mar 1998 11:26:40 -0700
Message-ID: <2620.889036000@hurl.cygnus.com>
From: Jeffrey A Law <law@hurl.cygnus.com>
Sender: owner-linux-kernel@vger.rutgers.edu


  In message <34FBCB0C.42D8AD1C@wtal.de>you write:
  > Dear Jeff,
  > 
  > I was a shocked by these misunderstandings. Seems that you never tried
  > to use an asm() on an i386 computer.
No, I don't use x86 asms a lot.  But I've had the "pleasure" of
working with asms on various machines and developing gcc for about
9 years now.  So I have more than a clue about how things are
supposed to work :-)


  > What we would like to do is:
  > 
  > - setup register ecx with (-1), esi with (cs).
  > - execute run the asm-statements
  > - tell gcc that ecx and esi do no longer contain the values (-1) and
  > (cs)
  > 
  > What would be the correct way to tell this to gcc if not by inputs and
  > clobbers?
As folks have stated, the proper way to do this is to set up matching
input/output operands with the output as an earlyclobber.  The manual
needs updating in this regard since it is ambigious.

Any asm which sets up a case where a clobber must match an input
is wrong.  Plain and simple, it is wrong.


  > come on ... this doesn't touch the problem at the head of this message
  > (we need to pass a value that is clobbered.) Unless you recommend
  > pushing all passed values on the stack and restoring them before we
  > leave the asm(). This would make the asm() statement needless, since it
  > would never _optimize_ anything for a certain machine.
Yes it does.  By claiming its a dummy output the compiler will not
try to use that register to hold any other values across the asm
statement.

By having the an input match the output, you can pass a value to
the asm in a register.

And finally, the earlyclobber on the output prevents the compiler
from associating any unrelated input with the given output.

This mechanism is designed to do exactly what you want it to do
modulo any bugs.

  > Or is the question:
  > - is it valid to use a asm() for machine specific optimizations?
  > 
  > Sorry for answering this emotionally but I can't understand why this
  > need is not obvious to compiler designers.
The need for the mechanism is obvious, the mechanism currently used 
by Linux is wrong.

jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
