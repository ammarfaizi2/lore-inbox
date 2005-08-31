Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVHaMxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVHaMxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVHaMxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:53:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28946 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964785AbVHaMxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:53:12 -0400
Date: Wed, 31 Aug 2005 13:52:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com
Subject: Re: [FINAL WARNING] Removal of deprecated serial functions - please update your drivers NOW
Message-ID: <20050831135258.D1118@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
	ralf@linux-mips.org, starvik@axis.com
References: <20050831103352.A26480@flint.arm.linux.org.uk> <1125493224.3355.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1125493224.3355.1.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 31, 2005 at 02:00:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 02:00:24PM +0100, Alan Cox wrote:
> On Mer, 2005-08-31 at 10:33 +0100, Russell King wrote:
> > Unfortunately, it appears that some of these drivers do not contain
> > email addresses for their maintainers, neither are they listed in
> > the MAINTAINERS file.  (mwavedd and serial_txx9).
> 
> I'll have a quick look at mwave. If I remember rightly it just needs to
> tell someone that an "ISA" 16450 serial port materialised by magic at
> the addresses it selected.

Thanks Alan.

I think that it shouldn't be too big a problem - maybe just using
serial8250_register_port() and serial8250_unregister_port() instead
of register_serial()/unregister_serial(), and changing the structure.

The key thing is that port.dev should be set appropriately and the
relevant calls to serial8250_suspend_port/serial8250_resume_port
be made (or port.dev should be NULL if no power management is
expected - in which case it may be managed as a generic platform
port.)

Also, port.uartclk must be set, and since this is an add-in card,
it should not be using BASE_BAUD but the clock rate for the UART
on the card itself.  (BASE_BAUD being an architecture defined
constant has no business being used in connection with add-in
cards with on-board UART clock generators.)

I hope the above is useful, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
