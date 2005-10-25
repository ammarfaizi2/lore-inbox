Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVJYRXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVJYRXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVJYRXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:23:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:15248 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932219AbVJYRXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:23:33 -0400
Date: Tue, 25 Oct 2005 10:22:54 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       rob@janerob.com, akpm@osdl.org
Subject: Re: [PATCH] ohci1394 PCI fixup for Toshiba laptops
Message-ID: <20051025172254.GA20644@kroah.com>
References: <200510241857.33257.jbarnes@virtuousgeek.org> <435DD86F.3090702@s5r6.in-berlin.de> <200510251019.16727.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510251019.16727.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 10:19:16AM -0700, Jesse Barnes wrote:
> On Tuesday, October 25, 2005 12:02 am, Stefan Richter wrote:
> > Jesse Barnes wrote:
> > > +static void __devinit pci_post_fixup_toshiba_ohci1394(struct
> > > pci_dev *dev) +{
> > > +	if (dmi_check_system(toshiba_ohci1394_dmi_table))
> > > +		return; /* only applies to certain Toshibas (so far) */
> > > +
> > > +	/* Restore config space on Toshiba laptops */
> > > +	mdelay(10);
> > > +	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE,
> > > toshiba_line_size);
> >
> > Shouldn't this read
> >
> >          if (!dmi_check_system(toshiba_ohci1394_dmi_table))
> >                  return;
> >              ^ ?
> >
> > dmi_check_system returns the number of matches.
> 
> Doh!  Yes, it should be (I tested an earlier version, then decided to 
> reverse the logic and return, oops).
> 
> Here's an updated version.
> 
> Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Care to resend with the full changelog information too, so I can apply
it?

thanks,

greg k-h
