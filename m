Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131096AbRBNTWd>; Wed, 14 Feb 2001 14:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRBNTWX>; Wed, 14 Feb 2001 14:22:23 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:30706 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130950AbRBNTWJ>; Wed, 14 Feb 2001 14:22:09 -0500
Message-ID: <3A8ADA30.2936D3B1@sympatico.ca>
Date: Wed, 14 Feb 2001 14:19:12 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> <m1lmr98c5t.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> Jeremy Jackson <jeremy.jackson@sympatico.ca> writes:
> (about non-executable stack)
>
> There is another much more effective solution in the works.  The C
> standard allows bounds checking of arrays.  So it is quite possible
> for the compiler itself to check this in a combination of run-time and
> compile-time checks.   I haven't followed up but not too long ago
> there was an effort to add this as an option to gcc.  If you really
> want this fixed that is the direction to go.  Then buffer overflow
> exploits become virtually impossible.
>

I've thought some more, and yes someone else has already done this.  Problems
are with compilers that
put code on stack (g++ trampolines for local functions i think).  There is
the gcc-mod (Stack-guard?) that checks for
corrupt stack frame using magic number containing zeros before returning...
this will take away some
performance though...

I wonder if the root of the issue is the underlying security architechure ...
anything that needs ANY privilege
gets ALL privileges (ie root).  chown named and such fixes this, but can't
rebind to privileged port, must be restarted
by root to do so.  VMS / NT have more fine grained privileges.

Is there any documentation of the kernel's 'capabilities' functions?  It
would be exceedingly cool if services (named, nfs, etc)
could be updated to use this;  I think crackers would loose some motivation
if instead of "hey I can totally rule this box!"
they have to settle for "hey I can make the ident service report user 'CrAp'
for every port!".


