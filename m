Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290817AbSAYVml>; Fri, 25 Jan 2002 16:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSAYVmY>; Fri, 25 Jan 2002 16:42:24 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:45065 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S290817AbSAYVmN>; Fri, 25 Jan 2002 16:42:13 -0500
Date: Fri, 25 Jan 2002 22:42:11 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <simon@baydel.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
In-Reply-To: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0201252234530.18494-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, Richard B. Johnson wrote:

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

If 64-bit arithmetics cannot be avoided, the do_div64() macro defined in
include/asm/div64.h comes in handy.
  mod = do_div((unsigned long) x, (long) y)
will set  x  to the quotient x/y  and  mod  to the remainder  x%y .

Tim

