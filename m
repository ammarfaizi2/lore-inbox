Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSFVBd3>; Fri, 21 Jun 2002 21:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSFVBd3>; Fri, 21 Jun 2002 21:33:29 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:20367 "EHLO
	pimout3-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S316825AbSFVBd1>; Fri, 21 Jun 2002 21:33:27 -0400
Message-Id: <200206220132.g5M1WjI160594@pimout3-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
Date: Fri, 21 Jun 2002 15:34:23 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com> <20020621105055.D13973@work.bitmover.com> <3D136BEF.3030509@mandrakesoft.com>
In-Reply-To: <3D136BEF.3030509@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 June 2002 02:09 pm, Jeff Garzik wrote:

> One point that is missed, I think, is that Linux secretly wants to be a
> microkernel.
>
> Oh, I don't mean the strict definition of microkernel, we are continuing
> to push the dogma of "do it in userspace" or "do it in process context"
> (IOW userspace in the kernel).
...
>
>
> (I wonder if, shades of the old Linus/Tanenbaum flamewar, I will catch
> hell from Linus for mentioning the word "microkernel"  :))

Amateur computer historian piping up...

A microkernel design was actually made to work once, with good performance.  
It was about fifteen years ago, in the amiga.  Know how they pulled it off?  
Commodore used a mutant ultra-cheap 68030 that had -NO- memory management 
unit.

No memory protection meant that message passing devolved to "here's a 
pointer, please don't eat my data".  And it's message passing that kills 
microkernels, all that busy work from copying data (or, worse, playing with 
page tables) when doing message passing kills your performance and makes the 
sucker undebuggable.  You wind up jumping through hoops to get access to the 
data you need, and at any given point there are three different copies of it 
flying through the memory bus getting out of sync with each other and needing 
a forest of locks to even TRY to resolve.

In the Linux kernel, even when we have process context we can "reach out and 
touch someone" any time we want to.  No message passing nightmares, just keep 
track of what you're exporting or Al will flame you. :)  Lock, diddle the 
original, unlock, move on.  No copies, no version skew.

A microkernel design WITHOUT message passing is really just an extremely 
modular monolithic kernel.  Modularization, like object oriented programming, 
is cool up until the point you let it turn into a religion.  As long as you 
don't wind up fighting your design and winding up unable to access your own 
data when you really need to, because it's on the wrong side of a relatively 
arbitrary boundary, modularization is a good thing.

Rob
