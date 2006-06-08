Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWFHJXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWFHJXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 05:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWFHJXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 05:23:41 -0400
Received: from tim.rpsys.net ([194.106.48.114]:54194 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964796AbWFHJXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 05:23:40 -0400
Subject: Re: [PATCH] limit power budget on spitz
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: David Brownell <david-b@pacbell.net>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       Oliver Neukum <oliver@neukum.org>,
       David Liontooth <liontooth@cogweb.net>
In-Reply-To: <20060608090230.GM3688@elf.ucw.cz>
References: <447EB0DC.4040203@cogweb.net> <20060530200134.GB4074@ucw.cz>
	 <200606031129.54580.oliver@neukum.org>
	 <200606050732.53496.david-b@pacbell.net> <20060608083412.GJ3688@elf.ucw.cz>
	 <1149756659.16945.149.camel@localhost.localdomain>
	 <20060608090230.GM3688@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 10:22:50 +0100
Message-Id: <1149758570.16945.156.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-06-08 at 11:02 +0200, Pavel Machek wrote:
> > > +	if (machine_is_spitz()) {
> > > +		/* Warning, not coming from any official docs. But
> > > +		 * spitz is unable to properly power wireless card
> > > +		 * claiming 500mA -- usb interface work but wireless
> > > +		 * does not. */
> > > +		hcd->power_budget = 250;
> > > +	}
> >
> > 
> > Should this value not be specified by the platform in the platform data
> > rather than a set of machine_is_xxx statements in the driver itself? I
> > already put most of the infrastructure for that into place.
> 
> Well, it has quite few users now, and this is how it works in
> ohci-omap. Yes, if we get more of such hooks, it probably needs to be
> moved to platform data...

Just because the omap does it that way, doesn't mean it can't be done
better ;-). I've also just realised the above doesn't account for akita
or borzoi. Since the hardware is identical in this area, the same
changes should be applied for those machines. If we use the platform
device/data approach, we don't have this problem as they all use the
same platform device :)

I can't create a patch at the moment but I can have a look at this
later...

Cheers,

Richard

