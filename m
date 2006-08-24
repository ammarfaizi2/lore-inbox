Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422736AbWHXWFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422736AbWHXWFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWHXWFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:05:53 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:27667 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422736AbWHXWFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:05:52 -0400
Date: Thu, 24 Aug 2006 23:05:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, David Woodhouse <dwmw2@infradead.org>,
       Stuart MacDonald <stuartm@connecttech.com>,
       linux-serial@vger.kernel.org, "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: Serial custom speed deprecated?
Message-ID: <20060824220535.GC21439@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	David Woodhouse <dwmw2@infradead.org>,
	Stuart MacDonald <stuartm@connecttech.com>,
	linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>
References: <028a01c6c6fc$e792be90$294b82ce@stuartm> <1156411101.3012.15.camel@pmac.infradead.org> <m3bqqap09a.fsf@defiant.localdomain> <1156441293.3007.184.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156441293.3007.184.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 06:41:33PM +0100, Alan Cox wrote:
> We would need a driver ->set_speed method for the cases where
> - ioctl is called to set specific board rate
> - OR termios values for tty speed change
> - While we are at it we might want to make ->set_termios also allowed to
> fail

That's a little dodgy, from my reading of POSIX.  ISTR POSIX prefers
a behaviour of "set what you can" from this, and when you read back
the termios settings, you get the actual settings in use.

So, eg, if you don't support CS5 but the previous setting was CS8,
tcsetattr should not return an error.  The device itself should set
the other changed parameters but remain at CS8 and tcgetattr should
report CS8.

stty already knows about this, and issues warnings when you attempt
to set stuff which aren't supportted by the driver (assuming you have
a correctly behaving driver in this respect.)  I've been a little
scared to push the implementation for these in the serial drivers.

> Anyone got any problems with this before I go and implement it ?

Only as long as we can end up with a numeric baud rate at the end of
the day (which is what serial has always been after.)

This represents a major improvement to the tty interface, thanks for
looking in to making it happen.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
