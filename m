Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRJPS0v>; Tue, 16 Oct 2001 14:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276612AbRJPS0m>; Tue, 16 Oct 2001 14:26:42 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:39946 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S276591AbRJPS0d>; Tue, 16 Oct 2001 14:26:33 -0400
Message-Id: <200110161827.f9GIR5m09115@enterprise.bidmc.harvard.edu>
Content-Type: text/plain; charset=US-ASCII
X-KMail-Redirect-From: Kristofer T. Karas <ktk@enterprise.bidmc.harvard.edu>
Subject: Re: [ntp:hackers] Linux feature
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu> (by way of
	Kristofer T. Karas <ktk@enterprise.bidmc.harvard.edu>)
Date: Tue, 16 Oct 2001 14:27:05 -0400
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 15 Oct 2001, at 21:16, David L. Mills wrote:
> > My Linux test box backroom.udel.edu has gone nuts. [...]
> > However, the step correction requested is only partially implemented
> > by the Linux kernel, so the frequency correction is in error. [...]

The slew rate in the kernel (sans PPSkit patch) is small relative to other
implementations; and the error in the clock circuitry of the typical PC is
worse than other implementations; and the kernel default is to talk to IDE
disk drives with interrupts disabled, unless you tell it your IDE drive is
not so crippled.  All of these compound the timekeeping problem, perhaps to
the point where the slew rate simply cannot compensate.  If this is the case,
then you could expect to see a time offset curve that approximates a sawtooth
wave, with step adjustments occurring on the sharp edge.  I don't have enough
data  to know if that's what's happening here.

I would use the 'adjtimex' program when booting your test platform to ensure
the tick value is optimal.  Also, issue the command "hdparm -u 1 /dev/hda" if
your test platform uses an IDE disk; warning: if you have an old vintage box,
this could cause harm, so read the man page for 'hdparm'.

On Tuesday 16 October 2001 02:48 am, Ulrich Windl wrote:
> I think in standard Linux a running
> adjtime() continues even after setting the time, and MOD_OFFSET and
> adjtime() both use the same variable, so don't expect the other to
> finish once you have used one of both. Is that the problem?

Uh, unless I'm totally whacked, I should think so.  Once a step adjustment
has been made, the very data from which a slew adjustment is calculated is no
longer relevant; continuing to slew will undo the good of the step, worsening
timekeeping but in the other direction (leading to oscillation if the slew is
not cancelled or adjusted).

> > One more example where Linux refuses to conform to
> > conventional semantics. Game over.

Dave, "Game Over" is not a terribly helpful strategy if the goal is to help
Linux do the right thing.  Better would be if you would look at the code in
question and provide some constructive critique.  Ulrich and the people on
linux-kernel will cheerfully implement needed functionality if the father of
the mechanism blesses it so.

Kris
