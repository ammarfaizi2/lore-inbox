Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbULPJXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbULPJXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 04:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbULPJXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 04:23:13 -0500
Received: from ltgp.iram.es ([150.214.224.138]:31616 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S261899AbULPJXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 04:23:06 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 16 Dec 2004 10:10:32 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Message-ID: <20041216091032.GA9774@iram.es>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <41BD483B.1000704@suse.de> <20041213135820.A24748@flint.arm.linux.org.uk> <1102949565.2687.2.camel@localhost.localdomain> <1102983378.9865.11.camel@orbiter> <1103133841.3180.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103133841.3180.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 06:04:03PM +0000, Alan Cox wrote:
> On Maw, 2004-12-14 at 00:16, Eric St-Laurent wrote:
> > Alan,
> > 
> > On a related subject, a few months ago you posted a patch which added a
> > nice add_timeout()/timeout_pending() API and converted many (if not
> > most) drivers to use it.
> > 
> > If I remember correctly it did not generate much comments and the work
> > was not pushed into mainline.
> > 
> > I think it's a nice cleanup, IMHO the time_(before|after)(jiffies, ...)
> > construct is horrible.
> > 
> > Any chance to resurrect this work ?
> 
> I plan to ressurect it when I have a little time but with some small
> additions from the original work. Several people said "it should be mS
> not HZ" and someone at OLS proposed that the API also includes an
> accuracy guide so that systems using programmed wakeups can aggregate
> timers when accuracy doesn't matter.

I suspect people who want to push HZ to 10000 won't be happy with
milliseconds since it would not give them a resolution of one jiffy.

So the options are:
1) microseconds, allows up to roughly half an hour (signed) 
   or an hour (unsigned).
2) nanoseconds, needs 64 bits, nice for 64 bit machines but 
   at the risk of bloat on 32 bit ones.
3) timespecs, somewhat wasteful on 64 bit machines (two longs).

I believe 1) is the best compromise.

	Regards,
	Gabriel
