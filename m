Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVHAHTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVHAHTp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVHAHTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:19:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22246 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262409AbVHAHTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:19:44 -0400
Date: Mon, 1 Aug 2005 09:19:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       ambx1@neo.rr.com, torvalds@osdl.org, hugh@veritas.com,
       linux@dominikbrodowski.net, daniel.ritz@gmx.ch, len.brown@intel.com
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050801071932.GK27580@elf.ucw.cz>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com> <1122861542.2953.8.camel@linux-hp.sh.intel.com> <20050731190645.748f57e9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731190645.748f57e9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > In general, I think that calling free_irq is the right behavior.
> > > Although irqs changing after suspend is rare, there are also some
> > > more serious issues.  This has been discussed in the past, and a
> > > summary is as follows:
> >
> > irqs actually isn't changed after suspend currently, it's a considering
> > for future usage like hotplug.
> > Calling free_irq actually isn't a complete ACPI issue, but ACPI requires
> > it to solve nasty 'sleep in atomic' warning.
> 
> Is that the only problem?  If so, then surely we can make free_irq() run
> happily with interrupts disabled: unlink the IRQ handler synchronously,
> defer the /proc teardown or something like that.

No, the problem is that

a) restoring interrupt links needs interrupts enabled [or rewriting
half of ACPI interpretter]

b) to solve a) [and to solve other stuff, too], we need
free_irq/request_irq all over the tree.

> > You will find such break
> > with swsusp without ACPI. Could we revert the ACPI change in Linus's
> > tree but keep it in -mm tree? So we get a chance to fix drivers.
> 
> That depends on the amount of brokenness involved: if it's significant then
> I'll get a ton of bug reports concerning something which we already know is
> broken and we'll drive away our long-suffering testers.

The amount of brokenness is not that bad, and it fixes some machines,
too.
									Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
