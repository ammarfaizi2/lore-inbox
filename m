Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSGNPJX>; Sun, 14 Jul 2002 11:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSGNPJW>; Sun, 14 Jul 2002 11:09:22 -0400
Received: from mail.storm.ca ([209.87.239.66]:62598 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S316884AbSGNPJV>;
	Sun, 14 Jul 2002 11:09:21 -0400
Message-ID: <3D3187E6.426BB595@storm.ca>
Date: Sun, 14 Jul 2002 10:17:10 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
References: <E17T15g-0007mP-00@speech.braille.uwo.ca> <3D2EF8DB.4DB091FF@storm.ca> <20020714002054.GB29007@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> 
> On Fri Jul 12, 2002 at 11:42:19AM -0400, Sandy Harris wrote:
> > Does dietlibc help?
> >
> 
> This is kernel space.  Using any math functions is forbidden
> in kernel space,

Exactly what do you mean by "forbidden"?

Granted the kernel does not normally contain math libraries,
and that linking in a 500 meg library would be spectacularly
silly, what's wrong with using a few carefully chosen math
functions in a driver?

The kernel does not, I think, normally use floating point.
Would things break if a library that does was linked in?
Is that what you mean?

> so using dietlibc, uClibc, or anything else
> is not going to work.

Just linking in a whole library won't work, but stealing code
from a size-optimized library might. 

> Moving the math stuff to userspace will
> help, at which point he can use any C library that suits him,

The guy asking the question thinks he needs math in his driver
because he needs a system that talks to blind users during the
boot process, before any userspace programs can run.

I've already suggested writing a scaled integer math library.
This should be faster than float, accurate enough for speech.
If what Erik is objecting to is floating point in the kernel,
not just any sort of math, then it avoids his objection.

Another possible solution:

Use two machines, both set to put boot messages on a serial
console and connected so that when either reboots, the other
is used as console. Do your sound in userspace (which I agree
is where it belongs). Now as long as you don't reboot both
at once (use a UPS!), you have sound for boot messages.
