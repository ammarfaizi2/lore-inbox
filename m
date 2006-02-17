Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWBQUOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWBQUOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWBQUOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:14:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56075 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751672AbWBQUOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:14:34 -0500
Date: Fri, 17 Feb 2006 20:14:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060217201429.GC13502@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060124082538.GB4855@pazke> <20060124210140.GB23513@flint.arm.linux.org.uk> <20060202102644.GC5034@flint.arm.linux.org.uk> <20060202132726.GD24903@pazke> <20060202201734.GA17329@flint.arm.linux.org.uk> <20060203091308.GA19805@pazke> <20060203092435.GA30738@flint.arm.linux.org.uk> <20060217113942.GA30787@pazke> <20060217200213.GA13502@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217200213.GA13502@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 08:02:13PM +0000, Russell King wrote:
> On Fri, Feb 17, 2006 at 02:39:42PM +0300, Andrey Panin wrote:
> > On 034, 02 03, 2006 at 09:24:36 +0000, Russell King wrote:
> > > On Fri, Feb 03, 2006 at 12:13:08PM +0300, Andrey Panin wrote:
> > > > On 033, 02 02, 2006 at 08:17:35 +0000, Russell King wrote:
> > > > > As I've said many a time, we need a generic way to set different hand-
> > > > > shaking modes.  I've suggested using some spare bits in termios in the
> > > > > past, but nothing ever came of that - folk lose interest at that point.
> > 
> > No wonder they do. Extra bits are not a problem, but for 8250.c we need some
> > way to glue subdrivers with serial8250_set_termios(). Callback in uart_port
> > structure ?

Finally, let me explain why I favour the termios solution.  The biggest
(and most important) aspect is that it allows existing applications
such as minicom and gettys to work as expected - getting the correct
handshaking mode that they desire without having to change userspace.

I think that is an _extremely_ important property to have.  Without it,
you would end up with (eg) a security issue where a user changes the
handshaking mode of the dial-up connection they're on, rendering it
useless until the sysadmin "undoes" the damage.

Alternatively, every serial line getty at least needs to be taught
how to reset the handshaking mode, which at present means that it
needs to be taught about the hardware cards so it knows what silly
random ioctl call for some proprietary method to make.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
