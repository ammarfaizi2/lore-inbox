Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131314AbQKAFCB>; Wed, 1 Nov 2000 00:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQKAFBu>; Wed, 1 Nov 2000 00:01:50 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:37645 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131314AbQKAFBg>; Wed, 1 Nov 2000 00:01:36 -0500
Date: Tue, 31 Oct 2000 23:01:20 -0600
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: mingo@elte.hu, Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031230120.G1041@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0011010010380.16674-100000@elte.hu> <39FF4773.CA06CB60@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FF4773.CA06CB60@timpanogas.org>; from jmerkey@timpanogas.org on Tue, Oct 31, 2000 at 03:28:03PM -0700
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    [Jeff Merkey]
> > > The numbers don't lie. [...]
> > 
  [Ingo Molnar]
> > sure ;) I can do infinite context switches! You dont believe? See:
> > 
> >         #define schedule() do { } while (0)

[Jeff]
> Actually, I think the compiler would optimize this statement
> completely out of the code.

That was Ingo's point.  He is doing infinite context switches per
second, where a context switch is defined as "schedule()", because he
turned it into a noop.

I.e. the numbers can easily be made to lie, by playing with the rules
of the game.

The point of confusion, Jeff, is that to *you* a context switch means
stack switch, with no baggage like scheduling or reloading registers.
Everyone else here thinks of a context switch as meaning a pre-emptive
switch between two unrelated processes -- which as you know involves
not only the stack, but MM adjustments, registers, floating point
registers (expensive on pre-P6), IP, and some form of scheduling.

Obviously some of these can be optimized out if you can make
assumptions about the processes: you might drop memory protection if
you like the stability of Windows 95, floating point if you can get
away with telling people they can't use it, maybe use FIFO scheduling
if you don't care about fairness and you know the processes are more or
less uniform.  Linux cannot make any of these assumptions -- it is far
too general-purpose.

In Linux, in fact, jumping from ring 3 to ring 0 (ie system call) is
not considered a context switch.  I suppose you would consider it one.
So the real question is, how many gettimeofday() per sec can Linux do?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
