Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVFCTau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVFCTau (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVFCTat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:30:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:41671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261341AbVFCTaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:30:07 -0400
Date: Fri, 3 Jun 2005 12:29:53 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050603192953.GA7435@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3A9@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3A9@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 02:00:37PM -0500, Abhay_Salunke@Dell.com wrote:
> > > >
> > > > No no no.  Just because you are using the firmware interface, does
> not
> > > > mean you need to add this extra round-trip to the whole system.
> Just
> > > > dump the firmware to the /sys/firmware/whatever... file whenever
> you
> > > > want to, that's all that is needed.  No hotplug stuff, no filename
> > > > stuff, just a simple copy.
> > > Greg, all the feedback gave the impression that request_firmwae
> hotplug
> > > stuff was the way to go.
> > 
> > It is the way to go.
> > 
> > > Seems it's not required!
> > 
> > Not at all, why do you think I mean that?
> I meant this driver does not need hotplug per say and just a copy should
> be enough (if we decide to go with bin attribute for data file).

But the firmware code handles the memory stuff that you duplicated
already.  That's a big win too.

> > > Now that means it needs to be done the way it was before except that
> > > it needs to have a bin attribute for data and a normal attribute for
> > > size.  This would be even better as it makes it easy to read back
> the
> > > data.
> > 
> > No, you can still use the firmware core code, that's what it is there
> > for.  But don't mess with the "make the user provide a filename"
> stuff.
> > Just have your driver create the firmware request and then relax.
> Your
> > code will get called when the firware is written to, right?  That's
> all
> > you need.
> > 
> At what point I should be calling request_firmware?

Never, you should call request_firmware_nowait() instead.  And do it
from your module init function.

> As my driver does
> not have any entry points. In this driver it is called when the user is
> ready to download the firmware image (when it echoes the firmware image
> name). Also the driver needs to be resident for handling multiple such
> requests; that's why cannot do this at driver init time.

That's what request_firmware_nowait() is for.

> When ever the user echoes the file name, it gets passed on to
> request_firmware and the $FIRMWARE env gets populated with the file
> name. thus making the hotplug code to automatically load the image which
> is passed back as fw->data and fw->size. 

It's easier for the user to just copy the firmware to the sysfs file
whenever they want to.  No messing with hotplug events or filenames.

thanks,

greg k-h
