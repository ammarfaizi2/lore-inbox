Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbTLLQGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbTLLQGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:06:14 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:50820 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265287AbTLLQGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:06:02 -0500
Date: Fri, 12 Dec 2003 17:05:46 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
Message-ID: <20031212160546.GA6363@vana.vc.cvut.cz>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se> <Pine.LNX.4.53.0312121000150.10423@chaos> <yw1xy8tixe96.fsf@kth.se> <Pine.LNX.4.53.0312121018450.10945@chaos> <yw1xr7zaxd7e.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xr7zaxd7e.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 04:33:57PM +0100, M?ns Rullg?rd wrote:
> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > On Fri, 12 Dec 2003, [iso-8859-1] M?ns Rullg?rd wrote:
> >
> >> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> >>
> >> > It is not a broken BIOS! The BIOS timer that ticks 18.206 times
> >> > per second has an ISR that, in addition to keeping time, turns
> >> > OFF the FDC motor after two seconds of inactivity.
> 
> IMHO a ridiculous design, as is most of the PC.
> 
> >> > This ISR is taken away by Linux. Therefore Linux must turn off
> >> > that motor! It is a Linux bug, not a BIOS bug. Linux took control
> >> > away from the BIOS during boot.
> >>
> >> OK, but why doesn't it affect all machines?
> >>
> > If you leave the FDC software in the kernel, the FDC software
> > sets up everything and turns off the motor. If you have the
> > FDC as a module, you have nothing in there to turn off the
> > motor until you install the module.
> 
> I'm running 2.6.0-test11 on a machine with modular floppy driver,
> without any spinning motors.  I think it boots from floppy before HD,
> but I'm not certain (can't check right now).

Maybe because you run patched LILO which works around this 2.6.x
brokeness. Debian's #221967 says that 'reset disk subsystem' should
stop floppy motor. I'd like to see this black on white...

Fortunately Andreas Roland accepted patch instead of reassigning
bug to 2.6.x kernel package where it belongs - if kernel does
not pass timer IRQ to the BIOS, it is kernel's responsibility
to do tasks which BIOS scheduled for future...


lilo (1:22.5.8-6) unstable; urgency=low

  * Now LILO can disable FDC on (weird?) BIOS using 2.6 kernel.
    (closes: #221967)

						Petr Vandrovec

