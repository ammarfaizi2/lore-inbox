Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBOPFg>; Thu, 15 Feb 2001 10:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbRBOPF0>; Thu, 15 Feb 2001 10:05:26 -0500
Received: from slc573.modem.xmission.com ([166.70.7.65]:28935 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129106AbRBOPFR>; Thu, 15 Feb 2001 10:05:17 -0500
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> <m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2001 22:30:05 -0700
In-Reply-To: Jeremy Jackson's message of "Wed, 14 Feb 2001 14:19:12 -0500"
Message-ID: <m1hf1w8qea.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson <jeremy.jackson@sympatico.ca> writes:

> "Eric W. Biederman" wrote:
> 
> > Jeremy Jackson <jeremy.jackson@sympatico.ca> writes:
> > (about non-executable stack)
> >
> > There is another much more effective solution in the works.  The C
> > standard allows bounds checking of arrays.  So it is quite possible
> > for the compiler itself to check this in a combination of run-time and
> > compile-time checks.   I haven't followed up but not too long ago
> > there was an effort to add this as an option to gcc.  If you really
> > want this fixed that is the direction to go.  Then buffer overflow
> > exploits become virtually impossible.
> >
> 
> I've thought some more, and yes someone else has already done this.  Problems
> are with compilers that
> put code on stack (g++ trampolines for local functions i think).  There is
> the gcc-mod (Stack-guard?) that checks for
> corrupt stack frame using magic number containing zeros before returning...
> this will take away some
> performance though...

No.  I'm not talking about stack-guard patches.  I'm talking about bounds checking.
The difference here is that if correct code is generated you won't
overflow any buffer at all period.  The compiler will either prove at
compile time that it can't happen (The efficient case).  Or it will
generate pointers as <start,length,offset> tuples into chunks of
memory.  And it will do runtime checks that will that will kill your
program if it overflows the stack.  I think the gcc options is -fcheck
or something like that.  I haven't had a chance to follow up, since I
saw that someone was actually working on it.

Since compilers bugs happen buffer overflow exploits are still
possible but it means two separate programmers must mess up in
complimentary ways.

As for fine grain privileges they can help, but the real fix is to
keep the programs that need raised privileges down to one function.
Letting you look at the program and see if it is obviously correct
with no security bugs. 

But the gcc bounds checking work is the ultimate buffer overflow fix.
You can recompile all of your trusted applications, and libraries with
it and be safe from one source of bugs.

Eric
