Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWFHRJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWFHRJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 13:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWFHRJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 13:09:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50192 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964907AbWFHRJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 13:09:31 -0400
Date: Thu, 8 Jun 2006 18:09:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Pavel Machek <pavel@suse.cz>, David Brownell <david-b@pacbell.net>,
       lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       Oliver Neukum <oliver@neukum.org>,
       David Liontooth <liontooth@cogweb.net>
Subject: Re: [PATCH] limit power budget on spitz
Message-ID: <20060608170913.GB15337@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Pavel Machek <pavel@suse.cz>, David Brownell <david-b@pacbell.net>,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net,
	Oliver Neukum <oliver@neukum.org>,
	David Liontooth <liontooth@cogweb.net>
References: <447EB0DC.4040203@cogweb.net> <20060530200134.GB4074@ucw.cz> <200606031129.54580.oliver@neukum.org> <200606050732.53496.david-b@pacbell.net> <20060608083412.GJ3688@elf.ucw.cz> <1149756659.16945.149.camel@localhost.localdomain> <20060608090230.GM3688@elf.ucw.cz> <1149758570.16945.156.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149758570.16945.156.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 10:22:50AM +0100, Richard Purdie wrote:
> Hi,
> 
> On Thu, 2006-06-08 at 11:02 +0200, Pavel Machek wrote:
> > > > +	if (machine_is_spitz()) {
> > > > +		/* Warning, not coming from any official docs. But
> > > > +		 * spitz is unable to properly power wireless card
> > > > +		 * claiming 500mA -- usb interface work but wireless
> > > > +		 * does not. */
> > > > +		hcd->power_budget = 250;
> > > > +	}
> > >
> > > 
> > > Should this value not be specified by the platform in the platform data
> > > rather than a set of machine_is_xxx statements in the driver itself? I
> > > already put most of the infrastructure for that into place.
> > 
> > Well, it has quite few users now, and this is how it works in
> > ohci-omap. Yes, if we get more of such hooks, it probably needs to be
> > moved to platform data...
> 
> Just because the omap does it that way, doesn't mean it can't be done
> better ;-). I've also just realised the above doesn't account for akita
> or borzoi. Since the hardware is identical in this area, the same
> changes should be applied for those machines. If we use the platform
> device/data approach, we don't have this problem as they all use the
> same platform device :)

So what do folk want me to do?  Blindly merge the patch (hint: it's still
in the incoming queue...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
