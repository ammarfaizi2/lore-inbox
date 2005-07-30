Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVG3VQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVG3VQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVG3VQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:16:46 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:52921 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262871AbVG3VP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:15:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: revert yenta free_irq on suspend
Date: Sat, 30 Jul 2005 23:20:30 +0200
User-Agent: KMail/1.8.1
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org,
       Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <Pine.LNX.4.58.0507301335050.29650@g5.osdl.org> <20050730215403.J26592@flint.arm.linux.org.uk>
In-Reply-To: <20050730215403.J26592@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302320.31111.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 30 of July 2005 22:54, Russell King wrote:
> On Sat, Jul 30, 2005 at 01:36:24PM -0700, Linus Torvalds wrote:
> > On Sat, 30 Jul 2005, Russell King wrote:
> > > 
> > > What this probably means is that we need some way to turn off interrupts
> > > from devices on suspend, and on resume, keep them off until drivers
> > > have had a chance to quiesce all devices, turn them back on, and then
> > > do full resume.
> > 
> > No, we just need to suspend and resume the interrupt controller properly.  
> > Which we had the technology for, and we actually used to do, but for some
> > (incorrect) reason ACPI people thought it should be up to individual
> > drivers.
> 
> I don't think so - I believe one of the problem cases is where you
> have a screaming interrupt caused by an improperly setup device.

This is happening in the real life, it seems (eg please see
http://bugzilla.kernel.org/show_bug.cgi?id=4416#c36).

> Consider the case where you have a shared interrupt line and you're
> partially through resuming devices, when one unresumed device (setup
> by the BIOS) suddenly starts asserting its interrupt.
> 
> The kernel then disables the source.  Unfortunately, that was the IRQ
> for your USB host, which has your USB keyboard and mouse attached.

Also, this has been discussed in this thread on the linux-pm list:
http://lists.osdl.org/pipermail/linux-pm/2005-May/000955.html

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
