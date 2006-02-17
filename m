Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWBQUCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWBQUCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWBQUCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:02:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52235 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751589AbWBQUCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:02:19 -0500
Date: Fri, 17 Feb 2006 20:02:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060217200213.GA13502@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060124082538.GB4855@pazke> <20060124210140.GB23513@flint.arm.linux.org.uk> <20060202102644.GC5034@flint.arm.linux.org.uk> <20060202132726.GD24903@pazke> <20060202201734.GA17329@flint.arm.linux.org.uk> <20060203091308.GA19805@pazke> <20060203092435.GA30738@flint.arm.linux.org.uk> <20060217113942.GA30787@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217113942.GA30787@pazke>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 02:39:42PM +0300, Andrey Panin wrote:
> On 034, 02 03, 2006 at 09:24:36 +0000, Russell King wrote:
> > On Fri, Feb 03, 2006 at 12:13:08PM +0300, Andrey Panin wrote:
> > > On 033, 02 02, 2006 at 08:17:35 +0000, Russell King wrote:
> > > > As I've said many a time, we need a generic way to set different hand-
> > > > shaking modes.  I've suggested using some spare bits in termios in the
> > > > past, but nothing ever came of that - folk lose interest at that point.
> 
> No wonder they do. Extra bits are not a problem, but for 8250.c we need some
> way to glue subdrivers with serial8250_set_termios(). Callback in uart_port
> structure ?

They lose interest because they want to solve only their own small
little problem without looking at the bigger picture.  That's not
what I'm interested in, so as far as I'm concerned (and I hope this
is clear) I have _zero_ interest in solving their small little
problems.

By only solving the small little problem, we end up with lots of
drivers doing their own stupid implementation of the same feature,
which results in multiple differing ways to enable said same
feature from userspace.

Plus, there is more to handshaking than just the standard protocol
we implement today - yes there's RS485-using-RTS flavour, but there's
also an alternative interpretation of RTS to mean "I am requesting
to send something" rather than the conventional "it is okay for you
to send me something".

And yes, someone has already requested this alternative RTS
interpretation.

So, there are three distinct flow control scenarios:

- conventional RTS/CTS
- alternative RTS/CTS
- RS485

As I've said above, if folk wish to bury their heads and just address
RS485 in isolation, I'm just plain not interested.  Let's do the job
properly or not at all.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
