Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288731AbSAUWPo>; Mon, 21 Jan 2002 17:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288716AbSAUWPZ>; Mon, 21 Jan 2002 17:15:25 -0500
Received: from zero.tech9.net ([209.61.188.187]:41233 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288675AbSAUWPU>;
	Mon, 21 Jan 2002 17:15:20 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: yodaiken@fsmlabs.com
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020121145438.B18422@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com>
	<E16ShcU-0001ip-00@starship.berlin> <20020121095051.B14139@hq.fsmlabs.com>
	<1011648179.850.473.camel@phantasy>  <20020121145438.B18422@hq.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 17:19:32 -0500
Message-Id: <1011651573.988.493.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 16:54, yodaiken@fsmlabs.com wrote:

> > It doesn't have to run mostly in the kernel.  It just has to be in the
> > kernel when the I/O-bound tasks awakes.  Further, there are plenty of
> 
> How does that work? Won't the switch happen on exit from the kernel?

Sure, but we have essentially unbounded times in the kernel ...
I/O-bound tasks shouldn't have to wait for do_try_to_free_pages to
finish for some lower priority process.

> > what we consider CPU-bound tasks that are interactive and/or
> > graphics-oriented and this adds much to their time in the kernel.
> 
> I'm not sure what an "interactive and/or graphics-oriented" CPU bound
> task might be. Is there a definition?

I'm talking about today's GUI application.  It does computation and its
riddled with bloated GUI code.  So it is certainly CPU bound.  At the
same time it is interactive (blocking or polling on user input) and
involves some graphics output.  So it is involved in I/O, too.  What
would you consider it?

> So you think of an "I/O bound task" as  "an I/O bound task that spends
> most of its timeblocked". Won't the latencies of such tasks already be
> pretty high? I'd think that better caching and read-ahead is the correct
> fix.

I should correct myself, I didn't mean "most of its time" but a
statistically large portion.  All it needs to do is find itself woken
when something else is in the kernel.

> > While we certainly need tangible empirical benefits, users finding their
> > desktop experience smoother and thus more enjoyable is just about the
> > best thing we can ask for.
> 
> It depends on what you want. 

I want a better kernel.

	Robert Love

