Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWFHJDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWFHJDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 05:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWFHJDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 05:03:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51437 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751300AbWFHJDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 05:03:21 -0400
Date: Thu, 8 Jun 2006 11:02:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: David Brownell <david-b@pacbell.net>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, patches@arm.linux.org.uk,
       linux-usb-devel@lists.sourceforge.net,
       Oliver Neukum <oliver@neukum.org>,
       David Liontooth <liontooth@cogweb.net>
Subject: Re: [PATCH] limit power budget on spitz
Message-ID: <20060608090230.GM3688@elf.ucw.cz>
References: <447EB0DC.4040203@cogweb.net> <20060530200134.GB4074@ucw.cz> <200606031129.54580.oliver@neukum.org> <200606050732.53496.david-b@pacbell.net> <20060608083412.GJ3688@elf.ucw.cz> <1149756659.16945.149.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149756659.16945.149.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
> > index acde886..1d8b58c 100644
> > --- a/drivers/usb/host/ohci-pxa27x.c
> > +++ b/drivers/usb/host/ohci-pxa27x.c
> > @@ -185,6 +185,13 @@ int usb_hcd_pxa27x_probe (const struct h
> >  	/* Select Power Management Mode */
> >  	pxa27x_ohci_select_pmm(inf->port_mode);
> >  
> > +	if (machine_is_spitz()) {
> > +		/* Warning, not coming from any official docs. But
> > +		 * spitz is unable to properly power wireless card
> > +		 * claiming 500mA -- usb interface work but wireless
> > +		 * does not. */
> > +		hcd->power_budget = 250;
> > +	}
> >  	ohci_hcd_init(hcd_to_ohci(hcd));
> >  
> >  	retval = usb_add_hcd(hcd, pdev->resource[1].start, SA_INTERRUPT);
> 
> Should this value not be specified by the platform in the platform data
> rather than a set of machine_is_xxx statements in the driver itself? I
> already put most of the infrastructure for that into place.

Well, it has quite few users now, and this is how it works in
ohci-omap. Yes, if we get more of such hooks, it probably needs to be
moved to platform data...

> I also strongly suspect the power supply on the device is limited to
> 150mA.

Thanks!
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
