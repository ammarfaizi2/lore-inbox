Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTAXQce>; Fri, 24 Jan 2003 11:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267772AbTAXQce>; Fri, 24 Jan 2003 11:32:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:913 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267659AbTAXQcd>; Fri, 24 Jan 2003 11:32:33 -0500
Date: Fri, 24 Jan 2003 11:42:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Madhavi <madhavis@sasken.com>
cc: GrandMasterLee <masterlee@digitalroadkill.net>,
       Linux Geek <bourne@ToughGuy.net>, linux-kernel@vger.kernel.org
Subject: Re: Stack overflow
In-Reply-To: <Pine.LNX.4.33.0301242107480.2842-100000@pcz-madhavis.sasken.com>
Message-ID: <Pine.LNX.3.95.1030124113012.4660A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, Madhavi wrote:

> 
> On 24 Jan 2003, GrandMasterLee wrote:
> 
> > On Fri, 2003-01-24 at 01:53, Linux Geek wrote:
> > > >
> > > >
> > > >I have a functionality which works well if the code whcih performs this
> > > >function is embedded in the required function. If this functionality is
> > > >implemented as a separate function, and this function is called at the
> > > >required place, the system crashes. I have used KDB for debugging. But,
> > > >
> > > >
> > >     I'd suggest check the args passed to the function and the sizes they
> > > would consume when they are passed as 'call by value'.
> > > Try to pass them as pointers maybe.
> > >
> > > Yes, i think there is a limit on kernel stack but not i'm not too sure
> > > about the number.
> >
> > The kernel has an 8K stack max. That said, it *could* be your stack. Do
> > you get any panics or oops? If so, you *could* write them down :-D And
> > debug them later. If it appears corrupted, then it's probably stack.
> >
> 
> I am getting a panic saying "attempted to kill idle task". The call trace
> scrolls through for 4-5 pages. I have also observed complete system hang a
> few times.
> 
> How can I solve this problem, supposing I can't avoid that function call?
> Any pointers regarding this would be of great help for me.
> 
> thanks & regards
> Madhavi.
> 

Make a user-mode 'main()' test program that calls your function with
the required parameters. Link it with your function and run it either
with gdb or with lots of ordinary printf statements.

You can resolve all missing globals, including functions, with
simple 'ints' as long as they are not accessed in your code. This
lets you test practically anything in user-mode when, if you
screw up, you just have a core file and don't have to re-boot.

Most all of the modules that I write for embedded systems are
initially tested this way. That lets me get linked-lists and
other easy-to-muck-up things working correctly before I throw
it off the cliff, hoping it will fly. My user-mode code calls
ISRs, actually accessing hardware in most cases (iopl(3) allows
this).

Also, PCI interrupts are level interrupts. Do not enable interrupts
in your ISR until you have serviced the reason why you got the
interrupt in the first place, otherwise the ISR will be interrupted
by the same interrupt...,
 by the same interrupt...,
  by the same interrupt...,
   until you crash.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


