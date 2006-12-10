Return-Path: <linux-kernel-owner+w=401wt.eu-S1761183AbWLJPhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761183AbWLJPhJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 10:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761248AbWLJPhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 10:37:08 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4219 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761180AbWLJPhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 10:37:06 -0500
Date: Sun, 10 Dec 2006 12:14:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Westermann <michael@dvmwest.de>, linux-kernel@vger.kernel.org
Subject: Re: DTR/DSR handshake in kernelspace third traying
Message-ID: <20061210121431.GA20456@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Michael Westermann <michael@dvmwest.de>,
	linux-kernel@vger.kernel.org
References: <20061207201626.GA10920@dvmwest.dvmwest.de> <20061209225014.0888720b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209225014.0888720b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 10:50:14PM -0800, Andrew Morton wrote:
> > On Thu, 7 Dec 2006 21:16:27 +0100 Michael Westermann <michael@dvmwest.de> wrote:
> > Hello,
> > 
> > I've send 2 patches for a DTS/DSR handshaking to the list
> > 
> > http://lkml.org/lkml/2004/5/7/76  and long long time ago 1998
> > 
> > My problem are manufacturers the make printers with
> > DTR/DSR Handschaking. POS Printers are very sensible for
> > a buffer overrun!
> > 
> > For on or two printers, we can wire a adapter, for 10000...30000
> > printers is a software option the better way.
> > 
> > I've write a patch for 2.2 and published it, 
> > I've write a patch for 2.4 and published it, but i've see there is no
> > 
> > DTR/DSR Handshaking in the kernel 2.6.
> > 
> > I'm a litte bit  frusted. Are a few  thousands pos-systems not
> > enough for upgrading the standard kernel sources?
> > 
> > Have I a really chance to commit a patch for kernel 2.6.
> > 
> 
> I'd say so.  Please make sure that such a patch is against the very latest
> Linus kernel from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots. 
> Also, the more comprehensive the patch's description the better - why it is
> needed, what it does, how it works, etc.  Your 2004 description was rather
> terse.
> 
> I seem to recall that the people who understand and work on this code
> discussed this issue earlier this year, but I forget the conclusion.  Some
> archive searching might be useful.

Andrew,

My stance on handshaking has always been that it should be something
controlled via termios, not via some driver specific ioctl() which is
different for every single driver.

I see that this 2.4 patch actually does that, which is great.  A
couple of points though:

1. CRTSCTS should select RTS/CTS flow control.  There should be CDTRDSR
   for DTR/DSR flow, not CHWFLOW plus some additional ioctl.

2. the patch does not adequately handle switching flow control modes.
   The handling in set_termios is not sufficient - eg, when switching
   from CRTSCTS with de-asserted CTS to CDTRDSR with asserted DSR will
   result in the driver believing that the flow control signal is still
   deasserted.  Incidentally, this also directly affects changing the
   flow control method via the additional ioctls.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
