Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSA1LEo>; Mon, 28 Jan 2002 06:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbSA1LEf>; Mon, 28 Jan 2002 06:04:35 -0500
Received: from dsl-213-023-043-003.arcor-ip.net ([213.23.43.3]:59008 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286687AbSA1LEa>;
	Mon, 28 Jan 2002 06:04:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: root@chaos.analogic.com, <simon@baydel.com>
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
Date: Mon, 28 Jan 2002 12:08:49 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16V9eb-00009M-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 25, 2002 05:56 pm, Richard B. Johnson wrote:
> On Fri, 25 Jan 2002,  wrote:
> 
> > I am writing a module and would like to perform arithmetic on long 
> > long variables. When I try to do this the module does not load due
> > to the unresolved symbols __udivdi3 and __umoddi3. I notice these
> > are normally defined in libc. Is there any way I can do this in a 
> > kernel module.
> > 
> > Many Thanks
> > 
> > Simon.
> 
> Normally, in modules, the granularity is such that divisions can
> be made by powers-of-two. In a 32-bit world, the modulus that you
> obtain with umoddi3 (the remainder from a long-long, division) should
> normally fit within a 32-bit variable. If you insist upon doing 64-bit
> math in a 32-bit world, then you can either make your own procedures
> and link them, of you can "appropriate" them from the 'C' runtime
> library code, include them with your source, assemble, and link them
> in.

Let's be clear on one thing.  There is nothing unnatural about
32bits * 32bits = 64bits or 64bits / 32bits = 32bits in a 32 bit world.
In fact, it is a rare architecture that does not support this directly
in hardware.  It may be awkward to express it in C, but since when has
that ever stopped us from using the best machine instructions for the
job?

Personally, I find the omission of these mixed size muldiv operations
from the kernel a great inconvenience.  Think 'multiply by a ratio'.
Yes, I know that by various posturings you can force most problems
that would be most naturally be expressed this way into some other
form, but several things suffer:

  - Readability
  - Efficiency
  - Code complexity
  - Code size

I think the argument I've seen most often presented against mixed
size muldiv operations goes something like 'I've never used them, so
why would anybody need them?'.  This just means that somebody hasn't
written very many kinds of programs, particularly the kind of code
we need to write if we are ever going to get the VM and IO
balancing code working properly.

-- 
Daniel
