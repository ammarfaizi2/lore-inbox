Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289136AbSA1POi>; Mon, 28 Jan 2002 10:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289216AbSA1PO3>; Mon, 28 Jan 2002 10:14:29 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:2309 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S289213AbSA1PON>; Mon, 28 Jan 2002 10:14:13 -0500
From: "" <simon@baydel.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Date: Mon, 28 Jan 2002 04:21:31 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
CC: <linux-kernel@vger.kernel.org>
Message-ID: <3C54D1CB.23664.50D4C3@localhost>
In-Reply-To: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.33.0201252234530.18494-100000@gans.physik3.uni-rostock.de>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all I would like to thank all the people that responded to my 
mail. Unfortunately the numbers I am using are not restricted to 
powers of two so I could not simply shift the data. I have decided to 
use the div64.h solution and it seems to work well. 

I have looked at this header file and I do not understand the asm 
syntax. 

In particular the only x86 div instruction I know only returns a 32 bit 
div result. Because I don't understand the div64 header I cannot 
see how a 64 bit result is calculated.

I also tried this header in a regular application. This failed to return 
the modulus although it works in a module.

Is this asm syntax documented anywhere ? 

Thanks Again 

Simon.


On 25 Jan 2002, at 22:42, Tim Schmielau wrote:

> On Fri, 25 Jan 2002, Richard B. Johnson wrote:
> 
> > On Fri, 25 Jan 2002,  wrote:
> >
> > > I am writing a module and would like to perform arithmetic on long
> > > long variables. When I try to do this the module does not load due
> > > to the unresolved symbols __udivdi3 and __umoddi3. I notice these
> > > are normally defined in libc. Is there any way I can do this in a
> > > kernel module.
> > >
> > > Many Thanks
> > >
> > > Simon.
> >
> > Normally, in modules, the granularity is such that divisions can
> > be made by powers-of-two. In a 32-bit world, the modulus that you
> > obtain with umoddi3 (the remainder from a long-long, division) should
> > normally fit within a 32-bit variable. If you insist upon doing 64-bit
> > math in a 32-bit world, then you can either make your own procedures
> > and link them, of you can "appropriate" them from the 'C' runtime
> > library code, include them with your source, assemble, and link them
> > in.
> 
> If 64-bit arithmetics cannot be avoided, the do_div64() macro defined in
> include/asm/div64.h comes in handy.
>   mod = do_div((unsigned long) x, (long) y)
> will set  x  to the quotient x/y  and  mod  to the remainder  x%y .
> 
> Tim
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
