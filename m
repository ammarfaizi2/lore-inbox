Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVHAVfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVHAVfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVHAVdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:33:18 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:1417 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261292AbVHAVc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:32:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: revert yenta free_irq on suspend
Date: Mon, 1 Aug 2005 23:38:09 +0200
User-Agent: KMail/1.8.1
Cc: Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       ambx1@neo.rr.com, torvalds@osdl.org, pavel@ucw.cz, hugh@veritas.com,
       linux@dominikbrodowski.net, daniel.ritz@gmx.ch, len.brown@intel.com
References: <2e00842e116e.2e116e2e0084@columbus.rr.com> <1122861542.2953.8.camel@linux-hp.sh.intel.com> <20050731190645.748f57e9.akpm@osdl.org>
In-Reply-To: <20050731190645.748f57e9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508012338.10473.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 1 of August 2005 04:06, Andrew Morton wrote:
> Shaohua Li <shaohua.li@intel.com> wrote:
> >
> > Hi,
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
> 
> > You will find such break
> > with swsusp without ACPI. Could we revert the ACPI change in Linus's
> > tree but keep it in -mm tree? So we get a chance to fix drivers.
> 
> That depends on the amount of brokenness involved: if it's significant then
> I'll get a ton of bug reports concerning something which we already know is
> broken and we'll drive away our long-suffering testers.

Well, IMO there's no such danger.  ;-)  The relevent ACPI change has
been in -mm since 2.6.12-rc1-mm1 and _nobody_ except for me has reported
_any_ problems with it. :-)

OTOH, if the change is kept in -mm, we hopefully will be able to identify
the drivers that need to be converted first, on the basis of the bug reports.

And the testers need not be driven away if the issues they report are fixed
in a timely manner, which is quite simple in this particuar case, because we
know what's potentially broken, we know how to fix it, and the fix is quite not
that complicated.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
