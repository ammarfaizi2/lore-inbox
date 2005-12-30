Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVL3XR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVL3XR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVL3XR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:17:56 -0500
Received: from mx.pathscale.com ([64.160.42.68]:61594 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751174AbVL3XRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:17:55 -0500
Subject: Re: [PATCH 11 of 20] ipath - core driver, part 4 of 4
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051230081218.GB7438@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <e8af3873b0d910e0c623.1135816290@eng-12.pathscale.com>
	 <20051230081218.GB7438@kroah.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 30 Dec 2005 15:17:55 -0800
Message-Id: <1135984675.13318.58.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 00:12 -0800, Greg KH wrote:

> This has grown
> into a huge file, can't you split it up into smaller pieces?

Absolutely.

> Why even save off the return value if you don't do anything with it?

I think that's just a throwback to an earlier rev of the driver.

> And please don't put assignments in the middle of if statements, that's
> just messy and harder to read (the fact that gcc made you put an extra
> () should be a hint that you were doing something wrong...)

OK.

> And does your driver work with udev?  I didn't see where you were
> exporting the major:minor number of your devices to sysfs, but I might
> have missed it.

It was written in a pre-udev world, so it still uses a fixed major and
minor number.  How important is this to you?  Is it "nice to have", or
"blocker"? :-)

> Are you sure that's a good idea?  Please do the proper thing and tear
> down your infrastructure if something fails, that's the correct thing to
> do.  That way you can actually recover if something that you call in
> this function fails (like driver_create_file(), or
> pci_register_driver().) Functions don't return error values just so you
> can ignore them :)

This will take a bit of cleaning up, but it's a reasonable request.

> > +/*
> > + * note: if for some reason the unload fails after this routine, and leaves
> > + * the driver enterable by user code, we'll almost certainly crash and burn...
> > + */
> 
> See, you admit that what you are doing isn't the wisest thing, which
> should tell you something...

Indeed.

> This is the call that should have cleaned up all of the memory and other
> stuff that you do above.  If not, then your driver will not work in any
> hotplug pci systems, which would not be a good thing.  Please do like
> Roland says and put your resources and stuff in the device specific
> structures, like the rest of the kernel drivers do.

I'm working on the appropriate hearts and minds as we speak :-)

> Why not just export ipath_ht_get_boardname instead?

Because that's too specific to HT for my personal liking.

> > +module_init(infinipath_init);
> > +module_exit(infinipath_cleanup);
> > +
> > +EXPORT_SYMBOL(infinipath_debug);
> > +EXPORT_SYMBOL(ipath_get_boardname);
> 
> EXPORT_SYMBOL_GPL() ?

I don't see a problem with that.

> And put them next to the functions themselves, it's easier to notice
> that way.

OK.

Thanks again for the review,

	<b

