Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTLGRGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTLGRGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:06:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42245 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262344AbTLGRGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:06:42 -0500
Date: Sun, 7 Dec 2003 17:06:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: pZa1x <pZa1x@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
Message-ID: <20031207170638.B20112@flint.arm.linux.org.uk>
Mail-Followup-To: pZa1x <pZa1x@rogers.com>, linux-kernel@vger.kernel.org
References: <3FC7F031.5060502@rogers.com> <3FC7F2E3.8080109@rogers.com> <20031129082200.A30476@flint.arm.linux.org.uk> <3FC88277.4090304@rogers.com> <20031201210739.C13621@flint.arm.linux.org.uk> <3FD24E34.3050300@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FD24E34.3050300@rogers.com>; from pZa1x@rogers.com on Sat, Dec 06, 2003 at 09:46:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 09:46:28PM +0000, pZa1x wrote:
> Please let me know if there's anything I can do to help.
> 
> Russell King wrote:
> > On Sat, Nov 29, 2003 at 11:26:47AM +0000, pZa1x wrote:
> > 
> >>(a) with yenta kernel 2.6
> >>(b) without yenta kernel 2.6
> > 
> > 
> > Ok, so there aren't any differences between the PCI config space with
> > the module loaded and unloaded.  I guess we need to start looking at
> > the devices memory space registers for differences.
> > 
> > (This will require a little more work, so there'll be a slight delay.)
> > 

Ok, if all goes well, you should be able to use the following program:

  http://pcmcia.arm.linux.org.uk/progs/cbdump.c

to dump out many of the cardbus controllers registers.  The idea is the
same with lspci - you need to dump out the registers (in order):

- without the module having been loaded since last boot
- after the module has been loaded and cardmgr started
- after a suspend attempt with the module loaded
- cardctl suspend
- cardctl resume
- cardctl eject, cardmgr stopped and the module removed
- suspend while module unloaded, then resume

This means you should end up with seven register dumps.  Please send me
all these, with each clearly marked as to which is which.

If you have other scenarios (eg, suspend works with module loaded but
no card in the socket) then dumping this as well would be useful.
However, please document exactly what you did in this case.

This is probably going to seem like using a sledge hammer to crack a
peanut...  but we know that the BIOS isn't happy about /something/
we're doing, we just need to work out what.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
