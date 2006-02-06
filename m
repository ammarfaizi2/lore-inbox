Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWBFUzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWBFUzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWBFUzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:55:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15372 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932380AbWBFUzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:55:12 -0500
Date: Mon, 6 Feb 2006 20:55:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Glen Turner <glen.turner@aarnet.edu.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060206205459.GB9388@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Glen Turner <glen.turner@aarnet.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kumar Gala <galak@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <20060206202654.GC2470@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206202654.GC2470@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 08:26:55PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > The serial console driver has a host of issues
> > > 
> > > [...]
> > > 
> > >  - [SECURITY] 'r' should require DCD to be asserted
> > >    before outputing characters. Otherwise we talk to
> > >    Hayes modem command mode.  This allows a non-root
> > >    user to re-program the modem and is a major security
> > >    issue is people configure calling line identification
> > >    or encryption to restrict use of the serial console.
> > 
> > How is this possible?  A normal user can't produce arbitarily formatted
> > kernel messages, and if they have access to /dev/ttyS they can do what
> > ever they like with the port anyway.
> 
> Maybe not *arbitrary* messages, but any user probably can fake enough
> to
> confuse modem. Name your process \nATD609123456\n and cause it to eat
> all memory, or something like that. OOM killer will print name...

As I say, it's a problem which needs fixing elsewhere.  What if
the process was called:

\nSystem Halted\n

(which will fit in the kernel's process name.)  Or maybe some escape
sequence which reprograms your terminal.

As I say, this is a problem which needs solving by other means.  Maybe
flush_old_exec() should be a little more careful about what it copies,
changing non-alphanumeric characters to '?' ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
