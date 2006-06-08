Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWFHS0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWFHS0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWFHS0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:26:23 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:33132 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964926AbWFHS0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:26:23 -0400
From: David Brownell <david-b@pacbell.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] limit power budget on spitz
Date: Thu, 8 Jun 2006 11:26:18 -0700
User-Agent: KMail/1.7.1
Cc: Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@suse.cz>,
       lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       Oliver Neukum <oliver@neukum.org>,
       David Liontooth <liontooth@cogweb.net>
References: <447EB0DC.4040203@cogweb.net> <1149758570.16945.156.camel@localhost.localdomain> <20060608170913.GB15337@flint.arm.linux.org.uk>
In-Reply-To: <20060608170913.GB15337@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081126.20142.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 10:09 am, Russell King wrote:
> On Thu, Jun 08, 2006 at 10:22:50AM +0100, Richard Purdie wrote:
> > Hi,
> > 
> > On Thu, 2006-06-08 at 11:02 +0200, Pavel Machek wrote:
> > > > > +	if (machine_is_spitz()) {
> > > > > +		/* Warning, not coming from any official docs. But
> > > > > +		 * spitz is unable to properly power wireless card
> > > > > +		 * claiming 500mA -- usb interface work but wireless
> > > > > +		 * does not. */
> > > > > +		hcd->power_budget = 250;
> > > > > +	}
> > > >
> > > > 
> > > > Should this value not be specified by the platform in the platform data
> > > > rather than a set of machine_is_xxx statements in the driver itself? I
> > > > already put most of the infrastructure for that into place.
> > > 
> > > Well, it has quite few users now, and this is how it works in
> > > ohci-omap. Yes, if we get more of such hooks, it probably needs to be
> > > moved to platform data...
> > 
> > Just because the omap does it that way, doesn't mean it can't be done
> > better ;-).

Agreed that platform_data is a better approach overall for holding that
power budget.  OMAP and AT91 should do so too.


> > I've also just realised the above doesn't account for akita 
> > or borzoi. Since the hardware is identical in this area, the same
> > changes should be applied for those machines. If we use the platform
> > device/data approach, we don't have this problem as they all use the
> > same platform device :)
> 
> So what do folk want me to do?  Blindly merge the patch (hint: it's still
> in the incoming queue...)

Sounds like someone should update the patch to (a) use a 150 mA budget,
and (b) test for those other machines.  As a near term patch, anyway.

Unless there's a patch to provide and use platform_data ... but that'd
be much more involved, since ISTR the PXA platforms don't yet have a
mechanism to provide board-specific platform_data.  (I'll suggest the
AT91 code as a model there; it's simpler hardware than OMAP, so the
code is more straightforward.)

- Dave


