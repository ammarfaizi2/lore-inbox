Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318561AbSHEO4e>; Mon, 5 Aug 2002 10:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318569AbSHEO4e>; Mon, 5 Aug 2002 10:56:34 -0400
Received: from bitmover.com ([192.132.92.2]:49559 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318561AbSHEO4d>;
	Mon, 5 Aug 2002 10:56:33 -0400
Date: Mon, 5 Aug 2002 07:59:51 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, Richard Zidlicky <rz@linux-m68k.org>,
       Jeff Dike <jdike@karaya.com>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode linux]
Message-ID: <20020805075951.L28512@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
	Richard Zidlicky <rz@linux-m68k.org>, Jeff Dike <jdike@karaya.com>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <m3u1mb5df3.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0208051223430.8173-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208051223430.8173-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Aug 05, 2002 at 12:40:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > actually the opposite is true, on a 2.2 GHz P4:
> > > 
> > >   $ ./lat_sig catch
> > >   Signal handler overhead: 3.091 microseconds
> > > 
> > >   $ ./lat_ctx -s 0 2
> > >   2 0.90
> > > 
> > > ie. *process to process* context switches are 3.4 times faster than signal
> > > delivery. Ie. we can switch to a helper thread and back, and still be
> > > faster than a *single* signal.

Has someone gone through the lat_ctx.c and lat_sig.c code and convinced 
themselves these are measuring things which ought to be compared like this?
When I wrote that code I didn't anticipate this comparison, so somebody
should go look.

I'd suggest that if you want to measure how fast you can communicate using
signals versus pipes (or sockets or whatever), someone write up a test
which has two processes bounce a token between each other using signals
and then compare that with lat_pipe.  It's not clear to me that you are
comparing apples to apples.

If someone does write the test, we'll add it to LMbench if it reveals
anything useful.  It should be easy enough to do.  I can do it if it
isn't obvious.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
